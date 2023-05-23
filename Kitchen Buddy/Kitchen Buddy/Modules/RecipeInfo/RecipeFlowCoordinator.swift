//
//  RecipeFlowCoordinator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 29.04.2023.
//

import UIKit
import Swinject

// MARK: - RecipeFlowCoordinator
final class RecipeFlowCoordinator: FlowCoordinatorProtocol {
    private var resolver: Resolver
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    private weak var navigationController: UINavigationController?
    private var finishHandlers: [(() -> Void)] = []
    
    init(navigationController: UINavigationController?, resolver: Resolver, finishHandler: @escaping (() -> Void)) {
        self.navigationController = navigationController
        self.resolver = resolver
        finishHandlers.append(finishHandler)
    }
    
    func start(animated: Bool) {
        showRecipeInfo()
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)
        
        childCoordinators.finishAll(animated: animated, completion: nil)
    }
    
    func closeModule() {
        for handler in finishHandlers {
            handler()
        }
    }
}

extension RecipeFlowCoordinator: RecipeInfoModuleOutput {
    func showRecipeInfo() {
        let recipeInfoBuilder = RecipeInfoBuilder(
            resolver: resolver,
            moduleOutput: self
        )
        let viewController = recipeInfoBuilder.build()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func moduleDidUnload() {
        finishHandlers.forEach { $0() }
    }
    
    func viewDidPop(animated: Bool, completion: (() -> Void)?) {
        if navigationController?.viewControllers.count == 2 {
            finish(animated: false, completion: completion)
        } 
    }
}

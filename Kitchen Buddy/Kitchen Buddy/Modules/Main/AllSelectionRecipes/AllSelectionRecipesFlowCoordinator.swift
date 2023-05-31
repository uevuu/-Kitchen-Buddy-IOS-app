//
//  AllSelectionRecipesFlowCoordinator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 30.04.2023.
//

import UIKit
import Swinject

// MARK: - AllSelectionRecipesFlowCoordinator
final class AllSelectionRecipesFlowCoordinator: FlowCoordinatorProtocol {
    private var resolver: Resolver
    private weak var navigationController: UINavigationController?
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    private var finishHandlers: [(() -> Void)] = []
    
    init(navigationController: UINavigationController?, resolver: Resolver, finishHandler: @escaping (() -> Void)) {
        self.navigationController = navigationController
        self.resolver = resolver
        finishHandlers.append(finishHandler)
    }
    
    func start(animated: Bool) {
        showRecipesFromSelection()
    }
    
    func showRecipesFromSelection() {
        let allSelectionRecipesBuilder = AllSelectionRecipesBuilder(
            resolver: resolver,
            moduleOutput: self
        )
        let viewController = allSelectionRecipesBuilder.build()
        navigationController?.pushViewController(viewController, animated: true)
    }
        
    func finish(animated: Bool, completion: (() -> Void)?) {
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)
        
        childCoordinators.finishAll(animated: animated, completion: nil)
    }
}

extension AllSelectionRecipesFlowCoordinator: AllSelectionRecipesModuleOutput {
    func showRecipeInfo(id: Int) {
        let recipeFlowCoordinator = RecipeFlowCoordinator(
            recipeId: id,
            navigationController: navigationController,
            resolver: resolver
        ) { [weak self] in
            self?.childCoordinators.removeFlowCoordinator(ofType: RecipeFlowCoordinator.self)
        }
        recipeFlowCoordinator.start(animated: true)
        childCoordinators.append(recipeFlowCoordinator)
    }
    
    func viewDidPop(animated: Bool, completion: (() -> Void)?) {
        navigationController?.popViewController(animated: true)
        finish(animated: animated, completion: completion)
    }
    
    func moduleDidUnload() {
        finishHandlers.forEach { $0() }
    }
}

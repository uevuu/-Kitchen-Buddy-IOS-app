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
    var onFinish: (() -> Void)?
    
    init(navigationController: UINavigationController?, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
    }
    
    func start(animated: Bool) {
        showRecipeInfo()
    }
    
    func finish(animated: Bool) {
        childCoordinators.forEach { coordinator in
            coordinator.finish(animated: false)
        }
        childCoordinators.removeAll()
        onFinish?()
    }
}

extension RecipeFlowCoordinator: RecipeInfoModuleOutput {
    func goToPreviousModule() {
        finish(animated: false)
    }
    
    func showRecipeInfo() {
        let recipeInfoBuilder = RecipeInfoBuilder(
            resolver: resolver,
            moduleOutput: self
        )
        let viewController = recipeInfoBuilder.build()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

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
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    private weak var navigationController: UINavigationController?
    var onFinish: (() -> Void)?
    
    init(navigationController: UINavigationController?, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
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
        
    func finish(animated: Bool) {
        childCoordinators.forEach { coordinator in
            coordinator.finish(animated: false)
        }
        childCoordinators.removeAll()
        onFinish?()
    }
}

extension AllSelectionRecipesFlowCoordinator: AllSelectionRecipesModuleOutput {
    func showRecipeInfo() {
        let recipeFlowCoordinator = RecipeFlowCoordinator(
            navigationController: navigationController,
            resolver: resolver
        )
        recipeFlowCoordinator.start(animated: true)
        childCoordinators.append(recipeFlowCoordinator)
    }
}

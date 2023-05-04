//
//  MainFlowCoordinator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 14.04.2023.
//

import UIKit
import Swinject

// MARK: - MainFlowCoordinator
final class MainFlowCoordinator: FlowCoordinatorProtocol {
    private var resolver: Resolver
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    private weak var parentTabBarController: UITabBarController?
    private weak var navigationController: UINavigationController?
    
    init(tabBarController: UITabBarController, resolver: Resolver) {
        self.parentTabBarController = tabBarController
        self.resolver = resolver
    }
    
    func start(animated: Bool) {
        showMain()
    }
    
    func showMain() {
        let mainBuilder = MainBuilder(
            resolver: resolver,
            moduleOutput: self
        )
        let viewController = mainBuilder.build()
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController
        parentTabBarController?.addViewController(
            viewController: navigationController,
            title: "Main",
            image: UIImage(systemName: "house")
        )
    }
    
    func finish(animated: Bool) {
        childCoordinators.forEach { coordinator in
            coordinator.finish(animated: false)
        }
        childCoordinators.removeAll()
    }
    
    func childCoordinatorDidFinish(_ coordinator: FlowCoordinatorProtocol) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}

// MARK: - MainModuleOutput
extension MainFlowCoordinator: MainModuleOutput {
    func showAllWinesThisSort() {
        let winesFlowCoordinator = WinesFlowCoordinator(
            navigationController: navigationController,
            resolver: resolver
        )
        winesFlowCoordinator.start(animated: true)
        print(childCoordinators.count)
        childCoordinators.append(winesFlowCoordinator)
    }
    
    func showRecipeInfo() {
        let recipeFlowCoordinator = RecipeFlowCoordinator(
            navigationController: navigationController,
            resolver: resolver
        )
        recipeFlowCoordinator.onFinish = { [weak self] in
            self?.childCoordinatorDidFinish(recipeFlowCoordinator)
        }
        recipeFlowCoordinator.start(animated: true)
        childCoordinators.append(recipeFlowCoordinator)
    }
    
    func showAllSelectionRecipes() {
        let allSelectionRecipesFlowCoordinator = AllSelectionRecipesFlowCoordinator(
            navigationController: navigationController,
            resolver: resolver
        )
        allSelectionRecipesFlowCoordinator.start(animated: true)
        childCoordinators.append(allSelectionRecipesFlowCoordinator)
    }
    
    func showSettings() {
        print("show setting")
    }
}

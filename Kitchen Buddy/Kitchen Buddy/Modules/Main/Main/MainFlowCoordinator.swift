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
        let mainBuilder = MainBuilder(resolver, self)
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
}

extension MainFlowCoordinator: MainModuleOutput {
    func showAllWinesThisSort() {
        let winesFlowCoordinator = WinesFlowCoordinator(
            navigationController: navigationController,
            resolver: resolver
        )
        winesFlowCoordinator.start(animated: true)
        childCoordinators.append(winesFlowCoordinator)
    }
    
    func showRecipeInfo() {
        let recipeFlowCoordinator = RecipeFlowCoordinator(
            navigationController: navigationController,
            resolver: resolver
        )
        recipeFlowCoordinator.start(animated: true)
        childCoordinators.append(recipeFlowCoordinator)
    }
    
    func showAllSelectionRecipes() {
        print(childCoordinators.count)
    }
    
    func showSettings() {
        print("show setting")
    }
}

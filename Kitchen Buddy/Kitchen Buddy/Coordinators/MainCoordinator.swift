//
//  MainCoordinator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 14.04.2023.
//

import UIKit
import Swinject

// MARK: - MainCoordinatorProtocol
protocol MainCoordinatorProtocol: Coordinator {
    func showAllSelectionRecipes()
    func showAllWinesSort()
    func showRecipe()
}

// MARK: - MainCoordinator
final class MainCoordinator: MainCoordinatorProtocol {
    var serviceLocator: ServiceLocator
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(_ tabBarController: UITabBarController, _ serviceLocator: ServiceLocator) {
        let mainNavigationController = UINavigationController()
        tabBarController.viewControllers = [mainNavigationController]
        self.navigationController = mainNavigationController
        self.serviceLocator = serviceLocator
    }
    
    func start() {
        let mainBuilder = MainBuilder(serviceLocator)
        let viewController = mainBuilder.build()
        navigationController.tabBarItem.title = "Main"
        navigationController.tabBarItem.image = UIImage(systemName: "house")
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showAllSelectionRecipes() {
    }
    
    func showAllWinesSort() {
    }
    
    func showRecipe() {
    }
}

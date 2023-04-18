//
//  FavouriteCoordinator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 14.04.2023.
//

import UIKit

// MARK: - MainCoordinatorProtocol
protocol FavouriteCoordinatorProtocol: Coordinator {
}

// MARK: - MainCoordinator
final class FavouriteCoordinator: FavouriteCoordinatorProtocol {
    var serviceLocator: ServiceLocator
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(_ tabBarController: UITabBarController, _ serviceLocator: ServiceLocator) {
        let favouriteNavigationController = UINavigationController()
        tabBarController.viewControllers?.append(favouriteNavigationController)
        self.navigationController = favouriteNavigationController
        self.serviceLocator = serviceLocator
    }
    
    func start() {
        navigationController.tabBarItem.title = "Favourite"
        navigationController.tabBarItem.image = UIImage(systemName: "star")
        navigationController.setViewControllers([ViewController()], animated: false)
    }
}

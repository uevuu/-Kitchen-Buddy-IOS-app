//
//  SearchCoordinator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 14.04.2023.
//

import UIKit

// MARK: - MainCoordinatorProtocol
protocol SearchCoordinatorProtocol: Coordinator {
    func showFilter()
}

// MARK: - MainCoordinator
final class SearchCoordinator: SearchCoordinatorProtocol {
    var serviceLocator: ServiceLocator
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(_ tabBarController: UITabBarController, _ serviceLocator: ServiceLocator) {
        let searchNavigationController = UINavigationController()
        tabBarController.viewControllers?.append(searchNavigationController)
        self.navigationController = searchNavigationController
        self.serviceLocator = serviceLocator
    }
    
    func start() {
        navigationController.tabBarItem.title = "Search"
        navigationController.tabBarItem.image = UIImage(systemName: "house")
        navigationController.setViewControllers([ViewController()], animated: false)
    }
    
    func showFilter() {
    }
}

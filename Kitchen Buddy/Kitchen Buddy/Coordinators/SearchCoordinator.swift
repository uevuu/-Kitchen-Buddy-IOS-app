//
//  SearchCoordinator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 14.04.2023.
//

import UIKit
import Swinject

// MARK: - MainCoordinatorProtocol
protocol SearchCoordinatorProtocol: FlowCoordinatorProtocol {
    func showFilter()
}

// MARK: - MainCoordinator
final class SearchCoordinator: SearchCoordinatorProtocol {
    private var resolver: Resolver
    private var parentTabBarController: UITabBarController
    private var navigationController = UINavigationController()
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    
    init(tabBarController: UITabBarController, resolver: Resolver) {
        self.parentTabBarController = tabBarController
        self.resolver = resolver
    }
    
    func start(animated: Bool) {
        parentTabBarController.viewControllers?.append(navigationController)
        navigationController.tabBarItem.title = "Search"
        navigationController.tabBarItem.image = UIImage(systemName: "house")
        navigationController.setViewControllers([ViewController()], animated: false)
    }
    
    func finish(animated: Bool) {
        childCoordinators.forEach { coordinator in
            coordinator.finish(animated: false)
        }
        childCoordinators.removeAll()
    }
    
    func showFilter() {
    }
}

//
//  SearchCoordinator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 14.04.2023.
//

import UIKit
import Swinject

// MARK: - MainCoordinator
final class SearchFlowCoordinator: FlowCoordinatorProtocol {
    private var resolver: Resolver
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    private weak var parentTabBarController: UITabBarController?
    private weak var navigationController: UINavigationController?
    
    init(tabBarController: UITabBarController, resolver: Resolver) {
        self.parentTabBarController = tabBarController
        self.resolver = resolver
    }
    
    func start(animated: Bool) {
        let navigationController = UINavigationController()
        self.navigationController = navigationController
        parentTabBarController?.viewControllers?.append(navigationController)
        navigationController.tabBarItem.title = "Search"
        navigationController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
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

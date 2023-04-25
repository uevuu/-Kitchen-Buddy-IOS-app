//
//  FavouriteCoordinator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 14.04.2023.
//

import UIKit
import Swinject

// MARK: - MainCoordinator
final class FavouriteCoordinator: FlowCoordinatorProtocol {
    private var resolver: Resolver
    private weak var parentTabBarController: UITabBarController?
    private var navigationController = UINavigationController()
    private var childCoordinators: [FlowCoordinatorProtocol]?
    
    init(tabBarController: UITabBarController, resolver: Resolver) {
        self.parentTabBarController = tabBarController
        self.resolver = resolver
    }
    
    func start(animated: Bool) {
        childCoordinators = []
        parentTabBarController?.viewControllers?.append(navigationController)
        navigationController.tabBarItem.title = "Favourite"
        navigationController.tabBarItem.image = UIImage(systemName: "star")
        navigationController.setViewControllers([ViewController()], animated: false)
    }
    
    func finish(animated: Bool) {
        childCoordinators?.forEach { coordinator in
            coordinator.finish(animated: false)
        }
        childCoordinators?.removeAll()
    }
}

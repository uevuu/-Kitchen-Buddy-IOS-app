//
//  TabBarCoordinator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 14.04.2023.
//

import UIKit
import Swinject

// MARK: - TabBarCoordinatorProtocol
protocol TabBarCoordinatorProtocol: FlowCoordinatorProtocol {
    init(window: UIWindow, resolver: Resolver)
}

// MARK: - TabBarCoordinator
final class TabBarCoordinator: TabBarCoordinatorProtocol {
    private var tabBarController = UITabBarController()
    private var window: UIWindow
    private var resolver: Resolver
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    
    init(window: UIWindow, resolver: Resolver) {
        self.window = window
        self.resolver = resolver
    }
    
    func start(animated: Bool) {
        window.rootViewController = tabBarController
        let mainCoordinator = MainCoordinator(tabBarController: tabBarController, resolver: resolver)
        let searchCoordinator = SearchCoordinator(tabBarController: tabBarController, resolver: resolver)
        let favouriteCoordinator = FavouriteCoordinator(tabBarController: tabBarController, resolver: resolver)
        mainCoordinator.start(animated: false)
        searchCoordinator.start(animated: false)
        favouriteCoordinator.start(animated: false)
        childCoordinators.append(mainCoordinator)
        childCoordinators.append(searchCoordinator)
        childCoordinators.append(favouriteCoordinator)
    }
    
    func finish(animated: Bool) {
        childCoordinators.forEach { coordinator in
            coordinator.finish(animated: false)
        }
        childCoordinators.removeAll()
    }
}

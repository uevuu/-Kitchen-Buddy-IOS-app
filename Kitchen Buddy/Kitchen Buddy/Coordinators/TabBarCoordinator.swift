//
//  TabBarCoordinator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 14.04.2023.
//

import UIKit
import Swinject

// MARK: - TabBarCoordinatorProtocol
protocol TabBarCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
    init(window: UIWindow, serviceLocator: ServiceLocator)
}

// MARK: - TabBarCoordinator
final class TabBarCoordinator: TabBarCoordinatorProtocol {
    var serviceLocator: ServiceLocator
    var tabBarController: UITabBarController
    var childCoordinators: [Coordinator] = []
    
    init(window: UIWindow, serviceLocator: ServiceLocator) {
        let tabBarController = UITabBarController()
        window.rootViewController = tabBarController
        self.tabBarController = tabBarController
        self.serviceLocator = serviceLocator
    }
    
    func start() {
        let mainCoordinator = MainCoordinator(tabBarController, serviceLocator)
        let searchCoordinator = SearchCoordinator(tabBarController, serviceLocator)
        let favouriteCoordinator = FavouriteCoordinator(tabBarController, serviceLocator)
        mainCoordinator.start()
        searchCoordinator.start()
        favouriteCoordinator.start()
        childCoordinators.append(mainCoordinator)
        childCoordinators.append(searchCoordinator)
        childCoordinators.append(favouriteCoordinator)
    }
}

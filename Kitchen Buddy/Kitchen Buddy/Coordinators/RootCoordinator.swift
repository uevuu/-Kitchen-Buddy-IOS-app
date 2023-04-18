//
//  AppCoordinator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 14.04.2023.
//

import UIKit

// MARK: - AppCoordinatorProtocol
protocol AppCoordinatorProtocol: Coordinator {
    init(window: UIWindow, serviceLocator: ServiceLocator)
    func showLoginFlow()
    func showMainFlow()
}

// MARK: - AppCoordinator
final class RootCoordinator: AppCoordinatorProtocol {
    var window: UIWindow
    var serviceLocator: ServiceLocator
    var childCoordinators: [Coordinator] = []
    
    init(window: UIWindow, serviceLocator: ServiceLocator) {
        self.window = window
        self.serviceLocator = serviceLocator
    }
    
    func start() {
        window.makeKeyAndVisible()
        showMainFlow()
    }
    
    func showLoginFlow() {
//        Авторизация будет позже
    }
    
    func showMainFlow() {
        let tabBarCoordinator = TabBarCoordinator(window: window, serviceLocator: serviceLocator)
        tabBarCoordinator.start()
        childCoordinators.append(tabBarCoordinator)
    }
}

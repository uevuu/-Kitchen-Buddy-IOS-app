//
//  AppCoordinator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 14.04.2023.
//

import UIKit
import Swinject

// MARK: - AppCoordinatorProtocol
protocol AppCoordinatorProtocol: FlowCoordinatorProtocol {
    init(window: UIWindow, resolver: Resolver)
    func showLoginFlow()
    func showMainFlow()
}

// MARK: - AppCoordinator
final class RootCoordinator: AppCoordinatorProtocol {
    private var window: UIWindow
    private var resolver: Resolver
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    
    init(window: UIWindow, resolver: Resolver) {
        self.window = window
        self.resolver = resolver
    }
    
    func showLoginFlow() {
//        Авторизация будет позже
    }
    
    func showMainFlow() {
        let tabBarCoordinator = TabBarCoordinator(window: window, resolver: resolver)
        tabBarCoordinator.start(animated: false)
        childCoordinators.append(tabBarCoordinator)
    }
    
    func start(animated: Bool) {
        window.makeKeyAndVisible()
        showMainFlow()
    }
    
    func finish(animated: Bool) {
        childCoordinators.forEach { coordinator in
            coordinator.finish(animated: false)
        }
        childCoordinators.removeAll()
    }
}

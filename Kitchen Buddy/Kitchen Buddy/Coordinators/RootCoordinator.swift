//
//  AppCoordinator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 14.04.2023.
//

import UIKit
import Swinject

// MARK: - AppCoordinator
final class RootCoordinator: FlowCoordinatorProtocol {
    private var window: UIWindow
    private var resolver: Resolver
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    
    init(window: UIWindow, resolver: Resolver) {
        self.window = window
        self.resolver = resolver
    }
    
    private func showLoginFlow() {
//        Авторизация будет позже
    }
    
    private func showMainFlow() {
        let tabBarCoordinator = TabBarCoordinator(window: window, resolver: resolver) { [weak self] in
            self?.childCoordinators.removeFlowCoordinator(ofType: TabBarCoordinator.self)
        }
        tabBarCoordinator.start(animated: false)
        childCoordinators.append(tabBarCoordinator)
    }
    
    func start(animated: Bool) {
        window.makeKeyAndVisible()
        showMainFlow()
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        print("GG")
    }
}

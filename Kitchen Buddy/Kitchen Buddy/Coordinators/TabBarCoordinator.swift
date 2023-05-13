//
//  TabBarCoordinator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 14.04.2023.
//

import UIKit
import Swinject

// MARK: - TabBarCoordinator
final class TabBarCoordinator: FlowCoordinatorProtocol {
    private var window: UIWindow
    private var resolver: Resolver
    private var tabBarController = UITabBarController()
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    private var finishHandlers: [(() -> Void)] = []
    
    init(window: UIWindow, resolver: Resolver, finishHandler: @escaping (() -> Void)) {
        self.window = window
        self.resolver = resolver
        finishHandlers.append(finishHandler)
    }
    
    func start(animated: Bool) {
        window.rootViewController = tabBarController
        let mainCoordinator = MainFlowCoordinator(
            tabBarController: tabBarController,
            resolver: resolver
        ) { [weak self] in
            self?.childCoordinators.removeFlowCoordinator(ofType: MainFlowCoordinator.self)
        }
        let searchCoordinator = SearchFlowCoordinator(
            tabBarController: tabBarController,
            resolver: resolver
        ) { [weak self] in
            self?.childCoordinators.removeFlowCoordinator(ofType: SearchFlowCoordinator.self)
        }
        let favouriteCoordinator = FavouriteFlowCoordinator(
            tabBarController: tabBarController,
            resolver: resolver
        ) { [weak self] in
            self?.childCoordinators.removeFlowCoordinator(ofType: FavouriteFlowCoordinator.self)
        }
        
        mainCoordinator.start(animated: false)
        searchCoordinator.start(animated: false)
        favouriteCoordinator.start(animated: false)
        childCoordinators.append(mainCoordinator)
        childCoordinators.append(searchCoordinator)
        childCoordinators.append(favouriteCoordinator)
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)
        childCoordinators.finishAll(animated: animated, completion: nil)
    }
    
    func tabBarDidUnload() {
        finishHandlers.forEach { $0() }
    }
}

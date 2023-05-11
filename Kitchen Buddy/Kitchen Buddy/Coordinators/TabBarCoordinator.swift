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
    
    init(window: UIWindow, resolver: Resolver) {
        self.window = window
        self.resolver = resolver
    }
    
    func start(animated: Bool) {
        window.rootViewController = tabBarController
        let mainCoordinator = MainFlowCoordinator(tabBarController: tabBarController, resolver: resolver)
        let searchCoordinator = SearchFlowCoordinator(tabBarController: tabBarController, resolver: resolver)
        let favouriteCoordinator = FavouriteFlowCoordinator(tabBarController: tabBarController, resolver: resolver)
        mainCoordinator.start(animated: false)
        searchCoordinator.start(animated: false)
        favouriteCoordinator.start(animated: false)
        childCoordinators.append(mainCoordinator)
        childCoordinators.append(searchCoordinator)
        childCoordinators.append(favouriteCoordinator)
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        print("finisj TabBar module")
    }
}

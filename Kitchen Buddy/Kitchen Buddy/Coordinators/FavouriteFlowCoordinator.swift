//
//  FavouriteFlowCoordinator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 14.04.2023.
//

import UIKit
import Swinject

// MARK: - FavouriteFlowCoordinator
final class FavouriteFlowCoordinator: FlowCoordinatorProtocol {
    private var resolver: Resolver
    private weak var parentTabBarController: UITabBarController?
    private weak var navigationController: UINavigationController?
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    private var finishHandlers: [(() -> Void)] = []
    
    init(tabBarController: UITabBarController, resolver: Resolver, finishHandler: @escaping (() -> Void)) {
        self.parentTabBarController = tabBarController
        self.resolver = resolver
        finishHandlers.append(finishHandler)
    }
    
    func start(animated: Bool) {
        showFavourite()
    }
    
    func showFavourite() {
        let viewController = ViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController
        parentTabBarController?.addViewController(
            viewController: viewController,
            title: "Favourite",
            image: UIImage(systemName: "star")
        )
    }
    
    func showRecipe() {
    }
    
    func showUserInfo() {
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)
        childCoordinators.finishAll(animated: animated, completion: nil)
    }
}

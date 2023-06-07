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
        let favouriteBuilder = FavouriteBuilder(
            resolver: resolver,
            moduleOutput: self
        )
        let viewController = favouriteBuilder.build()
        let navigationController = UINavigationController(rootViewController: viewController)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Asset.Colors.appBackgroundColor.color
        navigationController.navigationBar.standardAppearance = appearance
        self.navigationController = navigationController
        parentTabBarController?.addViewController(
            viewController: navigationController,
            title: L10n.Tabbar.favourite,
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

extension FavouriteFlowCoordinator: FavouriteModuleOutput {
    func showRecipeInfo(id: Int) {
        let recipeFlowCoordinator = RecipeFlowCoordinator(
            recipeId: id,
            navigationController: navigationController,
            resolver: resolver
        ) { [weak self] in
            self?.childCoordinators.removeFlowCoordinator(ofType: RecipeFlowCoordinator.self)
        }
        recipeFlowCoordinator.start(animated: true)
        childCoordinators.append(recipeFlowCoordinator)
    }
}

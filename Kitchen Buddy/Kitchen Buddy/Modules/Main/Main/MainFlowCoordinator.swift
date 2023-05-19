//
//  MainFlowCoordinator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 14.04.2023.
//

import UIKit
import Swinject

// MARK: - MainFlowCoordinator
final class MainFlowCoordinator: FlowCoordinatorProtocol {
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
        showMain()
    }
    
    func showMain() {
        let mainBuilder = MainBuilder(
            resolver: resolver,
            moduleOutput: self
        )
        let viewController = mainBuilder.build()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.barTintColor = UIColor(named: "AppBackgroundColor")
        self.navigationController = navigationController
        parentTabBarController?.addViewController(
            viewController: navigationController,
            title: "Main",
            image: UIImage(systemName: "house")
        )
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)
        childCoordinators.finishAll(animated: animated, completion: nil)
    }
}

// MARK: - MainModuleOutput
extension MainFlowCoordinator: MainModuleOutput {
    func showAllWinesThisSort() {
        let winesFlowCoordinator = WinesFlowCoordinator(
            navigationController: navigationController,
            resolver: resolver
        ) { [weak self] in
            self?.childCoordinators.removeFlowCoordinator(ofType: WinesFlowCoordinator.self)
        }
        winesFlowCoordinator.start(animated: true)
        childCoordinators.append(winesFlowCoordinator)
    }
    
    func showRecipeInfo() {        
        let recipeFlowCoordinator = RecipeFlowCoordinator(
            navigationController: navigationController,
            resolver: resolver
        ) { [weak self] in
            self?.childCoordinators.removeFlowCoordinator(ofType: RecipeFlowCoordinator.self)
        }
        recipeFlowCoordinator.start(animated: true)
        childCoordinators.append(recipeFlowCoordinator)
    }
    
    func showAllSelectionRecipes() {
        let allSelectionRecipesFlowCoordinator = AllSelectionRecipesFlowCoordinator(
            navigationController: navigationController,
            resolver: resolver
        ) { [weak self] in
            self?.childCoordinators.removeFlowCoordinator(ofType: AllSelectionRecipesFlowCoordinator.self)
        }
        allSelectionRecipesFlowCoordinator.start(animated: true)
        childCoordinators.append(allSelectionRecipesFlowCoordinator)
    }
    
    func showSettings() {
    }
}

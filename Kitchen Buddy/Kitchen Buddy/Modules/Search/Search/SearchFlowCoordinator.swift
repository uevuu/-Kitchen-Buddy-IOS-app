//
//  SearchFlowCoordinator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 14.04.2023.
//

import UIKit
import Swinject

// MARK: - SearchFlowCoordinator
final class SearchFlowCoordinator: FlowCoordinatorProtocol {
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
        showSearch()
    }
    
    func showSearch() {
        let searchBuilder = SearchBuilder(
            resolver: resolver,
            moduleOutput: self
        )
        let viewController = searchBuilder.build()
        let navigationController = UINavigationController(rootViewController: viewController)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "AppBackgroundColor")
        navigationController.navigationBar.standardAppearance = appearance
        self.navigationController = navigationController
        parentTabBarController?.addViewController(
            viewController: navigationController,
            title: "Search",
            image: UIImage(systemName: "magnifyingglass")
        )
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)
        childCoordinators.finishAll(animated: animated, completion: nil)
    }
}

// MARK: - SearchModuleOutput
extension SearchFlowCoordinator: SearchModuleOutput {
    func showFilter() {
        let filterCoordinator = FilterFlowCoordinator(
            navigationController: navigationController,
            resolver: resolver
        ) { [weak self] in
            self?.childCoordinators.removeFlowCoordinator(ofType: FilterFlowCoordinator.self)
        }
        filterCoordinator.start(animated: true)
        childCoordinators.append(filterCoordinator)
    }
    
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

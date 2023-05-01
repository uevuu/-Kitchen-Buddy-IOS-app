//
//  AllSelectionRecipesCoordinator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 30.04.2023.
//

import UIKit
import Swinject

final class AllSelectionRecipesCoordinator: FlowCoordinatorProtocol {
    private var resolver: Resolver
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
    }
    
    func start(animated: Bool) {
        showRecipesFromSelection()
    }
    
    func showRecipesFromSelection() {
        // Будет let viewController = someBuilder.build()
        let viewController = ViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showRecipe() {
        // Будет let viewController = someBuilder.build()
        let viewController = ViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func finish(animated: Bool) {
        childCoordinators.forEach { coordinator in
            coordinator.finish(animated: false)
        }
        childCoordinators.removeAll()
    }
}

//
//  WinesFlowCoordinator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 29.04.2023.
//

import UIKit
import Swinject

final class WinesFlowCoordinator: FlowCoordinatorProtocol {
    private var resolver: Resolver
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
    }
    
    func start(animated: Bool) {
        showWines()
    }
    
    func showWines() {
        let winesBuilder = WinesBuilder(resolver, self)
        let viewController = winesBuilder.build()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func finish(animated: Bool) {
        childCoordinators.forEach { coordinator in
            coordinator.finish(animated: false)
        }
        childCoordinators.removeAll()
    }
}

extension WinesFlowCoordinator: WinesModuleOutput {
    func showWineInfo() {
        // Будет let viewController = someBuilder.build()
        let viewController = ViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

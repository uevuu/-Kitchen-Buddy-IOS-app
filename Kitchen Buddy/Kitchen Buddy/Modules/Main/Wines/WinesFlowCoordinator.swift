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
    private weak var navigationController: UINavigationController?
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    private var finishHandlers: [(() -> Void)] = []
    
    init(navigationController: UINavigationController?, resolver: Resolver, finishHandler: @escaping (() -> Void)) {
        self.navigationController = navigationController
        self.resolver = resolver
        finishHandlers.append(finishHandler)
    }
    
    func start(animated: Bool) {
        showWines()
    }
    
    func showWines() {
        let winesBuilder = WinesBuilder(
            resolver: resolver,
            moduleOutput: self
        )
        let viewController = winesBuilder.build()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)
        
        childCoordinators.finishAll(animated: animated, completion: nil)
    }
}

extension WinesFlowCoordinator: WinesModuleOutput {
    func showWineInfo() {
        // Будет let viewController = someBuilder.build()
        let viewController = ViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func goToPreviousModule(animated: Bool, completion: (() -> Void)?) {
        finish(animated: false, completion: completion)
    }
    
    func moduleDidUnload() {
        finishHandlers.forEach { $0() }
    }
}

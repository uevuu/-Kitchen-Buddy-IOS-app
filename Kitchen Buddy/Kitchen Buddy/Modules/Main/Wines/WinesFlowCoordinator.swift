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
    private let sortValue: String
    
    init(
        sortValue: String,
        navigationController: UINavigationController?,
        resolver: Resolver,
        finishHandler: @escaping (() -> Void)
    ) {
        self.navigationController = navigationController
        self.resolver = resolver
        self.sortValue = sortValue
        finishHandlers.append(finishHandler)
    }
    
    func start(animated: Bool) {
        showWines()
    }
    
    func showWines() {
        let winesBuilder = WinesBuilder(
            resolver: resolver,
            moduleOutput: self,
            sortValue: sortValue
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
    func viewDidPop(animated: Bool, completion: (() -> Void)?) {
        navigationController?.popViewController(animated: true)
        finish(animated: false, completion: completion)
    }
    
    func moduleDidUnload() {
        finishHandlers.forEach { $0() }
    }
}

//
//  FilterCoordinator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 02.06.2023.
//

import UIKit
import Swinject

final class FilterFlowCoordinator: FlowCoordinatorProtocol {
    private var resolver: Resolver
    private weak var navigationController: UINavigationController?
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    private var finishHandlers: [(() -> Void)] = []
    
    init(
        navigationController: UINavigationController?,
        resolver: Resolver,
        finishHandler: @escaping (() -> Void)
    ) {
        self.navigationController = navigationController
        self.resolver = resolver
        finishHandlers.append(finishHandler)
    }
    
    func start(animated: Bool) {
        showFilter()
    }
    
    func showFilter() {
        let filterBuilder = FilterBuilder(
            resolver: resolver,
            moduleOutput: self
        )
        let viewController = filterBuilder.build()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)
        
        childCoordinators.finishAll(animated: animated, completion: nil)
    }
}

extension FilterFlowCoordinator: FilterModuleOutput {
    func viewDidPop(animated: Bool, completion: (() -> Void)?) {
        navigationController?.popViewController(animated: true)
        finish(animated: false, completion: completion)
    }
    
    func moduleDidUnload() {
        finishHandlers.forEach { $0() }
    }
    
    func showSelectableSetting(_ type: SelectableSettingType) {
        let selectableSettingCoordinator = SelectableSettingCoordinator(
            navigationController: navigationController,
            resolver: resolver,
            settingType: type
        ) { [weak self] in
            self?.childCoordinators.removeFlowCoordinator(ofType: SelectableSettingCoordinator.self)
        }
        selectableSettingCoordinator.start(animated: true)
        childCoordinators.append(selectableSettingCoordinator)
    }
}

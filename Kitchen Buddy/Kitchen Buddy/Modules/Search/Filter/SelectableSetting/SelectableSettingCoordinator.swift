//
//  SelectableSettingCoordinator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 04.06.2023.
//

import UIKit
import Swinject

final class SelectableSettingCoordinator: FlowCoordinatorProtocol {
    private var resolver: Resolver
    private weak var navigationController: UINavigationController?
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    private var finishHandlers: [(() -> Void)] = []
    private let settingType: SelectableSettingType
    
    init(
        navigationController: UINavigationController?,
        resolver: Resolver,
        settingType: SelectableSettingType,
        finishHandler: @escaping (() -> Void)
    ) {
        self.navigationController = navigationController
        self.resolver = resolver
        self.settingType = settingType
        finishHandlers.append(finishHandler)
    }
    
    func start(animated: Bool) {
        showSetting()
    }
    
    func showSetting() {
        let filterBuilder = SelectableSettingBuilder(
            settingType: settingType,
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

extension SelectableSettingCoordinator: SelectableSettingOutput {
    func viewDidPop(animated: Bool, completion: (() -> Void)?) {
        navigationController?.popViewController(animated: true)
        finish(animated: false, completion: completion)
    }
    
    func moduleDidUnload() {
        finishHandlers.forEach { $0() }
    }
}


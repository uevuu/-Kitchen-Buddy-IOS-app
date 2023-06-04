//
//  SelectableSettingBuilder.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 04.06.2023.
//

import UIKit
import Swinject

// MARK: - SelectableSettingBuilder
final class SelectableSettingBuilder: ModuleBuilderProtocol {
    private var resolver: Resolver
    private var moduleOutput: SelectableSettingOutput?
    private let settingType: SelectableSettingType
    
    init(settingType: SelectableSettingType, resolver: Resolver, moduleOutput: SelectableSettingOutput?) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
        self.settingType = settingType
    }
    
    func build() -> UIViewController {
        let selectableSettingViewModel = SelectableSettingViewModel(
            settingType: settingType,
            filterService: resolver.resolve(),
            output: moduleOutput
        )
        return SelectableSettingViewController(viewModel: selectableSettingViewModel)
    }
}

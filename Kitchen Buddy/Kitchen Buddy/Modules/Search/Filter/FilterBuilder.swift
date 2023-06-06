//
//  FilterBuilder.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 02.06.2023.
//

import UIKit
import Swinject

// MARK: - FilterBuilder
final class FilterBuilder: ModuleBuilderProtocol {
    private var resolver: Resolver
    private var moduleOutput: FilterModuleOutput?
    
    init(resolver: Resolver, moduleOutput: FilterModuleOutput?) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
    }
    
    func build() -> UIViewController {
        let filterViewModel = FilterViewModel(
            networkService: resolver.resolve(),
            filterService: resolver.resolve(),
            output: moduleOutput
        )
        return FilterViewController(viewModel: filterViewModel)
    }
}

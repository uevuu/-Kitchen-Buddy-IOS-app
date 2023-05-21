//
//  MainBuilder.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 16.04.2023.
//

import UIKit
import Swinject

// MARK: - MainBuilder
final class MainBuilder: ModuleBuilderProtocol {    
    private var resolver: Resolver
    private var moduleOutput: MainModuleOutput?
    
    init(resolver: Resolver, moduleOutput: MainModuleOutput) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
    }
    
    func build() -> UIViewController {
        let mainViewModel = MainViewModel(
            networkService: resolver.resolve(),
            lastRecipesService: resolver.resolve(),
            output: moduleOutput
        )
        return MainViewController(viewModel: mainViewModel)
    }
}

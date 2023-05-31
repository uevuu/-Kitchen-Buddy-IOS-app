//
//  WinesBuilder.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 01.05.2023.
//

import UIKit
import Swinject

// MARK: - WinesBuilder
final class WinesBuilder: ModuleBuilderProtocol {
    private var resolver: Resolver
    private var moduleOutput: WinesModuleOutput?
    private let sortValue: String
    
    init(resolver: Resolver, moduleOutput: WinesModuleOutput?, sortValue: String) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
        self.sortValue = sortValue
    }
    
    func build() -> UIViewController {
        let winesViewModel = WinesViewModel(
            networkService: resolver.resolve(),
            wineLocalDataSource: resolver.resolve(),
            output: moduleOutput,
            sortValue: sortValue
        )
        return WinesViewController(viewModel: winesViewModel)
    }
}

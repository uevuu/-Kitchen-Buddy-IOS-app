//
//  AllSelectionRecipesBuilder.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 02.05.2023.
//

import UIKit
import Swinject

// MARK: - AllSelectionRecipesBuilder
final class AllSelectionRecipesBuilder: ModuleBuilderProtocol {
    private var resolver: Resolver
    private var moduleOutput: AllSelectionRecipesModuleOutput?
    
    init(resolver: Resolver, moduleOutput: AllSelectionRecipesModuleOutput?) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
    }
    
    func build() -> UIViewController {
        let allSelectionRecipesViewModel = AllSelectionRecipesViewModel(
            networkService: resolver.resolve(),
            output: moduleOutput
        )
        return AllSelectionRecipesViewController(viewModel: allSelectionRecipesViewModel)
    }
}

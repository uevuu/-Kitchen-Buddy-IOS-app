//
//  RecipeInfoBuilder.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 01.05.2023.
//

import UIKit
import Swinject

// MARK: - RecipeInfoBuilder
final class RecipeInfoBuilder: ModuleBuilderProtocol {
    private var resolver: Resolver
    private var moduleOutput: RecipeInfoModuleOutput?
    
    init(resolver: Resolver, moduleOutput: RecipeInfoModuleOutput?) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
    }
    
    func build() -> UIViewController {
        let recipeInfoViewModel = RecipeInfoViewModel(
            networkService: resolver.resolve(),
            output: moduleOutput
        )
        return RecipeInfoViewController(viewModel: recipeInfoViewModel)
    }
}

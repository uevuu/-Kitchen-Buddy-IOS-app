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
    private let recipeId: Int
    
    init(resolver: Resolver, moduleOutput: RecipeInfoModuleOutput?, recipeId: Int) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
        self.recipeId = recipeId
    }
    
    func build() -> UIViewController {
        let recipeInfoViewModel = RecipeInfoViewModel(
            networkService: resolver.resolve(),
            recipeModuleLocalDataSource: resolver.resolve(),
            lastRecipesService: resolver.resolve(),
            output: moduleOutput,
            recipeId: recipeId
        )
        return RecipeInfoViewController(viewModel: recipeInfoViewModel)
    }
}

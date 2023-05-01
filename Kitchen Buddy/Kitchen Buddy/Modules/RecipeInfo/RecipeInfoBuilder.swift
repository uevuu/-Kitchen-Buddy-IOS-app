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
    private var coordinator: RecipeFlowCoordinator
    
    init(_ resolver: Resolver, _ coordinator: RecipeFlowCoordinator) {
        self.resolver = resolver
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let networkService = resolver.resolve(NetworkService.self)
        let recipeInfoViewModel = RecipeInfoViewModel(
            networkService: networkService ?? NetworkService(),
            output: coordinator
        )
        return RecipeInfoViewController(viewModel: recipeInfoViewModel)
    }
}

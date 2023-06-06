//
//  FavouriteBuilder.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 06.06.2023.
//

import UIKit
import Swinject

// MARK: - FavouriteBuilder
final class FavouriteBuilder: ModuleBuilderProtocol {
    private var resolver: Resolver
    private var moduleOutput: FavouriteModuleOutput?
    
    init(resolver: Resolver, moduleOutput: FavouriteModuleOutput?) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
    }
    
    func build() -> UIViewController {
        let favouriteViewModel = FavouriteViewModel(
            recipeModuleLocalDataSource: resolver.resolve(),
            favouriteService: resolver.resolve(),
            output: moduleOutput
        )
        return FavouriteViewController(viewModel: favouriteViewModel)
    }
}

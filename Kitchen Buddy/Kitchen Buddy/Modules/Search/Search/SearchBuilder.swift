//
//  SearchBuilder.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 31.05.2023.
//

import Swinject

// MARK: - SearchBuilder
final class SearchBuilder: ModuleBuilderProtocol {
    private var resolver: Resolver
    private var moduleOutput: SearchModuleOutput?
    
    init(resolver: Resolver, moduleOutput: SearchModuleOutput) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
    }
    
    func build() -> UIViewController {
        let searchViewModel = SearchViewModel(
            networkService: resolver.resolve(),
            filterService: resolver.resolve(),
            recipeLocalDataSource: resolver.resolve(),
            output: moduleOutput
        )
        return SearchViewController(viewModel: searchViewModel)
    }
}

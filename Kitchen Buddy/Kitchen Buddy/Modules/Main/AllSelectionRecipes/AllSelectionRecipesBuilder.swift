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
    private var coordinator: AllSelectionRecipesFlowCoordinator
    
    init(_ resolver: Resolver, _ coordinator: AllSelectionRecipesFlowCoordinator) {
        self.resolver = resolver
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let networkService = resolver.resolve(NetworkService.self)
        let allSelectionRecipesViewModel = AllSelectionRecipesViewModel(
            networkService: networkService ?? NetworkService(),
            output: coordinator
        )
        return AllSelectionRecipesViewController(viewModel: allSelectionRecipesViewModel)
    }
}

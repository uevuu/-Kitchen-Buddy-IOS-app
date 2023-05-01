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
    private var coordinator: MainFlowCoordinator
    
    init(_ resolver: Resolver, _ coordinator: MainFlowCoordinator) {
        self.resolver = resolver
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let networkService = resolver.resolve(NetworkService.self)
        let mainViewModel = MainViewModel(
            networkService: networkService ?? NetworkService(),
            output: coordinator
        )
        return MainViewController(viewModel: mainViewModel)
    }
}

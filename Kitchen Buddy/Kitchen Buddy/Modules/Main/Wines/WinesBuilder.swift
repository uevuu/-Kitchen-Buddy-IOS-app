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
    private var coordinator: WinesFlowCoordinator
    
    init(_ resolver: Resolver, _ coordinator: WinesFlowCoordinator) {
        self.resolver = resolver
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let networkService = resolver.resolve(NetworkService.self)
        let winesViewModel = WinesViewModel(
            networkService: networkService ?? NetworkService(),
            output: coordinator
        )
        return WinesViewController(viewModel: winesViewModel)
    }
}

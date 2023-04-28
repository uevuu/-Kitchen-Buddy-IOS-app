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
    
    init(_ resolver: Resolver) {
        self.resolver = resolver
    }
    
    func build() -> UIViewController {
        let networkService = resolver.resolve(NetworkService.self)
        let mainViewModel = MainViewModel(networkService: networkService ?? NetworkService())
        return MainViewController(viewModel: mainViewModel)
    }
}

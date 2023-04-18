//
//  MainBuilder.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 16.04.2023.
//

import UIKit
import Swinject

// MARK: - MainBuilderProtocol
protocol MainBuilderProtocol {
    var serviceLocator: ServiceLocator { get set }
    init(_ serviceLocator: ServiceLocator)
    func build() -> MainViewController
}

// MARK: - MainBuilder
final class MainBuilder: MainBuilderProtocol {
    var serviceLocator: ServiceLocator
    
    init(_ serviceLocator: ServiceLocator) {
        self.serviceLocator = serviceLocator
    }
    
    func build() -> MainViewController {
        let networkService = serviceLocator.container.resolve(NetworkService.self)
        let mainViewModel = MainViewModel(networkService: networkService ?? NetworkService())
        return MainViewController(viewModel: mainViewModel)
    }
}

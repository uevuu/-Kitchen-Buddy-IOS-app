//
//  Coordinator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 14.04.2023.
//

import UIKit

// MARK: - Coordinator
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var serviceLocator: ServiceLocator { get set }
    func start()
    func finish()
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
    }
}

// MARK: - CoordinatorWithNavigation
protocol CoordinatorWithNavigation: Coordinator {
    var navigationController: UINavigationController { get set }
}

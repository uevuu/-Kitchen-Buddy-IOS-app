//
//  FlowCoordinatorProtocol.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 14.04.2023.
//

import UIKit

// MARK: - FlowCoordinatorProtocol
protocol FlowCoordinatorProtocol: AnyObject {
    func start(animated: Bool)
    func finish(animated: Bool, completion: (() -> Void)?)
}

extension Array where Element == FlowCoordinatorProtocol {
    func flowCoordinator<T: FlowCoordinatorProtocol>(ofType type: T.Type) -> T? {
        guard let firstCoordinator = first(where: { $0 is T }) as? T else { return nil }
        return firstCoordinator
//        first(where: { $0 is T }) as? T
    }
    
    mutating func removeFlowCoordinator<T: FlowCoordinatorProtocol>(ofType type: T.Type) {
        guard let index = firstIndex(where: { $0 is T }) else { return }
        remove(at: index)
    }
}

extension Array where Element == FlowCoordinatorProtocol {
    func finishAll(animated: Bool, completion: (() -> Void)?) {
        guard let coordinator = self.first else {
            completion?()
            return
        }
        
        coordinator.finish(animated: animated) {
            var arr = self
            arr.removeFirst()
            finishAll(animated: animated, completion: completion)
        }
    }
}

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
    func finish(animated: Bool)
}

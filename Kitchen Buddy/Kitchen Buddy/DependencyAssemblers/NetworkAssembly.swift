//
//  NetworkAssembly.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 18.04.2023.
//

import Swinject

final class NetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkService.self) { _ in
            NetworkService()
        }
    }
}

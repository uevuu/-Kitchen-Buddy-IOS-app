//
//  UserDefaultsAssembly.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 19.05.2023.
//

import Swinject

final class UserDefaultsAssembly: Assembly {
    func assemble(container: Container) {
        container.register(UserDefaultsService.self) { _ in
            UserDefaultsService()
        }
        .inObjectScope(.container)
    }
}

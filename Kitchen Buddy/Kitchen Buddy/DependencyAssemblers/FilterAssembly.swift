//
//  FilterAssembly.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 02.06.2023.
//

import Swinject

final class FilterAssembly: Assembly {
    func assemble(container: Container) {
        container.register(FilterService.self) { _ in
            FilterService()
        }
        .inObjectScope(.container)
    }
}

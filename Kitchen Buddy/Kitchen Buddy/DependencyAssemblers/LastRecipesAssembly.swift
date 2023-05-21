//
//  LastRecipesAssembly.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 21.05.2023.
//

import Swinject

final class LastRecipesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(LastRecipesService.self) { _ in
            LastRecipesService()
        }
    }
}


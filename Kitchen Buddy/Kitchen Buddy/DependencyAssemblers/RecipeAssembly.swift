//
//  RecipeAssembly.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 21.05.2023.
//

import Swinject

final class RecipeAssembly: Assembly {
    func assemble(container: Container) {
        container.register(LastRecipesService.self) { _ in
            LastRecipesService()
        }
        .inObjectScope(.container)
        
        container.register(RecipeModuleLocalDataSource.self) { _ in
            RecipeModuleLocalDataSource()
        }.inObjectScope(.container)
    }
}

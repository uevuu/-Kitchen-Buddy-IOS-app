//
//  RecipeModuleLocalDataSourceAssembly.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 29.05.2023.
//

import Swinject

final class RecipeModuleLocalDataSourceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(RecipeModuleLocalDataSource.self) { _ in
            RecipeModuleLocalDataSource()
        }
        .inObjectScope(.container)
    }
}


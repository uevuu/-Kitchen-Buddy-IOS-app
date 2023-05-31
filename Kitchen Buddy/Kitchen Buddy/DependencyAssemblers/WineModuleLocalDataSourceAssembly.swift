//
//  WineModuleLocalDataSourceAssembly.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 27.05.2023.
//

import Swinject

final class WineModuleLocalDataSourceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(WineModuleLocalDataSource.self) { _ in
            WineModuleLocalDataSource()
        }
        .inObjectScope(.container)
    }
}

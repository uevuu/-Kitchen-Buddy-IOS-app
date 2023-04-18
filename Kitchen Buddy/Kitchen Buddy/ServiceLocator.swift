//
//  ServiceLocator.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 18.04.2023.
//

import Swinject

protocol ServiceLocatorProtocol {
    var container: Container { get set }
    var assembler: Assembler { get set }
}

final class ServiceLocator: ServiceLocatorProtocol {
    var container: Container
    var assembler: Assembler
    
    init() {
        self.container = Container()
        self.assembler = Assembler(
            [
                NetworkAssembly()
            ],
            container: container
        )
    }
}

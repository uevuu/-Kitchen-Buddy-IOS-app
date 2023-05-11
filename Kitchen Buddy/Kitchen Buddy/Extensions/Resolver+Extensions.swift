//
//  Resolver+Extensions.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 04.05.2023.
//

import Swinject

extension Resolver {
    func resolve<T>() -> T {
        // swiftlint:disable:next force_unwrapping
        return resolve(T.self)!
    }
    
    func resolve<T>(name: String?) -> T {
        // swiftlint:disable:next force_unwrapping
        return resolve(T.self, name: name)!
    }
    
    func resolve<T, Arg1>(argument: Arg1) -> T {
        // swiftlint:disable:next force_unwrapping
        return resolve(T.self, argument: argument)!
    }
}

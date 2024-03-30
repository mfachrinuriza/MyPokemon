//
//  DI.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import Swinject

protocol DIProtocol {
    static func get<T>(_ type: T.Type, name: String?) -> T?
}

class DI: DIProtocol {
    static let container = Container()
    static let assembler = Assembler(
        [
            ManagerAssembly(),
            HomeAssembly(),
            DetailAssembly(),
            MyPokemonAssembly(),
            AddingPokemonAssembly(),
            
        ],
        container: DI.container
    )
    
    static func get<T>(_ type: T.Type, name: String? = nil) -> T? {
        DI.assembler.resolver.resolve(T.self, name: name)
    }
}

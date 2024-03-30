//
//  MyPokemonAssembly.swift
//  mypokemon
//
//  Created by Muhammad Fachri Nuriza on 29/03/24.
//

import Swinject
import SwinjectAutoregistration

class MyPokemonAssembly: Assembly {
    
    func assemble(container: Container) {
        container.autoregister(MyPokemonStorageProtocol.self, initializer: MyPokemonStorage.init)
        container.autoregister(MyPokemonInteractorProtocol.self, initializer: MyPokemonInteractor.init)
        container.autoregister(MyPokemonRouterProtocol.self, initializer: MyPokemonRouter.init)
        container.autoregister(MyPokemonPresenterProtocol.self, initializer: MyPokemonPresenter.init)

        container.register(MyPokemonViewControllerProtocol.self) { r in
            let presenter = r.resolve(MyPokemonPresenterProtocol.self)!
            let router = r.resolve(MyPokemonRouterProtocol.self)!
            let view = MyPokemonViewController(
                presenter: presenter,
                router: router
            )
            
            presenter.view = view
            presenter.router = router
            router.view = view
            
            return view
        }
    }
}

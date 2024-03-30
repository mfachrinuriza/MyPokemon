//
//  AddingPokemonAssembly.swift
//  mypokemon
//
//  Created by Muhammad Fachri Nuriza on 29/03/24.
//

import Swinject
import SwinjectAutoregistration

class AddingPokemonAssembly: Assembly {
    
    func assemble(container: Container) {
        container.autoregister(AddingPokemonStorageProtocol.self, initializer: AddingPokemonStorage.init)
        container.autoregister(AddingPokemonInteractorProtocol.self, initializer: AddingPokemonInteractor.init)
        container.autoregister(AddingPokemonRouterProtocol.self, initializer: AddingPokemonRouter.init)
        container.autoregister(AddingPokemonPresenterProtocol.self, initializer: AddingPokemonPresenter.init)

        container.register(AddingPokemonViewControllerProtocol.self) { r in
            let presenter = r.resolve(AddingPokemonPresenterProtocol.self)!
            let router = r.resolve(AddingPokemonRouterProtocol.self)!
            let view = AddingPokemonViewController(
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

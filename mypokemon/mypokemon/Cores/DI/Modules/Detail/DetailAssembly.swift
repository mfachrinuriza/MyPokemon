//
//  DetailAssembly.swift
//  mypokemon
//
//  Created by Muhammad Fachri Nuriza on 15/02/24.
//

import Swinject
import SwinjectAutoregistration

class DetailAssembly: Assembly {
    
    func assemble(container: Container) {
        container.autoregister(DetailServiceProtocol.self, initializer: DetailService.init)
        container.autoregister(DetailStorageProtocol.self, initializer: DetailStorage.init)
        container.autoregister(PokemonDetailInteractorProtocol.self, initializer: PokemonDetailInteractor.init)
        container.autoregister(PokemonDetailRouterProtocol.self, initializer: PokemonDetailRouter.init)
        container.autoregister(PokemonDetailPresenterProtocol.self, initializer: PokemonDetailPresenter.init)

        container.register(PokemonDetailViewControllerProtocol.self) { r in
            let presenter = r.resolve(PokemonDetailPresenterProtocol.self)!
            let router = r.resolve(PokemonDetailRouterProtocol.self)!
            let view = PokemonDetailViewController(
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

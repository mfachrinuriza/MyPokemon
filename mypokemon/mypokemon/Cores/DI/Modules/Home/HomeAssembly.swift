//
//  HomeAssembly.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import Swinject
import SwinjectAutoregistration

class HomeAssembly: Assembly {
    
    func assemble(container: Container) {
        container.autoregister(HomeStorageProtocol.self, initializer: HomeStorage.init)
        container.autoregister(HomeServiceProtocol.self, initializer: HomeService.init)
        container.autoregister(HomeInteractorProtocol.self, initializer: HomeInteractor.init)
        container.autoregister(HomeRouterProtocol.self, initializer: HomeRouter.init)
        container.autoregister(HomePresenterProtocol.self, initializer: HomePresenter.init)

        container.register(HomeViewControllerProtocol.self) { r in
            let presenter = r.resolve(HomePresenterProtocol.self)!
            let router = r.resolve(HomeRouterProtocol.self)!
            let view = HomeViewController(
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

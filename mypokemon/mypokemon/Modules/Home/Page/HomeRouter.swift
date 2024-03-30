//
//  HomeRouter.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import Foundation
import core

protocol HomeRouterProtocol: AnyObject {
    var view: HomeViewControllerProtocol? { get set }
    
    func presentPokemonDetail(name: String)
    func presentMyPokemon()
}

class HomeRouter: HomeRouterProtocol {
    weak var view: HomeViewControllerProtocol?
    
    func presentPokemonDetail(name: String) {
        let vc = DI.get(PokemonDetailViewControllerProtocol.self)!
        vc.pokemonName = name
        self.view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentMyPokemon() {
        let vc = DI.get(MyPokemonViewControllerProtocol.self)!
        self.view?.navigationController?.pushViewController(vc, animated: true)
    }
}

//
//  MyPokemonRouter.swift
//  mypokemon
//
//  Created by Muhammad Fachri Nuriza on 29/03/24.
//

import Foundation
import core

protocol MyPokemonRouterProtocol: AnyObject {
    var view: MyPokemonViewControllerProtocol? { get set }
    
    func presentPokemonDetail(name: String)
}

class MyPokemonRouter: MyPokemonRouterProtocol {
    weak var view: MyPokemonViewControllerProtocol?
    
    func presentPokemonDetail(name: String) {
        let vc = DI.get(PokemonDetailViewControllerProtocol.self)!
        vc.pokemonName = name
        self.view?.navigationController?.pushViewController(vc, animated: true)
    }
}

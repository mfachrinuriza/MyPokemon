//
//  PokemonDetailRouter.swift
//  mypokemon
//
//  Created by Muhammad Fachri Nuriza on 15/02/24.
//

import Foundation
import core

protocol PokemonDetailRouterProtocol: AnyObject {
    var view: PokemonDetailViewControllerProtocol? { get set }
    
    func presentAddingPokemon(pokemon: Pokemon?)
}

class PokemonDetailRouter: PokemonDetailRouterProtocol {
    weak var view: PokemonDetailViewControllerProtocol?
    
    func presentAddingPokemon(pokemon: Pokemon?) {
        let vc = DI.get(AddingPokemonViewControllerProtocol.self)!
        vc.pokemon = pokemon
        self.view?.navigationController?.pushViewController(vc, animated: true)
    }
}

//
//  AddingPokemonRouter.swift
//  mypokemon
//
//  Created by Muhammad Fachri Nuriza on 29/03/24.
//

import Foundation
import core

protocol AddingPokemonRouterProtocol: AnyObject {
    var view: AddingPokemonViewControllerProtocol? { get set }
}

class AddingPokemonRouter: AddingPokemonRouterProtocol {
    weak var view: AddingPokemonViewControllerProtocol?
}

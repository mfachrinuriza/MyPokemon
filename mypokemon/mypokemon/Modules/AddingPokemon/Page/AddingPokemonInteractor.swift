//
//  AddingPokemonInteractor.swift
//  mypokemon
//
//  Created by Muhammad Fachri Nuriza on 29/03/24.
//

import Foundation
import RxSwift
import core

protocol AddingPokemonInteractorProtocol: AnyObject {
    func addPokemon(request: Pokemon) -> Observable<String>
    func updatePokemon(request: Pokemon) -> Observable<String>
}

class AddingPokemonInteractor: AddingPokemonInteractorProtocol {
    var storage: AddingPokemonStorageProtocol

    init(
        storage: AddingPokemonStorageProtocol
    ) {
        self.storage = storage
    }
    
    func addPokemon(request: Pokemon) -> Observable<String> {
        return storage.addPokemon(request: request)
    }
    
    func updatePokemon(request: Pokemon) -> Observable<String> {
        return storage.updatePokemon(request: request)
    }
}

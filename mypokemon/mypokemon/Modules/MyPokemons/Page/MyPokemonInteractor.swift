//
//  MyPokemonInteractor.swift
//  mypokemon
//
//  Created by Muhammad Fachri Nuriza on 29/03/24.
//

import Foundation
import RxSwift
import core

protocol MyPokemonInteractorProtocol: AnyObject {
    func getPokemons() -> Observable<[Pokemon]>
    func deletePokemon(name: String) -> Observable<String>
}

class MyPokemonInteractor: MyPokemonInteractorProtocol {
    var myPokemonStorage: MyPokemonStorageProtocol

    init(
        myPokemonStorage: MyPokemonStorageProtocol
    ) {
        self.myPokemonStorage = myPokemonStorage
    }
    
    func getPokemons() -> Observable<[Pokemon]> {
        return myPokemonStorage.getPokemons()
    }
    
    func deletePokemon(name: String) -> Observable<String> {
        return myPokemonStorage.deletePokemon(name: name)
    }
}

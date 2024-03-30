//
//  PokemonDetailInteractor.swift
//  mypokemon
//
//  Created by Muhammad Fachri Nuriza on 15/02/24.
//

import Foundation
import core
import RxSwift

protocol PokemonDetailInteractorProtocol: AnyObject {
    func getPokemonDetail(name: String) -> Observable<PokemonDetail>
    func getMyPokemonDetail(name: String) -> Observable<Pokemon?>
    func addPokemon(request: Pokemon) -> Observable<String>
    func deletePokemon(name: String) -> Observable<String>
}

class PokemonDetailInteractor: PokemonDetailInteractorProtocol {
    var detailService: DetailServiceProtocol
    var detailStorage: DetailStorageProtocol

    init(
        detailService: DetailServiceProtocol,
        detailStorage: DetailStorageProtocol
    ) {
        self.detailService = detailService
        self.detailStorage = detailStorage
    }
    
    func getPokemonDetail(name: String) -> Observable<PokemonDetail> {
        return detailService.getPokemonDetail(name: name)
    }
    
    func getMyPokemonDetail(name: String) -> Observable<Pokemon?> {
        return detailStorage.getMyPokemonDetail(name: name)
    }
    
    func addPokemon(request: Pokemon) -> Observable<String> {
        return detailStorage.addPokemon(request: request)
    }
    
    func deletePokemon(name: String) -> Observable<String> {
        return detailStorage.deletePokemon(name: name)
    }
}

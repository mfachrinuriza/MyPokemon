//
//  HomeInteractor.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import Foundation
import RxSwift
import core

protocol HomeInteractorProtocol: AnyObject {
    func getPokemons() -> Observable<BaseResponse<[Pokemon]>>
    func isPokemonAdded(name: String) -> Observable<Bool>
}

class HomeInteractor: HomeInteractorProtocol {
    var homeService: HomeServiceProtocol
    var homeStorage: HomeStorageProtocol

    init(
        homeService: HomeServiceProtocol,
        homeStorage: HomeStorageProtocol
    ) {
        self.homeService = homeService
        self.homeStorage = homeStorage
    }
    
    func getPokemons() -> Observable<BaseResponse<[Pokemon]>> {
        return homeService.getPokemons()
    }
    
    func isPokemonAdded(name: String) -> Observable<Bool> {
        return homeStorage.isPokemonAdded(name: name)
    }
}

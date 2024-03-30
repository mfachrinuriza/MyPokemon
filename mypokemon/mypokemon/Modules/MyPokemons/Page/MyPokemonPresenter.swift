//
//  MyPokemonPresenter.swift
//  mypokemon
//
//  Created by Muhammad Fachri Nuriza on 29/03/24.
//

import Foundation
import Combine
import RxSwift
import core

protocol MyPokemonPresenterProtocol: AnyObject {
    var interactor: MyPokemonInteractorProtocol { get }
    var router: MyPokemonRouterProtocol? { get set }
    var view: MyPokemonViewControllerProtocol? { get set }
    
    func getPokemons()
    func deletePokemon(name: String)
}

class MyPokemonPresenter: MyPokemonPresenterProtocol {
    internal let interactor: MyPokemonInteractorProtocol
    
    weak var router: MyPokemonRouterProtocol?
    weak var view: MyPokemonViewControllerProtocol?

    let disposeBag = DisposeBag()
    
    init(
        interactor: MyPokemonInteractorProtocol
    ) {
        self.interactor = interactor
    }
    
    func getPokemons() {
        self.interactor.getPokemons().subscribe(onNext: { result in
            self.view?.pokemons = result
            self.view?.update(with: result)
        }, onError: { error in
            self.view?.errorMessage = Wording.systemError
        }).disposed(by: disposeBag)
    }
    
    func deletePokemon(name: String) {
        self.interactor.deletePokemon(name: name).subscribe(onNext: { result in
            self.view?.successMessage = result
            self.getPokemons()
        }, onError: { error in
            self.view?.errorMessage = "\(error)"
        }).disposed(by: disposeBag)
    }
}

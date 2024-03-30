//
//  PokemonDetailPresenterProtocol.swift
//  mypokemon
//
//  Created by Muhammad Fachri Nuriza on 15/02/24.
//

import Foundation
import Combine
import RxSwift
import core

protocol PokemonDetailPresenterProtocol: AnyObject {
    var interactor: PokemonDetailInteractorProtocol { get }
    var router: PokemonDetailRouterProtocol? { get set }
    var view: PokemonDetailViewControllerProtocol? { get set }
    
    func getPokemonDetail(name: String)
    func getMyPokemonDetail(name: String)
    func deletePokemon(name: String)
}

class PokemonDetailPresenter: PokemonDetailPresenterProtocol {
    internal let interactor: PokemonDetailInteractorProtocol
    
    weak var router: PokemonDetailRouterProtocol?
    weak var view: PokemonDetailViewControllerProtocol?
    
    let disposeBag = DisposeBag()
    
    init(
        interactor: PokemonDetailInteractorProtocol
    ) {
        self.interactor = interactor
    }
    
    
    func getPokemonDetail(name: String) {
        self.interactor.getPokemonDetail(name: name).subscribe(onNext: { result in
            self.view?.updateUI(with: result)
        }, onError: { error in
            self.view?.errorMessage = Wording.systemError
        }).disposed(by: disposeBag)
    }
    
    func getMyPokemonDetail(name: String) {
        self.interactor.getMyPokemonDetail(name: name).subscribe(onNext: { result in
            self.view?.myPokemonData = result
        }, onError: { error in
            self.view?.errorMessage = Wording.systemError
        }).disposed(by: disposeBag)
    }
    
    func deletePokemon(name: String) {
        self.view?.isLoading = true
        self.interactor.deletePokemon(name: name).subscribe(onNext: { message in
            self.view?.successMessage = message
            self.view?.myPokemonData = nil
            self.view?.isLoading = false
        }, onError: { error in
            self.view?.errorMessage = "\(error)"
            self.view?.isLoading = false
        }).disposed(by: disposeBag)
    }
}

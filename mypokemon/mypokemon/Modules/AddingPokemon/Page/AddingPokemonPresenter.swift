//
//  AddingPokemonPresenter.swift
//  mypokemon
//
//  Created by Muhammad Fachri Nuriza on 29/03/24.
//

import Foundation
import Combine
import RxSwift
import core

protocol AddingPokemonPresenterProtocol: AnyObject {
    var interactor: AddingPokemonInteractorProtocol { get }
    var router: AddingPokemonRouterProtocol? { get set }
    var view: AddingPokemonViewControllerProtocol? { get set }
    
    func addPokemon(request: Pokemon)
    func updatePokemon(request: Pokemon)
    func isFormValidated(with data: Pokemon) -> Bool
    func getNameFibonacciFomatted(changedCount: Int, nickname: String) -> String
}

class AddingPokemonPresenter: AddingPokemonPresenterProtocol {
    internal let interactor: AddingPokemonInteractorProtocol
    
    weak var router: AddingPokemonRouterProtocol?
    weak var view: AddingPokemonViewControllerProtocol?
    
    let disposeBag = DisposeBag()
    
    init(
        interactor: AddingPokemonInteractorProtocol
    ) {
        self.interactor = interactor
    }
    
    func addPokemon(request: Pokemon) {
        self.view?.isLoading = true
        self.interactor.addPokemon(request: request).subscribe(onNext: { message in
            self.view?.successMessage = message
            self.view?.isLoading = false
        }, onError: { error in
            self.view?.errorMessage = "\(error)"
            self.view?.isLoading = false
        }).disposed(by: disposeBag)
    }
    
    func updatePokemon(request: Pokemon) {
        self.view?.isLoading = true
        self.interactor.updatePokemon(request: request).subscribe(onNext: { message in
            self.view?.successMessage = message
            self.view?.isLoading = false
        }, onError: { error in
            self.view?.errorMessage = "\(error)"
            self.view?.isLoading = false
        }).disposed(by: disposeBag)
    }
    
    func isFormValidated(with data: Pokemon) -> Bool {
        var isValid = true
        
        if data.name == nil || data.name == "" {
            isValid = false
        }
        
        if data.nickname == nil || data.nickname == "" {
            isValid = false
        }
        
        return isValid
    }
    
    func getNameFibonacciFomatted(changedCount: Int, nickname: String) -> String {
        return "\(nickname)-\(self.getFibonacciRecursive(n: changedCount))"
    }

    func getFibonacciRecursive(n: Int) -> Int {
        if n <= 1 {
            return n
        }
        
        return getFibonacciRecursive(n: n - 1) + getFibonacciRecursive(n: n - 2)
    }
}

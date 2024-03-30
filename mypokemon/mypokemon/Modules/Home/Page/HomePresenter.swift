//
//  HomePresenter.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import Foundation
import Combine
import RxSwift
import core

protocol HomePresenterProtocol: AnyObject {
    var interactor: HomeInteractorProtocol { get }
    var router: HomeRouterProtocol? { get set }
    var view: HomeViewControllerProtocol? { get set }
    
    func getPokemons()
    func filterData(with searchText: String?, pokemons: [Pokemon])
    func isPokemonAdded(name: String)
}

class HomePresenter: HomePresenterProtocol {
    internal let interactor: HomeInteractorProtocol
    
    weak var router: HomeRouterProtocol?
    weak var view: HomeViewControllerProtocol?

    let disposeBag = DisposeBag()
    
    init(
        interactor: HomeInteractorProtocol
    ) {
        self.interactor = interactor
    }
    
    func getPokemons() {
        self.interactor.getPokemons().subscribe(onNext: { result in
            if let pokemons = result.results {
                self.view?.pokemons = pokemons
                self.view?.update(with: result.results!, isFiltered: false)
            }
        }, onError: { error in
            self.view?.errorMessage = Wording.systemError
        }).disposed(by: disposeBag)
    }
    
    func filterData(with searchText: String?, pokemons: [Pokemon]) {
        var filteredData = [Pokemon]()
        if let searchText = searchText, !searchText.isEmpty {
            filteredData = pokemons.filter { $0.name!.lowercased().contains(searchText.lowercased()) }
        } else {
            filteredData = pokemons
        }
        self.view?.update(with: filteredData, isFiltered: true)
    }
    
    func isPokemonAdded(name: String) {
        self.interactor.isPokemonAdded(name: name).subscribe(onNext: { isAdded in
            // change this code
        }, onError: { error in
            self.view?.errorMessage = Wording.systemError
        }).disposed(by: disposeBag)
    }
}

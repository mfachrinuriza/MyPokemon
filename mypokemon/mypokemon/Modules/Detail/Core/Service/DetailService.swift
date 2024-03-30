//
//  DetailService.swift
//  mypokemon
//
//  Created by Muhammad Fachri Nuriza on 29/03/24.
//

import Foundation
import Alamofire
import RxSwift
import core

protocol DetailServiceProtocol {
    func getPokemonDetail(name: String) -> Observable<PokemonDetail>
}

class DetailService: BaseService {
    static let sharedInstance = DetailService()
}

extension DetailService: DetailServiceProtocol {
    func getPokemonDetail(name: String) -> Observable<PokemonDetail> {
        return Observable.create { observer in
            let url = self.HOST_URL + API.pokemonDetail(name)
            
            AF.request(
                url,
                method: .get,
                headers: self.getHeaders()
            ).responseDecodable(of: PokemonDetail.self) { response in
                self.showResponseData(data: response.data)
                switch response.result {
                case .success(let result):
                    observer.onNext(result)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}

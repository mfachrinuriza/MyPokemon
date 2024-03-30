//
//  HomeStorage.swift
//  mypokemon
//
//  Created by Muhammad Fachri Nuriza on 29/03/24.
//

import CoreData
import RxSwift
import RxCocoa
import core

protocol HomeStorageProtocol {
    func isPokemonAdded(name: String) -> Observable<Bool>
}

class HomeStorage {
    static let sharedInstance = HomeStorage()
}

extension HomeStorage: HomeStorageProtocol {
    func isPokemonAdded(name: String) -> Observable<Bool> {
        return Observable.create { observer in
            var isAdded = false
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                observer.onError("Unable to access AppDelegate" as! Error)
                return Disposables.create()
            }
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName : "MyPokemon")
            fetchRequest.predicate = NSPredicate(format: "name = %@", name)
            
            do {
                let result = try context.fetch(fetchRequest) as! [NSManagedObject]
                if result.count > 0 {
                    isAdded = true
                }
            } catch let error {
                Logger.printLog(error)
            }
            
            observer.onNext(isAdded)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
}


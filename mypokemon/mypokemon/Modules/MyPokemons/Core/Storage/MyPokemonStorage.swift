//
//  MyPokemonStorage.swift
//  mypokemon
//
//  Created by Muhammad Fachri Nuriza on 29/03/24.
//

import CoreData
import RxSwift
import RxCocoa
import core

protocol MyPokemonStorageProtocol {
    func getPokemons() -> Observable<[Pokemon]>
    func deletePokemon(name: String) -> Observable<String>
}

class MyPokemonStorage {
    static let sharedInstance = MyPokemonStorage()
}

extension MyPokemonStorage: MyPokemonStorageProtocol {
    func getPokemons() -> Observable<[Pokemon]> {
        return Observable.create { observer in
            var myPokemons = [Pokemon]()
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                observer.onError("Unable to access AppDelegate" as! Error)
                return Disposables.create()
            }
            
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName : "MyPokemon")
            
            do {
                let result = try context.fetch(fetchRequest) as! [NSManagedObject]
                for data in result {
                    myPokemons.append(
                        Pokemon(
                            name: data.value(forKey: "name") as? String,
                            nickname: data.value(forKey: "nickname") as? String,
                            changedCount: data.value(forKey: "changedCount") as? Int
                            
                        )
                    )
                }
            } catch let error {
                Logger.printLog(error)
            }
            
            observer.onNext(myPokemons)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func deletePokemon(name: String) -> Observable<String> {
        return Observable.create { observer in
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                observer.onError("Unable to access AppDelegate" as! Error)
                return Disposables.create()
            }
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName : "MyPokemon")
            fetchRequest.predicate = NSPredicate(format: "name = %@", name)
            do {
                let fetch = try context.fetch(fetchRequest)
                let delete = fetch[0] as! NSManagedObject
                context.delete(delete)
                try context.save()
                
                observer.onNext(ServiceSuccess.successDeletePokemon)
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
}

//
//  DetailStorage.swift
//  mypokemon
//
//  Created by Muhammad Fachri Nuriza on 29/03/24.
//

import CoreData
import RxSwift
import RxCocoa
import core

protocol DetailStorageProtocol {
    func getMyPokemonDetail(name: String) -> Observable<Pokemon?>
    func getPokemons() -> Observable<[Pokemon]>
    func addPokemon(request: Pokemon) -> Observable<String>
    func deletePokemon(name: String) -> Observable<String>
}

class DetailStorage {
    static let sharedInstance = DetailStorage()
}

extension DetailStorage: DetailStorageProtocol {
    func getMyPokemonDetail(name: String) -> Observable<Pokemon?> {
        return Observable.create { observer in
            var myPokemon: Pokemon?
            
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
                    let pokemon = result[0]
                    myPokemon = Pokemon(
                        name: pokemon.value(forKey: "name") as? String,
                        nickname: pokemon.value(forKey: "nickname") as? String,
                        changedCount: pokemon.value(forKey: "changedCount") as? Int
                    )
                }
            } catch let error {
                Logger.printLog(error)
            }
            
            observer.onNext(myPokemon)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func getPokemons() -> Observable<[Pokemon]> {
        return Observable.create { observer in
            var favoriteList = [Pokemon]()
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                observer.onError("Unable to access AppDelegate" as! Error)
                return Disposables.create()
            }
            
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName : "MyPokemon")
            
            do {
                let result = try context.fetch(fetchRequest) as! [NSManagedObject]
                for data in result {
                    favoriteList.append(
                        Pokemon(
                            name: data.value(forKey: "name") as? String
                        )
                    )
                }
            } catch let error {
                Logger.printLog(error)
            }
            
            observer.onNext(favoriteList)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func addPokemon(request: Pokemon) -> Observable<String> {
        return Observable.create { observer in
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                observer.onError("Unable to access AppDelegate" as! Error)
                return Disposables.create()
            }
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "MyPokemon", in: context)
            
            let insert = NSManagedObject(entity: entity!, insertInto: context)
            insert.setValue(request.name, forKey: "name")
            
            do{
                try context.save()
                observer.onNext(ServiceSuccess.successAddPokemon)
                observer.onCompleted()
            } catch _ {
                observer.onError(ServiceFailure.failedAddPokemon as! Error)
            }
            
            return Disposables.create()
        }
    }
    
    func deletePokemon(name: String) -> Observable<String> {
        return Observable.create { observer in
            let randomNumber = Int.random(in: 1...100) // create 50% chance success
            if self.isPrimeNumber(number: randomNumber) {
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
            } else {
                let error = NSError(domain: "Failed", code: 0, userInfo: [NSLocalizedDescriptionKey: "The return is not Primer Number"])
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    func isPrimeNumber(number: Int) -> Bool {
        guard number > 1 else {
            return false
        }
        
        for i in 2...Int(sqrt(Double(number))) {
            if number % i == 0 {
                return false
            }
        }
        
        return true
    }
}

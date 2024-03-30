//
//  AddingPokemonStorage.swift
//  mypokemon
//
//  Created by Muhammad Fachri Nuriza on 29/03/24.
//

import CoreData
import RxSwift
import RxCocoa
import core

protocol AddingPokemonStorageProtocol {
    func addPokemon(request: Pokemon) -> Observable<String>
    func updatePokemon(request: Pokemon) -> Observable<String>
}

class AddingPokemonStorage {
    static let sharedInstance = DetailStorage()
}

extension AddingPokemonStorage: AddingPokemonStorageProtocol {
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
            insert.setValue(request.nickname, forKey: "nickname")
            insert.setValue(request.changedCount, forKey: "changedCount")
            
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
    
    func updatePokemon(request: Pokemon) -> Observable<String> {
        return Observable.create { observer in
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                observer.onError("Unable to access AppDelegate" as! Error)
                return Disposables.create()
            }
            let context = appDelegate.persistentContainer.viewContext
            
            // Mencari entitas Pokemon yang akan diperbarui
            let fetchRequest: NSFetchRequest<MyPokemon> = MyPokemon.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", request.name ?? "")
            
            do {
                let results = try context.fetch(fetchRequest)
                guard let pokemon = results.first else {
                    observer.onError("Pokemon not found" as! Error)
                    return Disposables.create()
                }
                
                // Memperbarui nilai-nilai entitas
                pokemon.nickname = request.nickname
                pokemon.changedCount = Int16(request.changedCount ?? 0)
                
                // Menyimpan perubahan ke dalam Core Data
                try context.save()
                
                observer.onNext(ServiceSuccess.successUpdatePokemon)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }

}

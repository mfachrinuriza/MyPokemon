//
//  Storage.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import Foundation

public protocol StorageProtocol {
    func get<T>(key: String, type: T.Type) -> T? where T : Codable
    func set<T>(key: String, item: T) where T : Codable
    func delete(key: String)
}

public class Storage: StorageProtocol {
    
    public static let shared = Storage()
    
    public func get<T>(key: String, type: T.Type) -> T? where T : Codable {
        guard let data = UserDefaults.standard.object(forKey: key) as? Data else { return nil }
        
        // Decode JSON data to object
        do {
            let item = try JSONDecoder().decode(type, from: data)
            
//            print("[STORAGE - GET] \(key): \(item)")
            
            return item
        } catch {
            print("Fail to decode item for keychain: \(error)")
            return nil
        }
    }
    
    public func set<T>(key: String, item: T) where T : Codable {
        do {
            // Encode as JSON data and save in keychain
            let data = try JSONEncoder().encode(item)
            
            UserDefaults.standard.set(data, forKey: key)
            
//            print("[STORAGE - SET] \(key): \(item)")
            
        } catch {
            print("Fail to encode item for keychain: \(error)")
        }
    }
    
    public func delete(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
}

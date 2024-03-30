//
//  SecureStorage.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import Foundation

public protocol SecureStorageProtocol: StorageProtocol { }

public class SecureStorage: SecureStorageProtocol {
    static let shared = SecureStorage()
    
    
    public func get<T>(key: String, type: T.Type) -> T? where T : Codable {
        
        // Read item data from keychain
        let query = [
            kSecAttrAccount: key,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        guard let data = result as? Data else { return nil }
        
        // Decode JSON data to object
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            assertionFailure("Fail to decode item for keychain: \(error)")
            return nil
        }
    }
    
    public func set<T>(key: String, item: T) where T : Codable {
        
        do {
            // Encode as JSON data and save in keychain
            let data = try JSONEncoder().encode(item)

            
            let query = [
                kSecValueData: data,
                kSecAttrAccount: key,
                kSecClass: kSecClassGenericPassword
            ] as CFDictionary
            
            // Add data in query to keychain
            let status = SecItemAdd(query, nil)
            
            if status == errSecDuplicateItem {
                // Item already exist, thus update it.
                let query = [
                    kSecAttrAccount: key,
                    kSecClass: kSecClassGenericPassword,
                ] as CFDictionary
                
                let attributesToUpdate = [kSecValueData: data] as CFDictionary
                
                // Update existing item
                SecItemUpdate(query, attributesToUpdate)
            }
        } catch {
            assertionFailure("Fail to encode item for keychain: \(error)")
        }
    }
    
    public func delete(key: String) {
        let query = [
            kSecAttrAccount: key,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary
        
        // Delete item from keychain
        SecItemDelete(query)
    }
    
}

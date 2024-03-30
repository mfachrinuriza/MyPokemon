//
//  ManagerAssembly.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import Swinject
import SwinjectAutoregistration
import core

class ManagerAssembly: Assembly {
    
    func assemble(container: Container) {
        container.autoregister(StorageProtocol.self, initializer: Storage.init).inObjectScope(.container)
        container.autoregister(SecureStorageProtocol.self, initializer: SecureStorage.init).inObjectScope(.container)
    }
    
}

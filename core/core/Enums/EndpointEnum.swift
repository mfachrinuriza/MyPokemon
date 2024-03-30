//
//  EndpointEnum.swift
//  core
//
//  Created by Muhammad Fachri Nuriza on 15/02/24.
//

import Foundation

public enum API {
    public static let pokemonList = "pokemon"
    public static var pokemonDetail = { (name: String) in
        return "pokemon/\(name)"
    }
}

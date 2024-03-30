//
//  Pokemon.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import Foundation

public struct Pokemon: Codable {
    public var name: String?
    public var nickname: String?
    public var changedCount: Int?
    
    public init(
        name: String? = nil,
        nickname: String? = nil,
        changedCount: Int? = nil
    ) {
        self.name = name
        self.nickname = nickname
        self.changedCount = changedCount
    }
}

public struct PokemonDetail: Codable {
    public var sprites: PokemonSprites?
    public var height: Double?
    public var weight: Double?
    public var name: String?
    public var base_experience: Int?
    public var types: [PokemonTypes]?
    public var moves: [PokemonMoves]?
    
    public init(
        sprites: PokemonSprites? = nil,
        height: Double? = nil,
        weight: Double? = nil,
        name: String? = nil,
        base_experience: Int? = nil
    ) {
        self.sprites = sprites
        self.height = height
        self.weight = weight
        self.name = name
        self.base_experience = base_experience
    }
}

public struct PokemonTypes: Codable {
    public var slot: Int?
    public var type: PokemonType?
}

public struct PokemonType: Codable {
    public var name: String?
    public var url: String?
}

public struct PokemonMoves: Codable {
    public var move: PokemonMove?
}

public struct PokemonMove: Codable {
    public var name: String?
    public var url: String?
}


public struct PokemonSprites: Codable {
    public var front_default: String?
    public var other: SpritesOther?
}

public struct SpritesOther: Codable {
    public var dream_world: DreamWorld?
}

public struct DreamWorld: Codable {
    public var front_default: String?
}

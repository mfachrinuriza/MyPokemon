//
//  WordingEnum.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 14/02/24.
//

import Foundation

public enum Wording {
    public static let success = "Success"
    public static let error = "Eror"
    public static let systemError = "Maaf, terjadi kesalahan sistem"
    public static let qrInvalid = "Maaf, QRIS anda tidak valid"
}

public enum ServiceSuccess {
    public static let successAddPokemon = "Add Pokemont Success"
    public static let successUpdatePokemon = "Update Pokemont Success"
    public static let successDeletePokemon = "Delete Pokemont Success"
}

public enum ServiceFailure {
    public static let failedAddPokemon = "Add Pokemont Failed"
}

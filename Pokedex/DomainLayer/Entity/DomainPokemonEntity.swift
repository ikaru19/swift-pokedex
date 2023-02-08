//
//  DomainEntity.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import Foundation

extension Domain {
    struct PokemonEntity {
        var id: String
        var name: String
        var image: String
        var weight: String?
        var types: [String]
        var abilities: [String]
    }
}

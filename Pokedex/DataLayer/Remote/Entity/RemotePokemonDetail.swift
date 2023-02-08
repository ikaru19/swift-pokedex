//
//  RemotePokemonDetail.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import Foundation

extension Data {
    struct RemotePokemonDetail {
        var id: Int?
        var name: String?
        var weight: Int?
        var abilities: [Data.RemotePokemonAbility]
        var types: [Data.RemotePokemonType]
    }
    
    struct RemotePokemonAbility {
        var ability: Data.RemotePokemonAbilityDetail?
        var isHidden: Bool?
        var slot: Int?
    }
    
    struct RemotePokemonAbilityDetail {
        var name: String?
        var url: String?
    }
    
    struct RemotePokemonType{
        var slot: Int?
        var type: RemotePokemonTypeDetail
    }
    struct RemotePokemonTypeDetail{
        var name: String?
        var url: String?
    }
}

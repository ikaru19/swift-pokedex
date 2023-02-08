//
//  LocalPokemonEntity.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import Foundation
import RealmSwift

class LocalPokemonEntity: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var ability: String = ""
    @objc dynamic var weight: String = ""

    convenience init(
        id: String,
        name: String,
        image: String,
        type: String,
        ability: String,
        weight: String
    ) {
        self.init()
        self.id = id
        self.name = name
        self.image = image
        self.type = type
        self.ability = ability
        self.weight = weight
    }
    
    override static func primaryKey() -> String? {
        "id"
    }
}

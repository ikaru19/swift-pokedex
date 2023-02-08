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

    convenience init(
        id: String,
        name: String,
        image: String
    ) {
        self.init()
        self.id = id
        self.name = name
        self.image = image
    }
    
    override static func primaryKey() -> String? {
        "id"
    }
}

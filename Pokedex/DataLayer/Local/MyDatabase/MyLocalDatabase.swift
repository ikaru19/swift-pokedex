//
//  MyLocalDatabase.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import Foundation
import RealmSwift

final class MyLocalDatabase {
    func instantiate(queue: DispatchQueue? = nil) throws -> Realm {
        try RealmHelper.GeneralDatabase.instantiate(queue: queue)
    }
}

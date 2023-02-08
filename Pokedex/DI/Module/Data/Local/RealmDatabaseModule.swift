//
//  RealmDatabaseModule.swift
//  perqara
//
//  Created by Muhammad Syafrizal on 07/02/23.
//

import Foundation
import Cleanse

struct RealmDatabaseModule: Module {
    static func configure(binder: SingletonScope) {
        binder.bind(MyLocalDatabase.self)
                .sharedInScope()
                .to {
                    MyLocalDatabase()
                }
        binder.bind(PokemonLocalDataSource.self)
                .sharedInScope()
                .to { (database: MyLocalDatabase) in
                    database
                }
    }
}

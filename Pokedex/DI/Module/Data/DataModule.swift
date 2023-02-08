//
//  DataModule.swift
//  perqara
//
//  Created by Muhammad Syafrizal on 06/02/23.
//

import Foundation
import Cleanse

struct DataModule: Module {
    static func configure(binder: SingletonScope) {
        binder.include(module: NetworkingModule.self)
        binder.include(module: MyAPIModule.self)
        binder.include(module: RealmDatabaseModule.self)
        
        // MARK: API
        binder.bind(GetPokemonListDataSource.self)
                .sharedInScope()
                .to { (api: MyJsonAPI) in
                    api
                }
        // MARK: API
        binder.bind(GetPokemonDetailDataSource.self)
                .sharedInScope()
                .to { (api: MyJsonAPI) in
                    api
                }
    }
}

//
//  PokemonLocalDataSource.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import Foundation
import RxSwift
import RealmSwift

protocol PokemonLocalDataSource: AnyObject {
    func insertPokemon(
        pokemon: LocalPokemonEntity
    ) -> Completable
    
    func fetchAll() -> Single<[LocalPokemonEntity]>
    
    func deleteBy(
        id: String
    ) -> Completable
}

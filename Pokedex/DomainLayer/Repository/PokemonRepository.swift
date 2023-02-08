//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import Foundation
import RxSwift

protocol PokemonRepository: AnyObject {
    func getPokemon(byName: String) -> Single<Domain.PokemonEntity>
    func getPokemonList(page: Int) -> Single<[Domain.PokemonEntity]>
    
    func insertPokemonToLocal(data: Domain.PokemonEntity) -> Completable
    func deletePokemon(byId: String) -> Completable
    func fetchAllLocalPokemon() -> Single<[Domain.PokemonEntity]>
    func fetchLocalPokemon(byId: String) -> Single<[Domain.PokemonEntity]>
}

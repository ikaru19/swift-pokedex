//
//  FavoriteViewModel.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import Foundation
import RxSwift

protocol FavoriteViewModel: AnyObject {
    var errors: Observable<Error> { get }
    var pokemonLists: Observable<[Domain.PokemonEntity]> { get }
    
    func getLocalPokemon()
    func deletePokemon(byId: String)
}

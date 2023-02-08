//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import Foundation
import RxSwift

protocol PokemonDetailViewModel: AnyObject {
    var errors: Observable<Error> { get }
    var pokemonData: Observable<Domain.PokemonEntity> { get }
    
    func getPokemonDetail(byName: String)
    func insetPokemonToLocal(data: Domain.PokemonEntity)
}

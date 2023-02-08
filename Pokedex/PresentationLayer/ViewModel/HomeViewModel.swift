//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import Foundation
import RxSwift

protocol HomeViewModel: AnyObject {
    var errors: Observable<Error> { get }
    var pokemonLists: Observable<[Domain.PokemonEntity]> { get }
    var lastPage: Int? { get set }
    
    func getPokemonList(page: Int)
}

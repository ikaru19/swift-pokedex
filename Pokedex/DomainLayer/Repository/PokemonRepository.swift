//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import Foundation
import RxSwift

protocol PokemonRepository: AnyObject {
    func getGame(byName: String) -> Single<Domain.PokemonEntity>
    func getGameList(page: Int) -> Single<[Domain.PokemonEntity]>
}

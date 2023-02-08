//
//  GetPokemonListDataSource.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import Foundation
import RxSwift
import Alamofire

protocol GetPokemonListDataSource: AnyObject {
    func getPokemonListDataSource(page: Int) -> Single<[Data.RemotePokeList]>
}

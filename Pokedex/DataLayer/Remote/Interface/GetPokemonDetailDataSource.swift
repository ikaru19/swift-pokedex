//
//  GetPokemonDetailDataSource.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import Foundation
import RxSwift
import Alamofire

protocol GetPokemonDetailDataSource: AnyObject {
    func getPokemonDetailDataSource(name: String) -> Single<Data.RemotePokemonDetail>
}

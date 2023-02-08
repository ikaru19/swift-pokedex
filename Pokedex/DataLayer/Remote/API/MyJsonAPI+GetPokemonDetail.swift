//
//  MyJsonAPI+GetPokemonDetail.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire

extension MyJsonAPI: GetPokemonDetailDataSource {
    func getPokemonDetailDataSource(name: String) -> RxSwift.Single<Data.RemotePokemonDetail> {
        let endpoint = "pokemon/\(name)"
        return Single.create(subscribe: { [weak self] observer in
            self?
                .jsonRequestService
                .get(
                    to: endpoint,
                    param: [:],
                    header: [:]
                )
                .subscribe(
                    onNext: { [weak self] data in
                        if let dict = data as? [String: Any],
                           let pokeDetail = self?.rawDataMapper(dictionary: dict) {
                            observer(.success(pokeDetail))
                        }
                        observer(.error(DataError(reason: .selfIsNull, line: 37)))
                    },
                    onError: { [weak self] error in
                        observer(.error(error))
                    }
                )
            return Disposables.create()
        })
    }
    
    
}

private extension MyJsonAPI {
    func rawDataMapper(dictionary: [String:Any]) -> Data.RemotePokemonDetail? {
        var data: Data.RemotePokemonDetail?
        var abilities: [Data.RemotePokemonAbility] = []
        var types: [Data.RemotePokemonType] = []
        if let rawAbilities: [[String: Any]] = dictionary["abilities"] as? [[String : Any]] {
             for processed in rawAbilities {
                 if let rawAbility: [String: Any] = processed["ability"] as? [String : Any] {
                     let data = Data.RemotePokemonAbility(
                        ability: Data.RemotePokemonAbilityDetail(
                            name: rawAbility["name"] as? String,
                            url: rawAbility["url"] as? String
                        ),
                        isHidden: processed["is_hidden"] as? Bool,
                        slot: processed["slot"] as? Int
                     )
                    abilities.append(data)
                 }
             }
        }
        if let rawTypes: [[String: Any]] = dictionary["types"] as? [[String : Any]] {
             for processed in rawTypes {
                 if let rawType: [String: Any] = processed["type"] as? [String : Any] {
                     let data = Data.RemotePokemonType(
                        slot: processed["slot"] as? Int,
                        type: Data.RemotePokemonTypeDetail(
                            name: rawType["name"] as? String,
                            url: rawType["url"] as? String
                        )
                     )
                    types.append(data)
                 }
             }
        }
        data = Data.RemotePokemonDetail(
            id: dictionary["id"] as? Int,
            name: dictionary["name"] as? String,
            weight: dictionary["weight"] as? Int,
            abilities: abilities,
            types: types
        )
        return data
    }
}

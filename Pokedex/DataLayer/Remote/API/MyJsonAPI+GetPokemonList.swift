//
//  MyJsonAPI+GetPokemonList.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire

extension MyJsonAPI: GetPokemonListDataSource {
    func getPokemonListDataSource(page: Int) -> RxSwift.Single<[Data.RemotePokeList]> {
        let endpoint = "pokemon"
        let params : [String: Any?] = [
            "offset": page,
            "limit": 20
        ]
        return Single.create(subscribe: { [weak self] observer in
            self?
                .jsonRequestService
                .get(
                    to: endpoint,
                    param: params.compactMapValues {
                        $0
                    },
                    header: [:]
                )
                .subscribe(
                    onNext: { [weak self] data in
                        var gameData : [Data.RemotePokeList] = []
                        if let dict = data as? [String: Any] {
                            let processedData = self?.rawDataMapper(dictionary: dict)
                            gameData.append(contentsOf: processedData ?? [])
                        }
                        observer(.success(gameData))
                        
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
    func rawDataMapper(dictionary: [String:Any]) -> [Data.RemotePokeList] {
        var games : [Data.RemotePokeList] = []
        if let results: [[String: Any]] = dictionary["results"] as? [[String : Any]] {
             for processed in results {
                 let data = Data.RemotePokeList(
                    name: processed["name"] as? String,
                    url: processed["url"] as? String
                 )
                 games.append(data)
             }
        }
        return games
    }
}

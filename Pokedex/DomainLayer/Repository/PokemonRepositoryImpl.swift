//
//  PokemonRepositoryImpl.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import Foundation
import RxSwift

class PokemonRepositoryImpl: PokemonRepository {
    private var getPokemonListDataSource: GetPokemonListDataSource
    private var getPokemonDetailDataSource: GetPokemonDetailDataSource
    private var disposeBag = DisposeBag()
    
    init(
        getPokemonListDataSource: GetPokemonListDataSource,
        getPokemonDetailDataSource: GetPokemonDetailDataSource
    ) {
        self.getPokemonListDataSource = getPokemonListDataSource
        self.getPokemonDetailDataSource = getPokemonDetailDataSource
    }
    
    func getGame(byName: String) -> RxSwift.Single<Domain.PokemonEntity> {
        Single.create(subscribe: { [self] observer in
            getPokemonDetailDataSource
                .getPokemonDetailDataSource(name: byName)
                    .subscribe(
                            onSuccess: { [weak self] data in
                                guard let self = self else {
                                    observer(.error(DomainError(reason: .selfIsNull, line: 37)))
                                    return
                                }
                                if let processedData = self.rawDataMapper(data: data) {
                                    observer(.success(processedData))
                                } else {
                                    observer(.error(DomainError(reason: .noData, line: 37)))
                                }
                            },
                            onError: { error in
                                observer(.error(error))
                            }
                    ).disposed(by: disposeBag)
            return Disposables.create()
        })
    }
    
    func getGameList(page: Int) -> RxSwift.Single<[Domain.PokemonEntity]> {
        Single.create(subscribe: { [self] observer in
            getPokemonListDataSource
                .getPokemonListDataSource(page: page)
                .subscribe(
                    onSuccess: { [weak self] data in
                        if let self = self {
                            var finalData = self.rawDataMapper(datas: data)
                            observer(.success(finalData))
                        }
                        observer(.error(DomainError(reason: .noData, line: 89)))
                    },
                    onError: { error in
                        observer(.error(error))
                        
                    }
                ).disposed(by: disposeBag)
            return Disposables.create()
        })
    }
}

extension PokemonRepositoryImpl {
    private func rawDataMapper(datas: [Data.RemotePokeList]) -> [Domain.PokemonEntity] {
        var finalData : [Domain.PokemonEntity] = []
        for data in datas {
            if let url = data.url,
               let name = data.name {
                let urlArr = url.components(separatedBy: "/")
                let id = urlArr[urlArr.count - 2]
                let rawData = Domain.PokemonEntity(
                    id: id,
                    name: name,
                    image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png",
                    types: [],
                    abilities: []
                )
                finalData.append(rawData)
            }
        }
        return finalData
    }
    
    private func rawDataMapper(data: Data.RemotePokemonDetail) -> Domain.PokemonEntity? {
        guard let id = data.id,
              let name = data.name else {
            return nil
        }
        return Domain.PokemonEntity(
            id: String(id),
            name: name,
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png",
            types: data.types.compactMap( {$0.type.name }),
            abilities: data.abilities.compactMap( {$0.ability?.name })
        )
    }

}

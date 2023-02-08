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
    private var localPokemonDataSource: PokemonLocalDataSource
    private var disposeBag = DisposeBag()
    
    init(
        getPokemonListDataSource: GetPokemonListDataSource,
        getPokemonDetailDataSource: GetPokemonDetailDataSource,
        localPokemonDataSource: PokemonLocalDataSource
    ) {
        self.getPokemonListDataSource = getPokemonListDataSource
        self.getPokemonDetailDataSource = getPokemonDetailDataSource
        self.localPokemonDataSource = localPokemonDataSource
    }
    
    func getPokemon(byName: String) -> RxSwift.Single<Domain.PokemonEntity> {
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
    
    func getPokemonList(page: Int) -> RxSwift.Single<[Domain.PokemonEntity]> {
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
    
    // MARK: LOCAL
    func insertPokemonToLocal(data: Domain.PokemonEntity) -> RxSwift.Completable {
        let local = self.rawDataMapper(data: data)
        return localPokemonDataSource.insertPokemon(pokemon: local)
    }
    
    func deletePokemon(byId: String) -> RxSwift.Completable {
        localPokemonDataSource.deleteBy(id: byId)
    }
    
    func fetchAllLocalPokemon() -> RxSwift.Single<[Domain.PokemonEntity]> {
        Single.create(subscribe: { [self] observer in
                localPokemonDataSource
                .fetchAll()
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
    
    func fetchLocalPokemon(byId: String) -> RxSwift.Single<[Domain.PokemonEntity]> {
        Single.create(subscribe: { [self] observer in
                localPokemonDataSource
                .fetch(byId: byId)
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
              let name = data.name,
              let weight = data.weight else {
            return nil
        }
        return Domain.PokemonEntity(
            id: String(id),
            name: name,
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png",
            weight: String(weight),
            types: data.types.compactMap( {$0.type.name }),
            abilities: data.abilities.compactMap( {$0.ability?.name })
        )
    }
    
    private func rawDataMapper(data: Domain.PokemonEntity) -> LocalPokemonEntity {
        let uuid = UUID().uuidString
        var id = "\(data.name)_\(uuid)"
        return LocalPokemonEntity(
            id: id,
            name: data.name,
            image: data.image,
            type: data.types.joined(separator: ","),
            ability: data.abilities.joined(separator: ","),
            weight: data.weight ?? "-"
        )
    }
    
    private func rawDataMapper(datas: [LocalPokemonEntity]) -> [Domain.PokemonEntity] {
        var finalData: [Domain.PokemonEntity] = []
        for data in datas {
            let pokemon = Domain.PokemonEntity(
                id: data.id,
                name: data.name,
                image: data.image,
                weight: data.weight,
                types: data.type.components(separatedBy: ","),
                abilities: data.ability.components(separatedBy: ",")
            )
            finalData.append(pokemon)
        }
        return finalData
    }

}

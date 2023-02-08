//
//  MyLocalDatabase+Pokemon.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import Foundation
import RxSwift
import RealmSwift

extension MyLocalDatabase: PokemonLocalDataSource {
    func insertPokemon(pokemon: LocalPokemonEntity) -> RxSwift.Completable {
        Completable.create(subscribe: { observer in
                    guard let realm = try? self.instantiate() else {
                        observer(.error(RealmError(reason: .cantInit, line: 16)))
                        return Disposables.create()
                    }

                    do {
                        try realm.safeWrite {
                            realm.add(pokemon, update: .all)
                        }
                        observer(.completed)
                    } catch {
                        observer(.error(error))
                    }
                    return Disposables.create()
                })
    }
    
    func fetchAll() -> RxSwift.Single<[LocalPokemonEntity]> {
        Single.create(subscribe: { observer in
            guard let realm = try? self.instantiate() else {
                observer(.error(RealmError(reason: .cantInit, line: 16)))
                return Disposables.create()
            }
            do {
                realm.refresh()
                let result =  realm
                    .objects(LocalPokemonEntity.self)
                observer(.success(Array(result)))
                
            } catch {
                observer(.error(error))
                
            }
            return Disposables.create()
        })
    }
    
    func deleteBy(id: String) -> RxSwift.Completable {
        Completable.create(subscribe: { observer in
                    do {
                        guard let realm = try? self.instantiate() else {
                            observer(.error(RealmError(reason: .cantInit, line: 56)))
                            return Disposables.create()
                        }

                        realm.refresh()

                        try realm.safeWrite {
                            realm.delete(
                                realm.objects(LocalPokemonEntity.self)
                                    .filter(
                                        NSPredicate(
                                            format: """
                                                    id == %@
                                                    """,
                                            id
                                        )
                                    )
                            )
                        }

                        observer(.completed)
                    } catch {
                        observer(.error(error))
                    }
                    return Disposables.create()
                })
    }
}

//
//  FavoriteViewModelImpl.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import Foundation
import RxSwift
import RxRelay

class FavoriteViewModelImpl: FavoriteViewModel {
    private var _errors: PublishRelay<Error> = PublishRelay()
    private var _pokemonLists: PublishRelay<[Domain.PokemonEntity]> = PublishRelay()
    private var disposeBag = DisposeBag()
    var pokemonRepository: PokemonRepository
    
    init(pokemonRepository: PokemonRepository) {
        self.pokemonRepository = pokemonRepository
    }
    
    var errors: Observable<Error> {
        _errors.asObservable()
    }
    
    var pokemonLists: Observable<[Domain.PokemonEntity]> {
        _pokemonLists.asObservable()
    }
    
    func getLocalPokemon() {
        pokemonRepository
            .fetchAllLocalPokemon()
            .subscribe(
                onSuccess: { [weak self] data in
                    self?._pokemonLists.accept(data)
                },
                onError: { [weak self] error in
                    self?._errors.accept(error)
                }
            ).disposed(by: disposeBag)
    }
    
    func deletePokemon(byId: String) {
        pokemonRepository
            .deletePokemon(byId: byId)
            .subscribe(
                onError: { [weak self] error in
                    self?._errors.accept(error)
                }
            ).disposed(by: disposeBag)
    }
    
}

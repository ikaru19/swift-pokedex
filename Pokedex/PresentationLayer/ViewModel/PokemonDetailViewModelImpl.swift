//
//  PokemonDetailViewModelImpl.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import Foundation
import RxSwift
import RxRelay

class PokemonDetailViewModelImpl: PokemonDetailViewModel {
    private var _errors: PublishRelay<Error> = PublishRelay()
    private var _pokemonData: PublishRelay<Domain.PokemonEntity> = PublishRelay()
    var pokemonRepository: PokemonRepository
    private var disposeBag = DisposeBag()
    
    init(pokemonRepository: PokemonRepository) {
        self.pokemonRepository = pokemonRepository
    }
    
    var errors: RxSwift.Observable<Error> {
        _errors.asObservable()
    }
    
    var pokemonData: RxSwift.Observable<Domain.PokemonEntity> {
        _pokemonData.asObservable()
    }
    
    func getPokemonDetail(byName: String) {
        pokemonRepository
            .getPokemon(byName: byName)
            .subscribe(
                onSuccess: { [weak self] data in
                    self?._pokemonData.accept(data)
                },
                onError: { [weak self] error in
                    self?._errors.accept(error)
                }
            )
            .disposed(by: disposeBag)
    }
    
    
    func insetPokemonToLocal(data: Domain.PokemonEntity) {
        pokemonRepository
            .insertPokemonToLocal(data: data)
            .subscribe(
                onError: { [weak self] error in
                    self?._errors.accept(error)
                }
            )
            .disposed(by: disposeBag)
    }
}

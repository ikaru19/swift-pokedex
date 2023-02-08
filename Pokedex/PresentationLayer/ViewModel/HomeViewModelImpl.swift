//
//  HomeViewModelImpl.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import Foundation
import RxSwift
import RxRelay

class HomeViewModelImpl: HomeViewModel {
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
    
    var lastPage: Int?
    
    func getPokemonList(page: Int) {
        let offset = 20 * page
        pokemonRepository
            .getPokemonList(page: offset)
            .subscribe(
                onSuccess: { [weak self] data in
                    self?._pokemonLists.accept(data)
                },
                onError: { [weak self] error in
                    self?._errors.accept(error)
                }
            ).disposed(by: disposeBag)
    }
    
}

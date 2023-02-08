//
//  DomainModule.swift
//  perqara
//
//  Created by Muhammad Syafrizal on 07/02/23.
//

import Foundation
import Cleanse

struct DomainModule: Module {
    static func configure(binder: UnscopedBinder) {
        binder.bind(PokemonRepository.self)
                .to(factory: PokemonRepositoryImpl.init)
    }
}

//
//  UIKitControllerModule.swift
//  perqara
//
//  Created by Muhammad Syafrizal on 07/02/23.
//

import Foundation
import Cleanse

struct UIKitControllerModule: Module {
    static func configure(binder: UnscopedBinder) {
        binder.bind(Presentation.UiKit.HomeViewController.self)
            .to {
                Presentation.UiKit.HomeViewController(nibName: nil, bundle: nil, viewModel: $0)
            }
        binder.bind(Presentation.UiKit.PokemonDetailViewController.self)
            .to {
                Presentation.UiKit.PokemonDetailViewController(nibName: nil, bundle: nil, viewModel: $0)
            }
        binder.bind(Presentation.UiKit.FavoriteViewContoller.self)
            .to {
                Presentation.UiKit.FavoriteViewContoller(nibName: nil, bundle: nil, viewModel: $0)
            }
    }
}

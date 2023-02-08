//
//  ViewControllerResolver.swift
//  perqara
//
//  Created by Muhammad Syafrizal on 07/02/23.
//

import Foundation
import Cleanse

protocol ViewControllerResolver: AnyObject {
    func instantiateHomeViewController() -> Provider<Presentation.UiKit.HomeViewController>
    func instantiateFavoriteViewController() -> Provider<Presentation.UiKit.FavoriteViewContoller>
    func instantiateDetailViewController() -> Provider<Presentation.UiKit.PokemonDetailViewController>
}

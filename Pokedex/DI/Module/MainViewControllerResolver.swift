//
//  MainViewControllerResolver.swift
//  perqara
//
//  Created by Muhammad Syafrizal on 07/02/23.
//

import Foundation
import Cleanse

class MainViewControllerResolver: ViewControllerResolver {
    var homeVcProvider: Provider<Presentation.UiKit.HomeViewController>
    var detailVcProvider: Provider<Presentation.UiKit.PokemonDetailViewController>
    var favoriteVcProvider: Provider<Presentation.UiKit.FavoriteViewContoller>
    
    init(
        homeVcProvider: Provider<Presentation.UiKit.HomeViewController>,
        favoriteVcProvider: Provider<Presentation.UiKit.FavoriteViewContoller>,
        detailVcProvider: Provider<Presentation.UiKit.PokemonDetailViewController>
    ) {
        self.homeVcProvider = homeVcProvider
        self.detailVcProvider = detailVcProvider
        self.favoriteVcProvider = favoriteVcProvider
    }

    func instantiateHomeViewController() -> Provider<Presentation.UiKit.HomeViewController> {
        homeVcProvider
    }
    
    func instantiateDetailViewController() -> Cleanse.Provider<Presentation.UiKit.PokemonDetailViewController> {
        detailVcProvider
    }
    
    func instantiateFavoriteViewController() -> Cleanse.Provider<Presentation.UiKit.FavoriteViewContoller> {
        favoriteVcProvider
    }
}

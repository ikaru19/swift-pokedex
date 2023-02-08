//
//  AppComponent.swift
//  Pokedex
//
//  Created by Muhammad Syafrizal on 08/02/23.
//

import Foundation
import Cleanse

struct AppComponent: Cleanse.RootComponent {
    typealias Root = PropertyInjector<AppDelegate>
    typealias Scope = Singleton

    static func configure(binder: SingletonScope) {
        binder.include(module: CoreModule.self)
    }

    static func configureRoot(
            binder bind: ReceiptBinder<PropertyInjector<AppDelegate>>
    ) -> BindingReceipt<PropertyInjector<AppDelegate>> {
        bind.propertyInjector(configuredWith: AppComponent.configureAppDelegateInjector)
    }
}

extension AppComponent {
    static func configureAppDelegateInjector(
            binder bind: PropertyInjectionReceiptBinder<AppDelegate>
    ) -> BindingReceipt<PropertyInjector<AppDelegate>> {
        bind.to(injector: AppDelegate.injectProperties)
    }
}

//
//  PresentationModule.swift
//  perqara
//
//  Created by Muhammad Syafrizal on 06/02/23.
//

import Cleanse

struct PresentationModule: Module {
    static func configure(binder: SingletonScope) {
        binder.include(module: UIKitModule.self)
        binder.include(module: MainPageModule.self)
        binder.include(module: ViewModelModule.self)
        binder.include(module: UIKitControllerModule.self)
    }
}

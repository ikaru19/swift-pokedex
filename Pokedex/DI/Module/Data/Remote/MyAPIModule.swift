//
//  MyAPIModule.swift
//  perqara
//
//  Created by Muhammad Syafrizal on 06/02/23.
//

import Foundation
import Cleanse

struct MyAPIModule: Module {
    static func configure(binder: SingletonScope) {
        binder.bind()
                .sharedInScope()
                .to(factory: MyJsonAPI.init)
    }
}

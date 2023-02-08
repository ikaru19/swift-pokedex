//
//  NetworkingModule.swift
//  perqara
//
//  Created by Muhammad Syafrizal on 06/02/23.
//

import Foundation
import Cleanse
import Alamofire

struct MyBaseUrl: Tag {
    typealias Element = String
}

struct NetworkingModule: Module {
    static func configure(binder: SingletonScope) {
        binder.bind(String.self)
            .tagged(with: MyBaseUrl.self)
            .to {
                Constants.BASE_API_URL
            }
        binder.bind(JsonRequest.self)
                .sharedInScope()
                .to(factory: MyAFRequest.init)
    }
}

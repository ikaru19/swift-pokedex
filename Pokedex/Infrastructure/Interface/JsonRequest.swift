//
//  JsonRequest.swift
//  perqara
//
//  Created by Muhammad Syafrizal on 06/02/23.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

protocol JsonRequest: AnyObject {
    func get(
            to endPoint: String,
            param: [String: Any],
            header: [String: String]
    ) -> Observable<Any>
}

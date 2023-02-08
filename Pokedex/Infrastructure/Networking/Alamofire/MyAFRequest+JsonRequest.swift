//
//  MyAFRequest+JsonRequest.swift
//  perqara
//
//  Created by Muhammad Syafrizal on 06/02/23.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

extension MyAFRequest: JsonRequest {
    func get(
            to endPoint: String,
            param: [String: Any],
            header: [String: String]
    ) -> Observable<Any> {
        let endPoint = injectBaseUrl(endPoint: endPoint)
        return RxAlamofire.json(
                .get,
                endPoint,
                parameters: param,
                encoding: URLEncoding.default,
                headers: HTTPHeaders(header)
        )
    }
}

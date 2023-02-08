//
//  InjectorResolver.swift
//  perqara
//
//  Created by Muhammad Syafrizal on 06/02/23.
//

import Foundation

protocol InjectorResolver: AnyObject {
    func inject(_ viewController: ViewController)
}

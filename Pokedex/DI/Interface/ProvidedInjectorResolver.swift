//
//  ProvidedInjectorResolver.swift
//  perqara
//
//  Created by Muhammad Syafrizal on 06/02/23.
//

import Foundation

protocol ProvideInjectorResolver: AnyObject {
    var injectorResolver: InjectorResolver { get }
}

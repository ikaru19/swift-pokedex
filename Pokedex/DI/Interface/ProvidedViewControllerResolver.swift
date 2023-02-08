//
//  ProvidedViewControllerResolver.swift
//  perqara
//
//  Created by Muhammad Syafrizal on 07/02/23.
//

import Foundation

protocol ProvideViewControllerResolver: AnyObject {
    var vcResolver: ViewControllerResolver { get }
}

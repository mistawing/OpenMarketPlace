//
//  Mappable.swift
//  Transformer
//
//  Created by incetro on 18/06/2017.
//  Copyright © 2017 Incetro. All rights reserved.
//

import Foundation

// MARK: - Mappable

public protocol Mappable {

    /// Standard initializer
    ///
    /// - Parameters:
    ///   - resolver: resolver which can give necessary
    ///               values for the initializing object
    init(with resolver: Resolver) throws
}

//
//  MappingDataBuilder.swift
//  Transformer
//
//  Created by incetro on 18/06/2017.
//  Copyright © 2017 Incetro. All rights reserved.
//

import Foundation

// MARK: - MappingDataBuilder

public protocol MappingDataBuilder {
    
    @discardableResult func checkData<C>(from object: Any, to clazz: C.Type) throws -> Bool where C: Mappable
    
    /// Mapping from some object to dictionary (with its properties)
    ///
    /// - Parameter object: input object
    /// - Returns: PlainObject
    /// - Throws: Mapping error
    func data(from object: Any) throws -> MappableDict
}

extension MappingDataBuilder {
    
    /// Mapping from some object to array of dictionary (with its properties)
    ///
    /// - Parameter objects: input array
    /// - Returns: PlainObjects array
    /// - Throws: Mapping error
    func data(from objects: [Any]) throws -> [MappableDict] {
        return try objects.map {
            try self.data(from: $0)
        }
    }
}

//
//  Transformer.swift
//  Transformer
//
//  Created by incetro on 18/06/2017.
//  Copyright © 2017 Incetro. All rights reserved.
//

import Foundation

// MARK: - Transformer

public class Transformer {
    
    /// Mapping builder
    internal let builder: MappingDataBuilder
    
    /// Standard initializer
    ///
    /// - Parameter builder: mapping data builder
    public init(with builder: MappingDataBuilder) {
        self.builder = builder
    }
    
    /// Mapping type initializer
    ///
    /// - Parameter type: mapping type
    public init(from type: MappingType) {
        self.builder = type.builder
    }
    
    /// Map some object to PlainObject's instance
    ///
    /// - Parameter object: input object
    /// - Returns: PlainObject
    /// - Throws: mapping error
    public func transform<C>(from object: Any) throws -> C where C: Mappable {
        try builder.checkData(from: object, to: C.self)
        let dictionary = try self.builder.data(from: object)
        let resolver = Resolver(with: dictionary)
        return try C(with: resolver)
    }
    
    /// Map some objects to PlainObjects' instance
    ///
    /// - Parameter objects: input array
    /// - Returns: PlainObjects array
    /// - Throws: mapping error
    public func transform<C>(from objects: [Any]) throws -> [C] where C: Mappable {
        try builder.checkData(from: objects, to: C.self)
        return try objects.map {
            try self.transform(from: $0)
        }
    }
    
    /// Map some objects to PlainObjects' instance
    ///
    /// - Parameter objects: input array
    /// - Returns: PlainObjects array
    /// - Throws: mapping error
    public func transform<C>(from object: Any) throws -> [C] where C: Mappable {
        guard let objects = object as? [Any] else {
            throw MappingError.unknownMappingObjectType(type: type(of: object))
        }
        return try self.transform(from: objects)
    }
}

extension Transformer {
    
    /// Map some object to PlainObject's instance
    ///
    /// - Parameters:
    ///   - type: mapping type
    ///   - object: input object
    /// - Returns: PlainObject
    /// - Throws: mapping error
    public static func transform<C>(from type: MappingType, object: Any) throws -> C where C: Mappable {
        return try Transformer(from: type).transform(from: object)
    }
    
    /// Map some objects to PlainObjects' instance
    ///
    /// - Parameters:
    ///   - type: mapping type
    ///   - objects: input array
    /// - Returns: PlainObject
    /// - Throws: mapping error
    public static func transform<C>(from type: MappingType, objects: [Any]) throws -> [C] where C: Mappable {
        return try Transformer(from: type).transform(from: objects)
    }
    
    /// Map some object to PlainObject's instance
    ///
    /// - Parameters:
    ///   - type: mapping type
    ///   - object: input object
    /// - Returns: PlainObjects array
    /// - Throws: mapping error
    public static func transform<C>(from type: MappingType, object: Any) throws -> [C] where C: Mappable {
        return try Transformer(from: type).transform(from: object)
    }
}

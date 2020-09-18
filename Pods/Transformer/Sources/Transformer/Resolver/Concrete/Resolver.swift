//
//  Resolver.swift
//  Transformer
//
//  Created by incetro on 18/06/2017.
//  Copyright © 2017 Incetro. All rights reserved.
//

import Foundation

// MARK: - Resolver

public class Resolver {

    /// All values
    internal let map: MappableDict

    /// Standard initializer
    ///
    /// - Parameter map: all values
    public init(with map: MappableDict) {
        self.map = map
    }

    internal func valueFromMap(by key: String) throws -> Any {
        guard let index = map.index(forKey: key) else {
            throw MappingError.unexistingKey(key)
        }
        return map[index].value
    }

    /// Returns value of the given type using some key
    ///
    /// - Parameter key: key of the necessary value
    /// - Returns: value of the given type
    /// - Throws: mapping error
    public func value<T>(_ key: String) throws -> T {
        if let result = try self.valueFromMap(by: key) as? T {
            return result
        } else {
            throw MappingError.incompatibleType(key: key, expectedType: T.self)
        }
    }
}

extension Resolver {
    
    /// Returns RawRepresentable value
    ///
    /// - Parameter key: key of the necessary value
    /// - Returns: value of the given type
    /// - Throws: mapping error
    public func value<T>(_ key: String) throws -> T where T: RawRepresentable {
        let value: T.RawValue = try self.value(key)
        guard let result = T(rawValue: value) else {
            throw MappingError.incompatibleType(key: key, expectedType: T.self)
        }
        return result
    }
    
    /// Returns RawRepresentable value
    ///
    /// - Parameter key: key of the necessary value
    /// - Returns: value of the given type
    /// - Throws: mapping error
    public func value<T>(_ key: String) throws -> T? where T: RawRepresentable {
        guard let value: T.RawValue = try? self.value(key) else {
            return nil
        }
        return T(rawValue: value)
    }
    
    /// Returns RawRepresentable values
    ///
    /// - Parameter key: key of the necessary value
    /// - Returns: value of the given type
    /// - Throws: mapping error
    public func value<T>(_ key: String) throws -> [T] where T: RawRepresentable {
        guard let values: [T.RawValue] = try self.value(key) else {
            throw MappingError.incompatibleType(key: key, expectedType: [MappableDict].self)
        }
        return values.flatMap { value in
            T(rawValue: value)
        }
    }
    
    /// Returns RawRepresentable values
    ///
    /// - Parameter key: key of the necessary value
    /// - Returns: value of the given type
    /// - Throws: mapping error
    public func value<T>(_ key: String) throws -> [T?] where T: RawRepresentable {
        guard let values: [T.RawValue] = try self.value(key) else {
            throw MappingError.incompatibleType(key: key, expectedType: [MappableDict].self)
        }
        return values.map { value in
            T(rawValue: value)
        }
    }
    
    /// Returns RawRepresentable values
    ///
    /// - Parameter key: key of the necessary value
    /// - Returns: value of the given type
    /// - Throws: mapping error
    public func value<T>(_ key: String) throws -> [T]? where T: RawRepresentable {
        if let values: [T.RawValue] = try? self.value(key) {
            return values.flatMap { value in
                T(rawValue: value)
            }
        }
        return nil
    }
    
    /// Returns RawRepresentable values
    ///
    /// - Parameter key: key of the necessary value
    /// - Returns: value of the given type
    /// - Throws: mapping error
    public func value<T>(_ key: String) throws -> [T?]? where T: RawRepresentable {
        if let values: [T.RawValue] = try? self.value(key) {
            return values.map { value in
                T(rawValue: value)
            }
        }
        return nil
    }
}

extension Resolver {
    
    /// Returns dictionary for the given key
    ///
    /// - Parameter key: key of the necessary dictionary
    /// - Returns: found dictionary
    /// - Throws: dictionary search error
    internal func dictionary(`for` key: String) throws -> MappableDict {
        guard let result: MappableDict = try self.value(key) else {
            throw MappingError.incompatibleType(key: key, expectedType: MappableDict.self)
        }
        return result
    }
    
    /// Returns array of dictionaries for the given key
    ///
    /// - Parameter key: key of the dictionaries
    /// - Returns: found array
    /// - Throws: array search error
    internal func array(`for` key: String) throws -> [MappableDict] {
        guard let result: [MappableDict] = try self.value(key) else {
            throw MappingError.incompatibleType(key: key, expectedType: [MappableDict].self)
        }
        return result
    }
    
    /// Returns value of the nested type
    ///
    /// - Parameter key: key of the necessary value
    /// - Returns: value of the given type
    /// - Throws: Mapping error
    public func value<T>(_ key: String) throws -> T where T: Mappable {
        let dictionary = try self.dictionary(for: key)
        return try T(with: Resolver(with: dictionary))
    }
    
    /// Returns value of the nested array type
    ///
    /// - Parameter key: value's key
    /// - Returns: value of the given array type
    /// - Throws: mapping error
    public func value<T>(_ key: String) throws -> [T] where T: Mappable {
        let dictionary = try self.array(for: key)
        return try dictionary.map {
            try T(with: Resolver(with: $0))
        }
    }
}

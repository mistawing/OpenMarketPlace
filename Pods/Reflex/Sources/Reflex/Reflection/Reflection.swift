//
//  Reflection.swift
//  Reflection
//
//  Created by incetro on 27/06/2017.
//  Copyright © 2017 Incetro. All rights reserved.
//

import Foundation

// MARK: - Reflection

/// Reflection model

public class Reflection {
    
    /// Current name
    public let name: String
    
    /// Current value
    public let value: Any
    
    /// Current type
    public let type: ReflectionType
    
    /// Children for the current Reflection
    public var children: [Reflection] = []
    
    /// Standard initializer
    ///
    /// - Parameters:
    ///   - name: reflection name
    ///   - value: reflection value
    ///   - type: reflection type
    ///   - children: reflection children
    public init(name: String, value: Any, type: ReflectionType, children: [Reflection] = []) {
        self.name = name
        self.type = type
        self.value = value
        self.children = children
    }
}

// MARK: - Types

public extension Reflection {
    
    /// A value type of the current Reflection
    public var valueType: ReflectionValueType {
        return type.valueType
    }
    
    /// A general type of the current Reflection
    public var generalType: ReflectionGeneralType {
        return type.generalType
    }
    
    /// All children types of current Reflection
    public var types: [String] {
        return children.map {
            $0.valueType.description
        }
    }
}

// MARK: - Name

public extension Reflection {
    
    /// Returns short name of the current Reflection
    public var shortName: String {
        return name.components(separatedBy: ".").last ?? ""
    }
}

// MARK: - Children options

public extension Reflection {
 
    /// Returns value for the given child name
    ///
    /// - Parameter key: some child name
    public subscript (key: String) -> Any? {
        return children.first { $0.name == key }?.value
    }
    
    /// Child for the given name
    ///
    /// - Parameter key: child name
    /// - Returns: found child
    public func children(_ key: String) -> Reflection? {
        return children.first { $0.name == key }
    }
    
    /// Value for the given child name
    ///
    /// - Parameter key: child name
    /// - Returns: value with type casting
    public func value<U>(for key: String) -> U? {
        return self[key] as? U
    }
    
    /// All available children count
    var childrenCount: Int {
        return children.count
    }
    
    /// Children names
    var names: [String] {
        return children.map { $0.name }
    }
    
    /// Children values
    var values: [Any] {
        return children.map { $0.value }
    }
}

// MARK: - Dictionary

public extension Reflection {
    
    /// Convert children to dictionary
    public var toDictionary: [String: Any] {
        var result: [String: Any] = [:]
        for item in children {
            result[item.name] = item.value
        }
        return result
    }
    
    /// Convert children to NSDictionary
    public var toNSDictionary: NSDictionary {
        return toDictionary as NSDictionary
    }
}

// MARK: - Simple checkers

public extension Reflection {
    
    /// Check if object is class
    var isClass: Bool {
        switch type.valueType {
        case .class:
            return true
        default:
            return false
        }
    }
    
    /// Check if object is struct
    var isStruct: Bool {
        switch type.valueType {
        case .struct:
            return true
        default:
            return false
        }
    }
    
    /// Check if object is enum
    var isEnum: Bool {
        switch type.valueType {
        case .enum:
            return true
        default:
            return false
        }
    }
    
    /// Check if object is optional
    var isOptional: Bool {
        return type.generalType == .optional
    }
    
    /// Check if object is array
    var isArray: Bool {
        switch type.valueType {
        case .array:
            return true
        default:
            return false
        }
    }
    
    /// Check if object is set
    var isSet: Bool {
        switch type.valueType {
        case .set:
            return true
        default:
            return false
        }
    }
    
    /// Check if object is dictionary
    var isDictionary: Bool {
        switch type.valueType {
        case .dictionary:
            return true
        default:
            return false
        }
    }
}

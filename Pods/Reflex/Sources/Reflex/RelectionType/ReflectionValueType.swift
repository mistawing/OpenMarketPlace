//
//  ReflectionValueType.swift
//  Reflection
//
//  Created by incetro on 29/06/2017.
//  Copyright © 2017 Incetro. All rights reserved.
//

import Foundation

// MARK: - ReflectionValueType

public indirect enum ReflectionValueType {
    
    // standard types
    case any
    case bool
    case int8
    case int16
    case int32
    case int64
    case uInt8
    case uInt16
    case uInt32
    case uInt64
    case int
    case uInt
    case double
    case float
    case string
    
    // collection types
    case collection(of: ReflectionValueType)
    case array(of: ReflectionValueType)
    case set(of: ReflectionValueType)
    case dictionary(key: ReflectionValueType, value: ReflectionValueType)
    
    // tuple type
    case tuple(of: [ReflectionValueType])
    
    // custom type (If Reflector can't determine the type, he will call it custom)
    case custom(named: String)
    
    // complex types
    case `class`(named: String)
    case `struct`(named: String)
    case `enum`(named: String)
}

// MARK: - CustomStringConvertible

extension ReflectionValueType: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .any:
            return "Any"
        case .bool:
            return "Bool"
        case .int8:
            return "Int8"
        case .int16:
            return "Int16"
        case .int32:
            return "Int32"
        case .int64:
            return "Int64"
        case .uInt8:
            return "UInt8"
        case .uInt16:
            return "UInt16"
        case .uInt32:
            return "UInt32"
        case .uInt64:
            return "UInt64"
        case .int:
            return "Int"
        case .uInt:
            return "UInt"
        case .double:
            return "Double"
        case .float:
            return "Float"
        case .string:
            return "String"
        case .collection(of: let reflection):
            return "Collection<\(reflection)>"
        case .array(of: let reflection):
            return "Array<\(reflection)>"
        case .set(of: let reflection):
            return "Set<\(reflection)>"
        case .dictionary(key: let keyReflection, value: let valueReflection):
            return "Dictionary<\(keyReflection), \(valueReflection)>"
        case .tuple(of: let reflections):
            return "(\(reflections.map { $0.description }.joined(separator: ", ")))"
        case .class(named: let name):
            return "class<\(name)>"
        case .struct(named: let name):
            return "struct<\(name)>"
        case .enum(named: let name):
            return "enum<\(name)>"
        case .custom(named: let name):
            return "custom<\(name)>"
        }
    }
}

// MARK: - Equatable

extension ReflectionValueType: Equatable {
    public static func ==(lhs: ReflectionValueType, rhs: ReflectionValueType) -> Bool {
        return lhs.description == rhs.description
    }
}

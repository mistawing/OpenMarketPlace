//
//  ReflectionType.swift
//  Reflection
//
//  Created by incetro on 29/06/2017.
//  Copyright © 2017 Incetro. All rights reserved.
//

import Foundation

// MARK: - ReflectionType

public struct ReflectionType {
    public let generalType: ReflectionGeneralType
    public let valueType: ReflectionValueType
}

// MARK: - CustomStringConvertible

extension ReflectionType: CustomStringConvertible {
    public var description: String {
        switch generalType {
        case .optional:
            return "Optional<\(valueType)>"
        case .implicitlyUnwrapped:
            return "ImplicitlyUnwrappedOptional<\(valueType)>"
        default:
            return valueType.description
        }
    }
}

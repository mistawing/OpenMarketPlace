//
//  MappingError.swift
//  Transformer
//
//  Created by incetro on 18/06/2017.
//  Copyright © 2017 Incetro. All rights reserved.
//

import Foundation

// MARK: - MappingError

/// Mapping errors
///
/// - unexistingKey: unexisting key in map
/// - incompatibleType: incompatible types during mapping
/// - unknownMappingObjectType: unknown object type for mapping
/// - incorrectMappingObjectTypes: incorrect result type for mapping
/// - cannotBuildMapFromObject: cannot create dictionary from the given object
public enum MappingError: Error {
    case unexistingKey(String)
    case incompatibleType(key: String, expectedType: Any)
    case unknownMappingObjectType(type: Any)
    case incorrectMappingObjectTypes(from: String, to: String)
    case cannotBuildMapFromObject(type: Any)
}

extension MappingError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .unexistingKey(let key):
            return "Unexisting key '\(key)' in map"
        case .incompatibleType(let key, let type):
            return "Cannot cast value from key '\(key)' to '\(type)'"
        case .unknownMappingObjectType(let type):
            return "Unknown mapping object type: '\(type)'"
        case .cannotBuildMapFromObject(let type):
            return "Cannot build map from object with type '\(type)'"
        case .incorrectMappingObjectTypes(let model, let plain):
            return "Cannot map from '\(model)' to '\(plain)'"
        }
    }
}

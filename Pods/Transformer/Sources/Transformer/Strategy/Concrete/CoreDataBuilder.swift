//
//  CoreDataBuilder.swift
//  Transformer
//
//  Created by incetro on 18/06/2017.
//  Copyright © 2017 Incetro. All rights reserved.
//

import CoreData

// MARK: - CoreDataBuilder

public class CoreDataBuilder {
    
    private let modelObjectPrefix: String
    private let plainObjectPrefix: String
    
    public init() {
        self.modelObjectPrefix = "ModelObject"
        self.plainObjectPrefix = "PlainObject"
    }
    
    public init(modelObjectPrefix: String, plainObjectPrefix: String) {
        self.modelObjectPrefix = modelObjectPrefix
        self.plainObjectPrefix = plainObjectPrefix
    }
    
    // MARK: - Internal
    
    /// Build dictionary from NSManagedObject
    ///
    /// - Parameters:
    ///   - managedObject: NSManagedObject instance
    ///   - ignoredProperties: ignored properties to break cycles
    /// - Returns: built dicionary
    private func convertManagedObject(_ managedObject: NSManagedObject, ignoredProperties: [String]) -> Any? {
        let properties = managedObject.propertyNames()
        let ignoredProperties = ignoredProperties + ignoringProperties(of: managedObject, properties: properties)
        var map: MappableDict = [:]
        for property in properties where !ignoredProperties.contains(property) {
            if let value = managedObject.value(forKey: property), let ponsoValue = convertObject(value, ignoredProperties: ignoredProperties) {
                map[property] = ponsoValue
            }
        }
        return map
    }
    
    /// Returns the inverse name for the given relationship property of NSManagedObject
    ///
    /// - Parameters:
    ///   - relationship: given relationship property
    ///   - managedObject: object with the given relationship property
    /// - Returns: inverse name for the given relationship property of NSManagedObject
    private func inverseNameForRelationship(_ relationship: String, forManagedObject managedObject: NSManagedObject) -> String? {
        return managedObject.entity.relationshipsByName[relationship]?.inverseRelationship?.name
    }
    
    /// Find all ignored properties for NSManagedObject
    ///
    /// - Parameters:
    ///   - object: NSManagedObject instance
    ///   - properties: properties for the given NSManagedObject
    /// - Returns: all ignored properties for NSManagedObject
    private func ignoringProperties(of object: NSManagedObject, properties: [String]) -> [String] {
        var ignoredProperties: [String] = []
        for property in properties where object.responds(to: Selector(property)) {
            if let ignoredRelationship = inverseNameForRelationship(property, forManagedObject: object) {
                ignoredProperties.append(ignoredRelationship)
            }
        }
        return ignoredProperties
    }
    
    /// Build a dictionary value from the given object
    ///
    /// - Parameters:
    ///   - object: object with its properties
    ///   - ignoredProperties: ignored properties to break cycles
    /// - Returns: Representation of the input object (dictionary, array...)
    private func convertObject(_ object: Any, ignoredProperties: [String]) -> Any? {
        if let nsobject = object as? NSObject {
            if let set = nsobject as? NSSet {
                var result: [Any] = []
                let arr = set.allObjects as NSArray
                for elem in arr {
                    if let plainInstance = convertObject(elem, ignoredProperties: ignoredProperties) {
                        result.append(plainInstance)
                    }
                }
                return result
            } else if let managedObject = nsobject as? NSManagedObject {
                return convertManagedObject(managedObject, ignoredProperties: ignoredProperties)
            }
        }
        return object
    }
}

// MARK: - MappingDataBuilder

extension CoreDataBuilder: MappingDataBuilder {
    
    public func checkData<C>(from object: Any, to clazz: C.Type) throws -> Bool where C : Mappable {
        
        if let arr = object as? [Any] {
            if arr.count == 0 {
                return true
            } else if let obj = arr.first {
                return try checkData(from: obj, to: C.self)
            }
        }
        
        let plainObjectClassName = String(describing: C.self).replacingOccurrences(of: plainObjectPrefix, with: "")
        let modelObjectClassName = String(describing: type(of: object)).replacingOccurrences(of: modelObjectPrefix, with: "")
        
        guard plainObjectClassName == modelObjectClassName else {
            throw MappingError.incorrectMappingObjectTypes(from: modelObjectClassName, to: plainObjectClassName)
        }
        
        return true
    }
    
    public func data(from object: Any) throws -> MappableDict {
        
        guard let managedObject = object as? NSManagedObject else {
            throw MappingError.unknownMappingObjectType(type: type(of: object))
        }
        
        guard let dictionary = convertManagedObject(managedObject, ignoredProperties: []) as? MappableDict else {
            throw MappingError.cannotBuildMapFromObject(type: type(of: managedObject))
        }
        
        return dictionary
    }
}

//
//  NSObject.swift
//  Transformer
//
//  Created by incetro on 18/06/2017.
//  Copyright © 2017 Incetro. All rights reserved.
//

import Foundation

internal extension NSObject {
    
    private class func propertyNames(`from` clazz: AnyClass) -> [String] {
        var results: [String] = []
        var count: UInt32 = 0
        if let properties = class_copyPropertyList(clazz, &count) {
            for i in 0..<count {
                let property = properties[Int(i)]
                let cname = property_getName(property)
                if let name = String(validatingUTF8: cname) {
                    results.append(name)
                }
            }
            free(properties)
            return results
        }
        
        return []
    }
    
    func propertyNames() -> [String] {
        return NSObject.propertyNames(from: self.classForCoder)
    }
    
    class func propertyNames() -> [String] {
        return NSObject.propertyNames(from: self.classForCoder())
    }
}

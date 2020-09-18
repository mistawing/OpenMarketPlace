//
//  MappingType.swift
//  Transformer
//
//  Created by incetro on 19/06/2017.
//  Copyright © 2017 Incetro. All rights reserved.
//

import Foundation

// MARK: - MappingType

public enum MappingType {
    
    case coredata
    
    var builder: MappingDataBuilder {
        switch self {
        case .coredata:
            return CoreDataBuilder()
        }
    }
}

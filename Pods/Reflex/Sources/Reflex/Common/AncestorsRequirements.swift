//
//  AncestorsRequirements.swift
//  Reflection
//
//  Created by incetro on 27/06/2017.
//  Copyright © 2017 Incetro. All rights reserved.
//

import Foundation

// MARK: - AncestorsRequirements

/// Requirements for getting properties from ancestors
///
/// - disabled: properties from the current class
/// - all: properties from all ancestors
/// - level: properties from the current class based on the given ancestors' depth
public enum AncestorsRequirements {
    case disabled
    case all
    case level(of: Int)
}

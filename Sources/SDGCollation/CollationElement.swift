//
//  CollationElement.swift
//  SDGCollation
//
//  Created by Jeremy David Giesbrecht on 2016‐06‐23.
//  Copyright © 2016 Jeremy David Giesbrecht. All rights reserved.
//

import Foundation

import SDGSwiftExtensions
import SDGFoundationExtensions

internal struct CollationElement: Archivable, EqualityOperators, JSONConvertible {
    
    // MARK: - Initialization
    
    private static func relative(index: Int, forLevel targetLevel: CollationLevel) -> (prefix: CollationElement, suffix: CollationElement) {
        
        var circumFix: (prefix: [[Int]], suffix: [[Int]]) = ([], [])
        for level in CollationLevel.all {
            if level < targetLevel {
                circumFix.prefix.append([])
                circumFix.suffix.append([])
            } else {
                if level.isInReverse {
                    circumFix.prefix.append([index])
                    circumFix.suffix.append([])
                } else {
                    circumFix.prefix.append([])
                    circumFix.suffix.append([index])
                }
            }
        }
        return (CollationElement(rawIndices: circumFix.prefix), CollationElement(rawIndices: circumFix.suffix))
    }
    
    internal static func beforeForLevel(level: CollationLevel) -> (prefix: CollationElement, suffix: CollationElement) {
        return relative(CollationOrder.BeforeIndex, forLevel: level)
    }
    
    internal static func afterForLevel(level: CollationLevel) -> (prefix: CollationElement, suffix: CollationElement) {
        return relative(CollationOrder.AfterIndex, forLevel: level)
    }
    
    internal init(rawIndices: [[Int]]) {
        assert(rawIndices.count == CollationLevel.all.count)
        indices = rawIndices
    }
    
    // MARK: - Properties
    
    var indices: [[Int]]
    
    // MARK: - Usage
    
    internal func indicesForLevel(level: CollationLevel) -> [Int] {
        return indices[level.rawValue]
    }
    
    // MARK: - Archivable
    internal static let prototype: Any = CollationElement(rawIndices: [])
    
    // MARK: - EqualityOperators
    
    internal static func equalsOperator(lhs: CollationElement, _ rhs: CollationElement) -> Bool {
        return lhs.indices.elementsEqual(rhs.indices, isEquivalent: {$0.elementsEqual($1)})
    }
    
    // MARK: - JSONConvertible
    
    internal var JSON: JSONValue {
        return JSONValue.ArrayValue(indices.map({JSONValue.ArrayValue($0.map({JSONValue.NumericValue($0 as NSNumber)}))}))
    }
    
    internal init(JSON: JSONValue) throws {
        switch JSON {
        case .ArrayValue(let array):
            indices = try array.map() {
                (value: JSONValue) -> [Int] in
                
                switch value {
                case .ArrayValue(let subArray):
                    return try subArray.map() {
                        (subValue: JSONValue) -> Int in
                        
                        switch subValue {
                        case .NumericValue(let number):
                            return number as Int
                        default:
                            throw SerializationError.InvalidData
                        }
                    }
                default:
                    throw SerializationError.InvalidData
                }
            }
        default:
            throw SerializationError.InvalidData
        }
    }
}
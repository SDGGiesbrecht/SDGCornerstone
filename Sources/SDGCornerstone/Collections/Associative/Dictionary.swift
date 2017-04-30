/*
 Dictionary.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Dictionary {

    /// Merges `other` into `self`, overwriting any duplicate keys.
    ///
    /// - Parameters:
    ///     - other: Another dictionary.
    public mutating func mergeByOverwriting(from other: [Key: Value]) {
        for (key, value) in other {
            self[key] = value
        }
    }

    /// Returns a dictionary formed by merging `other` into `self`, overwriting any duplicate keys.
    ///
    /// - Parameters:
    ///     - other: Another dictionary.
    public func mergedByOverwriting(from other: [Key: Value]) -> [Key: Value] {
        var result = self
        result.mergeByOverwriting(from: other)
        return result
    }

    /// Merges `other` into `self` by applying `combine` to each key pair.
    ///
    /// - Parameters:
    ///     - other: Another dictionary.
    ///     - combine: A closure that combines a pair of values.
    ///     - ownValue: The value from `self`.
    ///     - otherValue: The value from `other`.
    public mutating func merge<T>(with other: [Key: T], combine: (_ ownValue: Value?, _ otherValue: T?) -> Value?) {
        for key in Set(keys).union(other.keys) {
            self[key] = combine(self[key], other[key])
        }
    }

    /// Returns a dictionary formed by merging `other` into `self` by applying `combine` to each key pair.
    ///
    /// - Parameters:
    ///     - other: Another dictionary.
    ///     - combine: A closure that combines a pair of values.
    ///     - ownValue: The value from `self`.
    ///     - otherValue: The value from `other`.
    public func merged<T>(with other: [Key: T], combine: (_ ownValue: Value?, _ otherValue: T?) -> Value?) -> [Key: Value] {
        var result = self
        result.merge(with: other, combine: combine)
        return result
    }
}

extension Dictionary where Value : Equatable {
    // MARK: - where Value : Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.≠_]
    /// Returns `true` if the two values are inequal.
    ///
    /// - Parameters:
    ///     - lhs: A value to compare.
    ///     - rhs: Another value to compare.
    ///
    /// - RecommendedOver: !=
    public static func ≠(lhs: Dictionary, rhs: Dictionary) -> Bool {
        return lhs != rhs
    }
}

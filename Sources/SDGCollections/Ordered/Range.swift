/*
 Range.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

/// A member of the `Range` family: `Range`, `ClosedRange`, `CountableRange` or `CountableClosedRange`.
public protocol RangeFamily : ComparableSet, CustomDebugStringConvertible, CustomReflectable, CustomStringConvertible {

    // @documentation(SDGCornerstone.RangeFamily.Bound)
    /// The bound type.
    associatedtype Bound : Comparable

    // @documentation(SDGCornerstone.RangeFamily.lowerBound)
    /// The lower bound.
    var lowerBound: Bound { get }

    // @documentation(SDGCornerstone.RangeFamily.upperBound)
    /// The upper bound.
    var upperBound: Bound { get }

    // @documentation(SDGCornerstone.RangeFamily.contains(_:).)
    /// Returns `true` if `element` is within the range.
    ///
    /// - Parameters:
    ///     - element: The element.
    func contains(_ element: Bound) -> Bool

    // @documentation(SDGCornerstone.RangeFamily.overlaps(_:).)
    // #documentation(SDGCornerstone.ComparableSet.overlaps(_:))
    /// Returns `true` if the sets overlap.
    ///
    /// - Parameters:
    ///     - other: The other set.
    func overlaps(_ other: Self) -> Bool

    // @documentation(SDGCornerstone.RangeFamily.hasClosedUpperBound)
    /// `true` if the type has a closed upper bound.
    static var hasClosedUpperBound: Bool { get }
}

extension RangeFamily {

    // MARK: - ComparableSet

    // #documentation(SDGCornerstone.ComparableSet.⊆)
    /// Returns `true` if `precedingValue` is a subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    @inlinable public static func ⊆ (precedingValue: Self, followingValue: Self) -> Bool {
        return precedingValue.lowerBound ≥ followingValue.lowerBound ∧ precedingValue.upperBound ≤ followingValue.upperBound
    }

    // MARK: - SetDefinition

    // #documentation(SDGCornerstone.SetDefinition.∋)
    /// Returns `true` if `precedingValue` contains `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The set.
    ///     - followingValue: The element to test.
    @inlinable public static func ∋ (precedingValue: Self, followingValue: Bound) -> Bool {
        return precedingValue.contains(followingValue)
    }
}

extension Range : RangeFamily {

    // MARK: - RangeFamily

    // #documentation(SDGCornerstone.RangeFamily.hasClosedUpperBound)
    /// `true` if the type has a closed upper bound.
    @inlinable public static var hasClosedUpperBound: Bool {
        return false
    }

    // MARK: - SetDefinition

    // #documentation(SDGCornerstone.SetDefinition.Element)
    /// The element type.
    public typealias Element = Bound
}

extension ClosedRange : RangeFamily {

    // MARK: - RangeFamily

    // #documentation(SDGCornerstone.RangeFamily.hasClosedUpperBound)
    /// `true` if the type has a closed upper bound.
    @inlinable public static var hasClosedUpperBound: Bool {
        return true
    }

    // MARK: - SetDefinition

    // #documentation(SDGCornerstone.SetDefinition.Element)
    /// The element type.
    public typealias Element = Bound
}

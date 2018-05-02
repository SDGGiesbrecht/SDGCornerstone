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

    // [_Define Documentation: SDGCornerstone.RangeFamily.Bound_]
    /// The bound type.
    associatedtype Bound : Comparable

    // [_Define Documentation: SDGCornerstone.RangeFamily.lowerBound_]
    /// The lower bound.
    var lowerBound: Bound { get }

    // [_Define Documentation: SDGCornerstone.RangeFamily.upperBound_]
    /// The upper bound.
    var upperBound: Bound { get }

    // [_Define Documentation: SDGCornerstone.RangeFamily.contains(_:)._]
    /// Returns `true` if `element` is within the range.
    ///
    /// - Parameters:
    ///     - element: The element.
    func contains(_ element: Bound) -> Bool

    // [_Define Documentation: SDGCornerstone.RangeFamily.overlaps(_:)._]
    // [_Inherit Documentation: SDGCornerstone.ComparableSet.overlaps(_:)_]
    /// Returns `true` if the sets overlap.
    ///
    /// - Parameters:
    ///     - other: The other set.
    func overlaps(_ other: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.RangeFamily.hasClosedUpperBound_]
    /// `true` if the type has a closed upper bound.
    static var hasClosedUpperBound: Bool { get }
}

extension RangeFamily {

    // MARK: - ComparableSet

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊆_]
    /// Returns `true` if `precedingValue` is a subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    @_inlineable public static func ⊆ (precedingValue: Self, followingValue: Self) -> Bool {
        return precedingValue.lowerBound ≥ followingValue.lowerBound ∧ precedingValue.upperBound ≤ followingValue.upperBound
    }

    // MARK: - SetDefinition

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∋_]
    /// Returns `true` if `precedingValue` contains `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The set.
    ///     - followingValue: The element to test.
    @_inlineable public static func ∋ (precedingValue: Self, followingValue: Bound) -> Bool {
        return precedingValue.contains(followingValue)
    }
}

extension RangeFamily where Bound : Hashable {
    // MARK: - where Bound : Hashable

    // MARK: - Hashable

    // [_Inherit Documentation: SDGCornerstone.Hashable.hashValue_]
    /// The hash value.
    @_inlineable public var hashValue: Int {
        return lowerBound.hashValue ^ upperBound.hashValue
    }
}

extension Range : RangeFamily {

    // MARK: - RangeFamily

    // [_Inherit Documentation: SDGCornerstone.RangeFamily.hasClosedUpperBound_]
    /// `true` if the type has a closed upper bound.
    @_inlineable public static var hasClosedUpperBound: Bool {
        return false
    }

    // MARK: - SetDefinition

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.Element_]
    /// The element type.
    public typealias Element = Bound
}
extension Range : Hashable where Bound : Hashable {
    // MARK: - where Bound : Hashable
}

extension ClosedRange : RangeFamily {

    // MARK: - RangeFamily

    // [_Inherit Documentation: SDGCornerstone.RangeFamily.hasClosedUpperBound_]
    /// `true` if the type has a closed upper bound.
    @_inlineable public static var hasClosedUpperBound: Bool {
        return true
    }

    // MARK: - SetDefinition

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.Element_]
    /// The element type.
    public typealias Element = Bound
}
extension ClosedRange : Hashable where Bound : Hashable {
    // MARK: - where Bound : Hashable
}

extension CountableRange : RangeFamily {

    // MARK: - RangeFamily

    // [_Inherit Documentation: SDGCornerstone.RangeFamily.hasClosedUpperBound_]
    /// `true` if the type has a closed upper bound.
    @_inlineable public static var hasClosedUpperBound: Bool {
        return false
    }
}
extension CountableRange : Hashable where Bound : Hashable {
    // MARK: - where Bound : Hashable
}

extension CountableClosedRange : RangeFamily {

    // MARK: - RangeFamily

    // [_Inherit Documentation: SDGCornerstone.RangeFamily.hasClosedUpperBound_]
    /// `true` if the type has a closed upper bound.
    @_inlineable public static var hasClosedUpperBound: Bool {
        return true
    }
}
extension CountableClosedRange : Hashable where Bound : Hashable {
    // MARK: - where Bound : Hashable
}

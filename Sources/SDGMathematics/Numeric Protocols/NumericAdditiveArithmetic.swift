/*
 NumericAdditiveArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A one‐dimensional value that can be added and subtracted.
///
/// - Note: Unlike `WholeArithmetic` or `Swift.Numeric`, `NumericAdditiveArithmetic` does not need a defined scale, allowing conformance by measurements that can use multiple units.
///
/// Conformance Requirements:
///
/// - `AdditiveArithmetic`
/// - `Comparable`
/// - `Negatable`, `WholeNumberProtocol` or `mutating func formAbsoluteValue()`
public protocol NumericAdditiveArithmetic : AdditiveArithmetic, Comparable {

    // MARK: - Classification

    // [_Define Documentation: SDGCornerstone.NumericAdditiveArithmetic.isPositive_]
    /// Returns `true` if `self` is positive.
    var isPositive: Bool { get }

    // [_Define Documentation: SDGCornerstone.NumericAdditiveArithmetic.isNegative_]
    /// Returns `true` if `self` is negative.
    var isNegative: Bool { get }

    // [_Define Documentation: SDGCornerstone.NumericAdditiveArithmetic.isNonNegative_]
    /// Returns `true` if `self` is positive or zero.
    var isNonNegative: Bool { get }

    // [_Define Documentation: SDGCornerstone.NumericAdditiveArithmetic.isNonPositive_]
    /// Returns `true` if `self` is negative or zero.
    var isNonPositive: Bool { get }

    // MARK: - Operations

    // [_Define Documentation: SDGCornerstone.NumericAdditiveArithmetic.absoluteValue_]
    /// The absolute value.
    var absoluteValue: Self { get }

    // [_Define Documentation: SDGCornerstone.NumericAdditiveArithmetic.formAbsoluteValue_]
    /// Sets `self` to its absolute value.
    mutating func formAbsoluteValue()
}

extension NumericAdditiveArithmetic {

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.isPositive_]
    /// Returns `true` if `self` is positive.
    @_inlineable public var isPositive: Bool {
        return self > Self.additiveIdentity
    }

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.isNegative_]
    /// Returns `true` if `self` is negative.
    @_inlineable public var isNegative: Bool {
        return self < Self.additiveIdentity
    }

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.isNonNegative_]
    /// Returns `true` if `self` is positive or zero.
    @_inlineable public var isNonNegative: Bool {
        return self ≥ Self.additiveIdentity
    }

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.isNonPositive_]
    /// Returns `true` if `self` is negative or zero.
    @_inlineable public var isNonPositive: Bool {
        return self ≤ Self.additiveIdentity
    }

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.absoluteValue_]
    /// The absolute value.
    @_inlineable public var absoluteValue: Self {
        return nonmutatingVariant(of: Self.formAbsoluteValue, on: self)
    }
}

// [_Workaround: This should be made debug‐only once conditional compiling is available. (Swift 4.1)_]
/// :nodoc:
public struct _PartialAbsoluteValue<Wrapped : NumericAdditiveArithmetic> {
    /// :nodoc:
    @_inlineable public init(contents: Wrapped) {
        self.contents = contents
    }
    /// :nodoc:
    public var contents: Wrapped
}

// [_Define Documentation: SDGCornerstone.NumericAdditiveArithmetic.|x_]
// [_Example 1: Absolute Value_]
/// Returns the absolute value (in conjuction with postfix `|(_:)`).
///
/// ```swift
/// let x = −1
/// let y = |x|
/// XCTAssertEqual(y, 1)
/// ```
@_inlineable public prefix func | <Value>(operand: _PartialAbsoluteValue<Value>) -> Value {
    return operand.contents
}

// [_Define Documentation: SDGCornerstone.NumericAdditiveArithmetic.x|_]
// [_Example 1: Absolute Value_]
/// Returns the absolute value (in conjuction with prefix `|(_:)`).
///
/// ```swift
/// let x = −1
/// let y = |x|
/// XCTAssertEqual(y, 1)
/// ```
@_inlineable public postfix func | <Value>(operand: Value) -> _PartialAbsoluteValue<Value> {
    return _PartialAbsoluteValue(contents: operand.absoluteValue)
}

extension NumericAdditiveArithmetic where Self : Negatable {
    // MARK: - where Self : Negatable

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.formAbsoluteValue_]
    /// Sets `self` to its absolute value.
    @_inlineable public mutating func formAbsoluteValue() {
        if self < Self.additiveIdentity {
            self−=
        }
    }
}

extension NumericAdditiveArithmetic where Self : Numeric {
    // MARK: - where Self : Numeric

    /// The magnitude of this value.
    @_inlineable public var magnitude: Self {
        return |self|
    }
}

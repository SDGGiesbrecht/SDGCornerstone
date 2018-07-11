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

    // @documentation(SDGCornerstone.NumericAdditiveArithmetic.isPositive)
    /// Returns `true` if `self` is positive.
    var isPositive: Bool { get }

    // @documentation(SDGCornerstone.NumericAdditiveArithmetic.isNegative)
    /// Returns `true` if `self` is negative.
    var isNegative: Bool { get }

    // @documentation(SDGCornerstone.NumericAdditiveArithmetic.isNonNegative)
    /// Returns `true` if `self` is positive or zero.
    var isNonNegative: Bool { get }

    // @documentation(SDGCornerstone.NumericAdditiveArithmetic.isNonPositive)
    /// Returns `true` if `self` is negative or zero.
    var isNonPositive: Bool { get }

    // MARK: - Operations

    // @documentation(SDGCornerstone.NumericAdditiveArithmetic.absoluteValue)
    /// The absolute value.
    var absoluteValue: Self { get }

    // @documentation(SDGCornerstone.NumericAdditiveArithmetic.formAbsoluteValue)
    /// Sets `self` to its absolute value.
    mutating func formAbsoluteValue()
}

extension NumericAdditiveArithmetic {

    // #documentation(SDGCornerstone.NumericAdditiveArithmetic.isPositive)
    /// Returns `true` if `self` is positive.
    @_inlineable public var isPositive: Bool {
        return self > Self.additiveIdentity
    }

    // #documentation(SDGCornerstone.NumericAdditiveArithmetic.isNegative)
    /// Returns `true` if `self` is negative.
    @_inlineable public var isNegative: Bool {
        return self < Self.additiveIdentity
    }

    // #documentation(SDGCornerstone.NumericAdditiveArithmetic.isNonNegative)
    /// Returns `true` if `self` is positive or zero.
    @_inlineable public var isNonNegative: Bool {
        return self ≥ Self.additiveIdentity
    }

    // #documentation(SDGCornerstone.NumericAdditiveArithmetic.isNonPositive)
    /// Returns `true` if `self` is negative or zero.
    @_inlineable public var isNonPositive: Bool {
        return self ≤ Self.additiveIdentity
    }

    // #documentation(SDGCornerstone.NumericAdditiveArithmetic.absoluteValue)
    /// The absolute value.
    @_inlineable public var absoluteValue: Self {
        return nonmutatingVariant(of: Self.formAbsoluteValue, on: self)
    }
}

// [_Workaround: This should be made debug‐only once conditional compiling is available. (Swift 4.1.2)_]
/// :nodoc:
public struct _PartialAbsoluteValue<Wrapped : NumericAdditiveArithmetic> {
    /// :nodoc:
    @_inlineable public init(contents: Wrapped) {
        self.contents = contents
    }
    /// :nodoc:
    public var contents: Wrapped
}

// @documentation(SDGCornerstone.NumericAdditiveArithmetic.|x)
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

// @documentation(SDGCornerstone.NumericAdditiveArithmetic.x|)
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

    // #documentation(SDGCornerstone.NumericAdditiveArithmetic.formAbsoluteValue)
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

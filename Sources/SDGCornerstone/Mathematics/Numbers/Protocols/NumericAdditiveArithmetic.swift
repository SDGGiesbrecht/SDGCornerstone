/*
 NumericAdditiveArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.|x_]
/// Returns the absolute value (in conjuction with postfix `|(_:)`).
///
/// ```swift
/// let x = −1
/// let y = |x|
/// // y == 1
/// ```
prefix operator |

// [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.x|_]
/// Returns the absolute value (in conjuction with prefix `|(_:)`).
///
/// ```swift
/// let x = −1
/// let y = |x|
/// // y == 1
/// ```
postfix operator |

/// A one‐dimensional value that can be added and subtracted.
///
/// - Note: Unlike `WholeArithmetic`, `NumericAdditiveArithmetic` does not need a defined scale, allowing conformance by measurements that can use multiple units.
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
    ///
    /// - MutatingVariant: formAbsoluteValue
    var absoluteValue: Self { get }

    // [_Define Documentation: SDGCornerstone.NumericAdditiveArithmetic.formAbsoluteValue_]
    /// Sets `self` to its absolute value.
    ///
    /// - NonmutatingVariant: |
    mutating func formAbsoluteValue()
}

extension NumericAdditiveArithmetic {

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.isPositive_]
    /// Returns `true` if `self` is positive.
    public var isPositive: Bool {
        return self > Self.additiveIdentity
    }

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.isNegative_]
    /// Returns `true` if `self` is negative.
    public var isNegative: Bool {
        return self < Self.additiveIdentity
    }

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.isNonNegative_]
    /// Returns `true` if `self` is positive or zero.
    public var isNonNegative: Bool {
        return self ≥ Self.additiveIdentity
    }

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.isNonPositive_]
    /// Returns `true` if `self` is negative or zero.
    public var isNonPositive: Bool {
        return self ≤ Self.additiveIdentity
    }

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.absoluteValue_]
    /// The absolute value.
    ///
    /// - MutatingVariant: formAbsoluteValue
    public var absoluteValue: Self {
        var result = self
        result.formAbsoluteValue()
        return result
    }
}

// [_Workaround: This should be made debug‐only once conditional compiling is available. (Swift 3.1.0)_]
/// :nodoc:
public struct _PartialAbsoluteValue<Wrapped : NumericAdditiveArithmetic> {
    fileprivate init(contents: Wrapped) {
        self.contents = contents
    }
    fileprivate var contents: Wrapped
}

// [_Define Documentation: SDGCornerstone.NumericAdditiveArithmetic.|x_]
// [_Example 1: Absolute Value_]
/// Returns the absolute value (in conjuction with postfix `|(_:)`).
///
/// ```swift
/// let x = −1
/// let y = |x|
/// // y == 1
/// ```
public prefix func | <Value>(operand: _PartialAbsoluteValue<Value>) -> Value {
    return operand.contents
}

// [_Define Documentation: SDGCornerstone.NumericAdditiveArithmetic.x|_]
// [_Example 1: Absolute Value_]
/// Returns the absolute value (in conjuction with prefix `|(_:)`).
///
/// ```swift
/// let x = −1
/// let y = |x|
/// // y == 1
/// ```
public postfix func | <Value>(operand: Value) -> _PartialAbsoluteValue<Value> {
    return _PartialAbsoluteValue(contents: operand.absoluteValue)
}

extension NumericAdditiveArithmetic where Self : FloatFamily {
    // MARK: - where Self : FloatFamily

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.absoluteValue_]
    /// The absolute value.
    ///
    /// - MutatingVariant: formAbsoluteValue
    public var absoluteValue: Self {
        return Self.abs(self)
    }

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.formAbsoluteValue_]
    /// Sets `self` to its absolute value.
    ///
    /// - NonmutatingVariant: |
    public mutating func formAbsoluteValue() {
        self = Self.abs(self)
    }
}

extension NumericAdditiveArithmetic where Self : IntFamily {
    // MARK: - where Self : IntFamily

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.absoluteValue_]
    /// The absolute value.
    ///
    /// - MutatingVariant: formAbsoluteValue
    public var absoluteValue: Self {
        return Swift.abs(self)
    }

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.formAbsoluteValue_]
    /// Sets `self` to its absolute value.
    ///
    /// - NonmutatingVariant: |
    public mutating func formAbsoluteValue() {
        self = Swift.abs(self)
    }
}

extension NumericAdditiveArithmetic where Self : Measurement {
    // MARK: - where Self : Measurement

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.isPositive_]
    /// Returns `true` if `self` is positive.
    public var isPositive: Bool {
        return rawValue.isPositive
    }

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.isNegative_]
    /// Returns `true` if `self` is negative.
    public var isNegative: Bool {
        return rawValue.isNegative
    }

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.isNonNegative_]
    /// Returns `true` if `self` is positive or zero.
    public var isNonNegative: Bool {
        return rawValue.isNonNegative
    }

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.isNonPositive_]
    /// Returns `true` if `self` is negative or zero.
    public var isNonPositive: Bool {
        return rawValue.isNonPositive
    }

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.absoluteValue_]
    /// The absolute value.
    ///
    /// - MutatingVariant: formAbsoluteValue
    public var absoluteValue: Self {
        return Self(rawValue: rawValue.absoluteValue)
    }

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.formAbsoluteValue_]
    /// Sets `self` to its absolute value.
    ///
    /// - NonmutatingVariant: |
    public mutating func formAbsoluteValue() {
        rawValue.formAbsoluteValue()
    }
}

extension NumericAdditiveArithmetic where Self : Negatable {
    // MARK: - where Self : Negatable

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.formAbsoluteValue_]
    /// Sets `self` to its absolute value.
    ///
    /// - NonmutatingVariant: |
    public mutating func formAbsoluteValue() {
        if self < Self.additiveIdentity {
            self−=
        }
    }
}

extension NumericAdditiveArithmetic where Self : WholeNumberProtocol {
    // MARK: - where Self : WholeNumberProtocol

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.isNegative_]
    /// Returns `true` if `self` is negative.
    public var isNegative: Bool {
        return false
    }

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.isNonNegative_]
    /// Returns `true` if `self` is positive or zero.
    public var isNonNegative: Bool {
        return true
    }

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.formAbsoluteValue_]
    /// Sets `self` to its absolute value.
    ///
    /// - NonmutatingVariant: |
    public mutating func formAbsoluteValue() {
        // self = self
    }
}

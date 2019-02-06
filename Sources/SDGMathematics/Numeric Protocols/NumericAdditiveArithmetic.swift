/*
 NumericAdditiveArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

    /// Returns `true` if `self` is positive.
    var isPositive: Bool { get }

    /// Returns `true` if `self` is negative.
    var isNegative: Bool { get }

    /// Returns `true` if `self` is positive or zero.
    var isNonNegative: Bool { get }

    /// Returns `true` if `self` is negative or zero.
    var isNonPositive: Bool { get }

    // MARK: - Operations

    /// The absolute value.
    var absoluteValue: Self { get }

    /// Sets `self` to its absolute value.
    mutating func formAbsoluteValue()
}

extension NumericAdditiveArithmetic {

    @inlinable public var isPositive: Bool {
        return self > Self.additiveIdentity
    }

    @inlinable public var isNegative: Bool {
        return self < Self.additiveIdentity
    }

    @inlinable public var isNonNegative: Bool {
        return self ≥ Self.additiveIdentity
    }

    @inlinable public var isNonPositive: Bool {
        return self ≤ Self.additiveIdentity
    }

    @inlinable public var absoluteValue: Self {
        return nonmutatingVariant(of: { $0.formAbsoluteValue() }, on: self)
    }
}

// #workaround(Swift 4.2.1, This should be made debug‐only once conditional compiling is available.)
public struct _PartialAbsoluteValue<Wrapped : NumericAdditiveArithmetic> {
    @inlinable public init(contents: Wrapped) {
        self.contents = contents
    }
    public var contents: Wrapped
}

// #example(1, absoluteValue)
/// Returns the absolute value (in conjuction with postfix `|(_:)`).
///
/// ```swift
/// let x = −1
/// let y = |x|
/// XCTAssertEqual(y, 1)
/// ```
///
/// - Parameters:
///     - operand: The value.
@inlinable public prefix func | <Value>(operand: _PartialAbsoluteValue<Value>) -> Value {
    return operand.contents
}

// #example(1, absoluteValue)
/// Returns the absolute value (in conjuction with prefix `|(_:)`).
///
/// ```swift
/// let x = −1
/// let y = |x|
/// XCTAssertEqual(y, 1)
/// ```
///
/// - Parameters:
///     - operand: The value.
@inlinable public postfix func | <Value>(operand: Value) -> _PartialAbsoluteValue<Value> {
    return _PartialAbsoluteValue(contents: operand.absoluteValue)
}

extension NumericAdditiveArithmetic where Self : Negatable {

    @inlinable public mutating func formAbsoluteValue() {
        if self < Self.additiveIdentity {
            self.negate()
        }
    }
}

extension NumericAdditiveArithmetic where Self : Numeric {

    /// The magnitude of this value.
    @inlinable public var magnitude: Self {
        return |self|
    }
}

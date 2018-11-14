/*
 RealArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A type that can be used for real arithmetic.
///
/// Conformance Requirements:
///
/// - `RationalArithmetic`
/// - `static var π: Self { get }`
/// - `static var e: Self { get }`
/// - `mutating func formLogarithm(toBase base: Self)`
/// - `static func sin(_ angle: Angle<Self>) -> Self`
/// - `static func arctan(_ tangent: Self) -> Angle<Self>`
/// - `var floatingPointApproximation: FloatMax { get }`
public protocol RealArithmetic : RationalArithmetic {

    // MARK: - Constants

    // @documentation(SDGCornerstone.RealArithmetic.π)
    /// An instance of π.
    static var π: Self { get }

    // @documentation(SDGCornerstone.RealArithmetic.τ)
    /// An instance of τ.
    static var τ: Self { get }

    // @documentation(SDGCornerstone.RealArithmetic.e)
    /// An instance of *e*.
    static var e: Self { get }

    // MARK: - Operations

    // @documentation(SDGCornerstone.RealArithmetic.root(ofDegree:))
    /// Returns the `degree`‐th root of `self`.
    ///
    /// - Parameters:
    ///     - degree: The degree of the root.
    func root(ofDegree degree: Self) -> Self

    // @documentation(SDGCornerstone.RealArithmetic.formRoot(ofDegree:))
    /// Sets `self` to its `degree`‐th root.
    ///
    /// - Parameters:
    ///     - degree: The degree of the root.
    mutating func formRoot(ofDegree degree: Self)

    // @documentation(SDGCornerstone.RealArithmetic.√)
    /// Returns the square root of `operand`.
    ///
    /// - Parameters:
    ///     - operand: The radicand.
    static prefix func √ (operand: Self) -> Self

    // @documentation(SDGCornerstone.RealArithmetic.√=)
    /// Sets `operand` to its square root.
    ///
    /// - Parameters:
    ///     - operand: The value to modify.
    static postfix func √= (operand: inout Self)

    // @documentation(SDGCornerstone.RealArithmetic.log(toBase:of:))
    /// Returns the base `base` logarithm of `antilogarithm`.
    ///
    /// - Precondition: `antilogarithm` > 0
    ///
    /// - Precondition: `base` > 0
    ///
    /// - Precondition: `base` ≠ 1
    ///
    /// - Parameters:
    ///     - base: The base.
    ///     - antilogarithm: The antilogarithm.
    static func log(toBase base: Self, of antilogarithm: Self) -> Self

    // @documentation(SDGCornerstone.RealArithmetic.formLogarithm(toBase:))
    /// Sets `self` to its base `base` logarithm.
    ///
    /// - Precondition: `self` > 0
    ///
    /// - Precondition: `base` > 0
    ///
    /// - Precondition: `base` ≠ 1
    ///
    /// - Parameters:
    ///     - base: The base.
    mutating func formLogarithm(toBase base: Self)

    // @documentation(SDGCornerstone.RealArithmetic.log(_:))
    /// Returns the common logarithm of `antilogarithm`.
    ///
    /// - Precondition: `antilogarithm` > 0
    ///
    /// - Parameters:
    ///     - antilogarithm: The antilogarithm.
    static func log(_ antilogarithm: Self) -> Self

    // @documentation(SDGCornerstone.RealArithmetic.formCommonLogarithm())
    /// Sets `self` to its common logarithm.
    ///
    /// - Precondition: `self` > 0
    mutating func formCommonLogarithm()

    // @documentation(SDGCornerstone.RealArithmetic.ln(_:))
    /// Returns the natural logarithm of `antilogarithm`.
    ///
    /// - Precondition: `antilogarithm` > 0
    ///
    /// - Parameters:
    ///     - antilogarithm: The antilogarithm.
    static func ln(_ antilogarithm: Self) -> Self

    // @documentation(SDGCornerstone.RealArithmetic.formNaturalLogarithm())
    /// Sets `self` to its natural logarithm.
    ///
    /// - Precondition: `self` > 0
    mutating func formNaturalLogarithm()

    // @documentation(SDGCornerstone.RealArithmetic.sin(_:))
    /// Returns the sine of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    static func sin(_ angle: Angle<Self>) -> Self

    // @documentation(SDGCornerstone.RealArithmetic.cos(_:))
    /// Returns the cosine of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    static func cos(_ angle: Angle<Self>) -> Self

    // @documentation(SDGCornerstone.RealArithmetic.tan(_:))
    /// Returns the tangent of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    static func tan(_ angle: Angle<Self>) -> Self

    // @documentation(SDGCornerstone.RealArithmetic.csc(_:))
    /// Returns the cosecant of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    static func csc(_ angle: Angle<Self>) -> Self

    // @documentation(SDGCornerstone.RealArithmetic.sec(_:))
    /// Returns the secant of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    static func sec(_ angle: Angle<Self>) -> Self

    // @documentation(SDGCornerstone.RealArithmetic.cot(_:))
    /// Returns the cotangent of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    static func cot(_ angle: Angle<Self>) -> Self

    // @documentation(SDGCornerstone.RealArithmetic.arcsin(_:))
    /// Returns the arcsine of a value.
    ///
    /// The returned angle will be between −90° and 90° inclusive.
    ///
    /// - Precondition: −1 ≤ `sine` ≤ 1
    ///
    /// - Parameters:
    ///     - sine: The sine.
    static func arcsin(_ sine: Self) -> Angle<Self>

    // @documentation(SDGCornerstone.RealArithmetic.arccos(_:))
    /// Returns the arccosine of a value.
    ///
    /// The returned angle will be between 0° and 180° inclusive.
    ///
    /// - Precondition: −1 ≤ `sine` ≤ 1
    ///
    /// - Parameters:
    ///     - cosine: The cosine.
    static func arccos(_ cosine: Self) -> Angle<Self>

    // @documentation(SDGCornerstone.RealArithmetic.arctan(_:))
    /// Returns the arctangent of a value.
    ///
    /// The returned angle will be between −90° and 90°.
    ///
    /// - Parameters:
    ///     - tangent: The tangent.
    static func arctan(_ tangent: Self) -> Angle<Self>

    // @documentation(SDGCornerstone.RealArithmetic.arccsc(_:))
    /// Returns the arccosecant of a value.
    ///
    /// The returned angle will be between −90° and 90° inclusive, but never 0°.
    ///
    /// - Precondition: −1 ≥ `cosecant` ∨ `cosecant` ≤ 1
    ///
    /// - Parameters:
    ///     - cosecant: The cosecant.
    static func arccsc(_ cosecant: Self) -> Angle<Self>

    // @documentation(SDGCornerstone.RealArithmetic.arcsec(_:))
    /// Returns the arcsecant of a value.
    ///
    /// The returned angle will be between 0° and 180° inclusive, but never 90°.
    ///
    /// - Precondition: −1≥ `secant` ∨ `secant` ≤ 1
    ///
    /// - Parameters:
    ///     - secant: The secant.
    static func arcsec(_ secant: Self) -> Angle<Self>

    // @documentation(SDGCornerstone.RealArithmetic.arccot(_:))
    /// Returns the arccotangent of a value.
    ///
    /// The returned angle will be between 0° and 180°.
    ///
    /// - Parameters:
    ///     - cotangent: The cotangent.
    static func arccot(_ cotangent: Self) -> Angle<Self>

    // MARK: - Conversions

    // @documentation(SDGCornerstone.RealArithmetic.floatingPointApproximation)
    /// A floating point approximation.
    var floatingPointApproximation: FloatMax { get }
}

extension RealArithmetic {

    // #workaround(Swift 4.2.1, These can be removed when global generic constants are available.)

    /// π in the same type.
    ///
    /// - Note: This is an alias for `Self.π` to improve the legibility of code involving mathematical equations.
    @inlinable public var π: Self {
        return Self.π
    }

    // #documentation(SDGCornerstone.RealArithmetic.τ)
    /// An instance of τ.
    @inlinable public static var τ: Self {
        return 2 × π
    }

    /// τ in the same type.
    ///
    /// - Note: This is an alias for `Self.τ` to improve the legibility of code involving mathematical equations.
    @inlinable public var τ: Self {
        return Self.τ
    }

    /// *e* in the same type.
    ///
    /// - Note: This is an alias for `Self.e` to improve the legibility of code involving mathematical equations.
    @inlinable public var e: Self {
        return Self.e
    }

    // #documentation(SDGCornerstone.RealArithmetic.root(ofDegree:))
    /// Returns the `degree`‐th root of `self`.
    ///
    /// - Parameters:
    ///     - degree: The degree of the root.
    @inlinable public func root(ofDegree degree: Self) -> Self {
        return nonmutatingVariant(of: { $0.formRoot(ofDegree: $1) }, on: self, with: degree)
    }

    // #documentation(SDGCornerstone.RealArithmetic.formRoot(ofDegree:))
    /// Sets `self` to its `degree`‐th root.
    ///
    /// - Parameters:
    ///     - degree: The degree of the root.
    @inlinable public mutating func formRoot(ofDegree degree: Self) {
        self ↑= (1 ÷ degree)
    }

    // #documentation(SDGCornerstone.RealArithmetic.√)
    /// Returns the square root of `operand`.
    ///
    /// - Parameters:
    ///     - operand: The radicand.
    @inlinable public static prefix func √ (operand: Self) -> Self {
        return nonmutatingVariant(of: √=, on: operand)
    }

    // #documentation(SDGCornerstone.RealArithmetic.√=)
    /// Sets `operand` to its square root.
    ///
    /// - Parameters:
    ///     - operand: The value to modify.
    @inlinable public static postfix func √= (operand: inout Self) {
        operand.formRoot(ofDegree: 2)
    }

    // #documentation(SDGCornerstone.RealArithmetic.log(toBase:of:))
    /// Returns the base `base` logarithm of `antilogarithm`.
    ///
    /// - Precondition: `antilogarithm` > 0
    ///
    /// - Precondition: `base` > 0
    ///
    /// - Precondition: `base` ≠ 1
    ///
    /// - Parameters:
    ///     - base: The base.
    ///     - antilogarithm: The antilogarithm.
    @inlinable public static func log(toBase base: Self, of antilogarithm: Self) -> Self {
        return nonmutatingVariant(of: { $0.formLogarithm(toBase: $1) }, on: antilogarithm, with: base)
    }

    // #documentation(SDGCornerstone.RealArithmetic.log(_:))
    /// Returns the common logarithm of `antilogarithm`.
    ///
    /// - Precondition: `antilogarithm` > 0
    ///
    /// - Parameters:
    ///     - antilogarithm: The antilogarithm.
    @inlinable public static func log(_ antilogarithm: Self) -> Self {
        return nonmutatingVariant(of: { $0.formCommonLogarithm() }, on: antilogarithm)
    }

    // #documentation(SDGCornerstone.RealArithmetic.formCommonLogarithm())
    /// Sets `self` to its common logarithm.
    ///
    /// - Precondition: `self` > 0
    @inlinable public mutating func formCommonLogarithm() {
        formLogarithm(toBase: 10)
    }

    // #documentation(SDGCornerstone.RealArithmetic.ln(_:))
    /// Returns the natural logarithm of `antilogarithm`.
    ///
    /// - Precondition: `antilogarithm` > 0
    ///
    /// - Parameters:
    ///     - antilogarithm: The antilogarithm.
    @inlinable public static func ln(_ antilogarithm: Self) -> Self {
        return nonmutatingVariant(of: { $0.formNaturalLogarithm() }, on: antilogarithm)
    }

    // #documentation(SDGCornerstone.RealArithmetic.formNaturalLogarithm())
    /// Sets `self` to its natural logarithm.
    ///
    /// - Precondition: `self` > 0
    @inlinable public mutating func formNaturalLogarithm() {
        formLogarithm(toBase: e)
    }

    // #documentation(SDGCornerstone.RealArithmetic.cos(_:))
    /// Returns the cosine of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    @inlinable public static func cos(_ angle: Angle<Self>) -> Self {
        return sin(angle + (π ÷ 2).rad)
    }

    // #documentation(SDGCornerstone.RealArithmetic.tan(_:))
    /// Returns the tangent of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    @inlinable public static func tan(_ angle: Angle<Self>) -> Self {
        return sin(angle) ÷ cos(angle)
    }

    // #documentation(SDGCornerstone.RealArithmetic.csc(_:))
    /// Returns the cosecant of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    @inlinable public static func csc(_ angle: Angle<Self>) -> Self {
        return 1 ÷ sin(angle)
    }

    // #documentation(SDGCornerstone.RealArithmetic.sec(_:))
    /// Returns the secant of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    @inlinable public static func sec(_ angle: Angle<Self>) -> Self {
        return 1 ÷ cos(angle)
    }

    // #documentation(SDGCornerstone.RealArithmetic.cot(_:))
    /// Returns the cotangent of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    @inlinable public static func cot(_ angle: Angle<Self>) -> Self {
        return 1 ÷ tan(angle)
    }

    // #documentation(SDGCornerstone.RealArithmetic.arcsin(_:))
    /// Returns the arcsine of a value.
    ///
    /// The returned angle will be between −90° and 90° inclusive.
    ///
    /// - Precondition: −1 ≤ `sine` ≤ 1
    ///
    /// - Parameters:
    ///     - sine: The sine.
    @inlinable public static func arcsin(_ sine: Self) -> Angle<Self> {
        _assert((−1 ... 1).contains(sine), { (localization: _APILocalization) -> String in
            switch localization { // @exempt(from: tests)
            case .englishCanada:
                return "There is no arcsine angle for any number x, where |x| > 1. (\(sine))"
            }
        })
        return arctan(sine ÷ √(1 − sine ↑ 2))
    }

    // #documentation(SDGCornerstone.RealArithmetic.arccos(_:))
    /// Returns the arccosine of a value.
    ///
    /// The returned angle will be between 0° and 180° inclusive.
    ///
    /// - Precondition: −1 ≤ `sine` ≤ 1
    ///
    /// - Parameters:
    ///     - cosine: The cosine.
    @inlinable public static func arccos(_ cosine: Self) -> Angle<Self> {
        _assert((−1 ... 1).contains(cosine), { (localization: _APILocalization) -> String in
            switch localization { // @exempt(from: tests)
            case .englishCanada:
                return "There is no arccosine angle for any number x, where |x| > 1. (\(cosine))"
            }
        })
        return (π ÷ 2).rad − arcsin(cosine)
    }

    // #documentation(SDGCornerstone.RealArithmetic.arccsc(_:))
    /// Returns the arccosecant of a value.
    ///
    /// The returned angle will be between −90° and 90° inclusive, but never 0°.
    ///
    /// - Precondition: −1 ≥ `cosecant` ∨ `cosecant` ≤ 1
    ///
    /// - Parameters:
    ///     - cosecant: The cosecant.
    @inlinable public static func arccsc(_ cosecant: Self) -> Angle<Self> {
        _assert(¬(−1 ... 1).contains(cosecant), { (localization: _APILocalization) -> String in
            switch localization { // @exempt(from: tests)
            case .englishCanada:
                return "There is no arccosecant angle for any number x, where |x| < 1. (\(cosecant))"
            }
        })
        return arcsin(1 ÷ cosecant)
    }

    // #documentation(SDGCornerstone.RealArithmetic.arcsec(_:))
    /// Returns the arcsecant of a value.
    ///
    /// The returned angle will be between 0° and 180° inclusive, but never 90°.
    ///
    /// - Precondition: −1≥ `secant` ∨ `secant` ≤ 1
    ///
    /// - Parameters:
    ///     - secant: The secant.
    @inlinable public static func arcsec(_ secant: Self) -> Angle<Self> {
        _assert(¬(−1 ... 1).contains(secant), { (localization: _APILocalization) -> String in
            switch localization { // @exempt(from: tests)
            case .englishCanada:
                return "There is no arccosecant angle for any number x, where |x| < 1. (\(secant))"
            }
        })
        return arccos(1 ÷ secant)
    }

    // #documentation(SDGCornerstone.RealArithmetic.arccot(_:))
    /// Returns the arccotangent of a value.
    ///
    /// The returned angle will be between 0° and 180°.
    ///
    /// - Parameters:
    ///     - cotangent: The cotangent.
    @inlinable public static func arccot(_ cotangent: Self) -> Angle<Self> {
        let reference = arctan(1 ÷ cotangent)
        if reference < Angle.additiveIdentity {
            return reference + π.rad
        } else {
            return reference
        }
    }
}

// MARK: - Real Arithmetic

// #workaround(Swift 4.2.1, These should be switched to generic constants when they become available.)

/// An instance of π in the desired return type.
///
/// - Note: This is an alias for `N.π` to improve the legibility of code involving mathematical equations.
@inlinable public func π<N : RealArithmetic>() -> N {
    return N.π
}

/// An instance of τ in the desired return type.
///
/// - Note: This is an alias for `N.τ` to improve the legibility of code involving mathematical equations.
@inlinable public func τ<N : RealArithmetic>() -> N {
    return N.τ
}

/// An instance of *e* in the desired return type.
///
/// - Note: This is an alias for `N.e` to improve the legibility of code involving mathematical equations.
@inlinable public func e<N : RealArithmetic>() -> N {
    return N.e
}

// #documentation(SDGCornerstone.RealArithmetic.log(toBase:of:))
/// Returns the base `base` logarithm of `antilogarithm`.
///
/// - Precondition: `antilogarithm` > 0
///
/// - Precondition: `base` > 0
///
/// - Precondition: `base` ≠ 1
///
/// - Parameters:
///     - base: The base.
///     - antilogarithm: The antilogarithm.
@inlinable public func log<N : RealArithmetic>(toBase base: N, of antilogarithm: N) -> N {
    return N.log(toBase: base, of: antilogarithm)
}

// #documentation(SDGCornerstone.RealArithmetic.log(_:))
/// Returns the common logarithm of `antilogarithm`.
///
/// - Precondition: `antilogarithm` > 0
///
/// - Parameters:
///     - antilogarithm: The antilogarithm.
@inlinable public func log<N : RealArithmetic>(_ antilogarithm: N) -> N {
    return N.log(antilogarithm)
}

// #documentation(SDGCornerstone.RealArithmetic.ln(_:))
/// Returns the natural logarithm of `antilogarithm`.
///
/// - Precondition: `antilogarithm` > 0
///
/// - Parameters:
///     - antilogarithm: The antilogarithm.
@inlinable public func ln<N : RealArithmetic>(_ antilogarithm: N) -> N {
    return N.ln(antilogarithm)
}

// #documentation(SDGCornerstone.RealArithmetic.sin(_:))
/// Returns the sine of an angle.
///
/// - Parameters:
///     - angle: The angle.
@inlinable public func sin<N>(_ angle: Angle<N>) -> N {
    return N.sin(angle)
}

// #documentation(SDGCornerstone.RealArithmetic.cos(_:))
/// Returns the cosine of an angle.
///
/// - Parameters:
///     - angle: The angle.
@inlinable public func cos<N>(_ angle: Angle<N>) -> N {
    return N.cos(angle)
}

// #documentation(SDGCornerstone.RealArithmetic.tan(_:))
/// Returns the tangent of an angle.
///
/// - Parameters:
///     - angle: The angle.
@inlinable public func tan<N>(_ angle: Angle<N>) -> N {
    return N.tan(angle)
}

// #documentation(SDGCornerstone.RealArithmetic.csc(_:))
/// Returns the cosecant of an angle.
///
/// - Parameters:
///     - angle: The angle.
@inlinable public func csc<N>(_ angle: Angle<N>) -> N {
    return N.csc(angle)
}

// #documentation(SDGCornerstone.RealArithmetic.sec(_:))
/// Returns the secant of an angle.
///
/// - Parameters:
///     - angle: The angle.
@inlinable public func sec<N>(_ angle: Angle<N>) -> N {
    return N.sec(angle)
}

// #documentation(SDGCornerstone.RealArithmetic.cot(_:))
/// Returns the cotangent of an angle.
///
/// - Parameters:
///     - angle: The angle.
@inlinable public func cot<N>(_ angle: Angle<N>) -> N {
    return N.cot(angle)
}

// #documentation(SDGCornerstone.RealArithmetic.arcsin(_:))
/// Returns the arcsine of a value.
///
/// The returned angle will be between −90° and 90° inclusive.
///
/// - Precondition: −1 ≤ `sine` ≤ 1
///
/// - Parameters:
///     - sine: The sine.
@inlinable public func arcsin<N : RealArithmetic>(_ sine: N) -> Angle<N> {
    return N.arcsin(sine)
}

// #documentation(SDGCornerstone.RealArithmetic.arccos(_:))
/// Returns the arccosine of a value.
///
/// The returned angle will be between 0° and 180° inclusive.
///
/// - Precondition: −1 ≤ `sine` ≤ 1
///
/// - Parameters:
///     - cosine: The cosine.
@inlinable public func arccos<N : RealArithmetic>(_ cosine: N) -> Angle<N> {
    return N.arccos(cosine)
}

// #documentation(SDGCornerstone.RealArithmetic.arctan(_:))
/// Returns the arctangent of a value.
///
/// The returned angle will be between −90° and 90°.
///
/// - Parameters:
///     - tangent: The tangent.
@inlinable public func arctan<N : RealArithmetic>(_ tangent: N) -> Angle<N> {
    return N.arctan(tangent)
}

// #documentation(SDGCornerstone.RealArithmetic.arccsc(_:))
/// Returns the arccosecant of a value.
///
/// The returned angle will be between −90° and 90° inclusive, but never 0°.
///
/// - Precondition: −1 ≥ `cosecant` ∨ `cosecant` ≤ 1
///
/// - Parameters:
///     - cosecant: The cosecant.
@inlinable public func arccsc<N : RealArithmetic>(_ cosecant: N) -> Angle<N> {
    return N.arccsc(cosecant)
}

// #documentation(SDGCornerstone.RealArithmetic.arcsec(_:))
/// Returns the arcsecant of a value.
///
/// The returned angle will be between 0° and 180° inclusive, but never 90°.
///
/// - Precondition: −1≥ `secant` ∨ `secant` ≤ 1
///
/// - Parameters:
///     - secant: The secant.
@inlinable public func arcsec<N : RealArithmetic>(_ secant: N) -> Angle<N> {
    return N.arcsec(secant)
}

// #documentation(SDGCornerstone.RealArithmetic.arctan(_:))
/// Returns the arctangent of a value.
///
/// The returned angle will be between −90° and 90°.
///
/// - Parameters:
///     - tangent: The tangent.
@inlinable public func arccot<N : RealArithmetic>(_ cotangent: N) -> Angle<N> {
    return N.arccot(cotangent)
}

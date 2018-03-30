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
public protocol RealArithmetic : RationalArithmetic {

    // MARK: - Constants

    // [_Define Documentation: SDGCornerstone.RealArithmetic.π_]
    /// An instance of π.
    static var π: Self { get }

    // [_Define Documentation: SDGCornerstone.RealArithmetic.τ_]
    /// An instance of τ.
    static var τ: Self { get }

    // [_Define Documentation: SDGCornerstone.RealArithmetic.e_]
    /// An instance of *e*.
    static var e: Self { get }

    // MARK: - Operations

    // [_Define Documentation: SDGCornerstone.RealArithmetic.root(ofDegree:)_]
    /// Returns the `degree`‐th root of `self`.
    ///
    /// - Parameters:
    ///     - degree: The degree of the root.
    func root(ofDegree degree: Self) -> Self

    // [_Define Documentation: SDGCornerstone.RealArithmetic.formRoot(ofDegree:)_]
    /// Sets `self` to its `degree`‐th root.
    ///
    /// - Parameters:
    ///     - degree: The degree of the root.
    mutating func formRoot(ofDegree degree: Self)

    // [_Define Documentation: SDGCornerstone.RealArithmetic.√_]
    /// Returns the sequare root of `operand`.
    ///
    /// - Parameters:
    ///     - operand: The radicand.
    static prefix func √ (operand: Self) -> Self

    // [_Define Documentation: SDGCornerstone.RealArithmetic.√=_]
    /// Sets `operand` to its square root.
    ///
    /// - Parameters:
    ///     - operand: The value to modify.
    static postfix func √= (operand: inout Self)

    // [_Define Documentation: SDGCornerstone.RealArithmetic.log(toBase:of:)_]
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

    // [_Define Documentation: SDGCornerstone.RealArithmetic.formLogarithm(toBase:)_]
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

    // [_Define Documentation: SDGCornerstone.RealArithmetic.log(_:)_]
    /// Returns the common logarithm of `antilogarithm`.
    ///
    /// - Precondition: `antilogarithm` > 0
    ///
    /// - Parameters:
    ///     - antilogarithm: The antilogarithm.
    static func log(_ antilogarithm: Self) -> Self

    // [_Define Documentation: SDGCornerstone.RealArithmetic.formCommonLogarithm()_]
    /// Sets `self` to its common logarithm.
    ///
    /// - Precondition: `self` > 0
    mutating func formCommonLogarithm()

    // [_Define Documentation: SDGCornerstone.RealArithmetic.ln(_:)_]
    /// Returns the natural logarithm of `antilogarithm`.
    ///
    /// - Precondition: `antilogarithm` > 0
    ///
    /// - Parameters:
    ///     - antilogarithm: The antilogarithm.
    static func ln(_ antilogarithm: Self) -> Self

    // [_Define Documentation: SDGCornerstone.RealArithmetic.formNaturalLogarithm()_]
    /// Sets `self` to its natural logarithm.
    ///
    /// - Precondition: `self` > 0
    mutating func formNaturalLogarithm()

    // [_Define Documentation: SDGCornerstone.RealArithmetic.sin(_:)_]
    /// Returns the sine of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    static func sin(_ angle: Angle<Self>) -> Self

    // [_Define Documentation: SDGCornerstone.RealArithmetic.cos(_:)_]
    /// Returns the cosine of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    static func cos(_ angle: Angle<Self>) -> Self

    // [_Define Documentation: SDGCornerstone.RealArithmetic.tan(_:)_]
    /// Returns the tangent of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    static func tan(_ angle: Angle<Self>) -> Self

    // [_Define Documentation: SDGCornerstone.RealArithmetic.csc(_:)_]
    /// Returns the cosecant of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    static func csc(_ angle: Angle<Self>) -> Self

    // [_Define Documentation: SDGCornerstone.RealArithmetic.sec(_:)_]
    /// Returns the secant of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    static func sec(_ angle: Angle<Self>) -> Self

    // [_Define Documentation: SDGCornerstone.RealArithmetic.cot(_:)_]
    /// Returns the cotangent of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    static func cot(_ angle: Angle<Self>) -> Self

    // [_Define Documentation: SDGCornerstone.RealArithmetic.arcsin(_:)_]
    /// Returns the arcsine of a value.
    ///
    /// The returned angle will be between −90° and 90° inclusive.
    ///
    /// - Precondition: −1 ≤ `sine` ≤ 1
    ///
    /// - Parameters:
    ///     - sine: The sine.
    static func arcsin(_ sine: Self) -> Angle<Self>

    // [_Define Documentation: SDGCornerstone.RealArithmetic.arccos(_:)_]
    /// Returns the arccosine of a value.
    ///
    /// The returned angle will be between 0° and 180° inclusive.
    ///
    /// - Precondition: −1 ≤ `sine` ≤ 1
    ///
    /// - Parameters:
    ///     - cosine: The cosine.
    static func arccos(_ cosine: Self) -> Angle<Self>

    // [_Define Documentation: SDGCornerstone.RealArithmetic.arctan(_:)_]
    /// Returns the arctangent of a value.
    ///
    /// The returned angle will be between −90° and 90°.
    ///
    /// - Parameters:
    ///     - tangent: The tangent.
    static func arctan(_ tangent: Self) -> Angle<Self>

    // [_Define Documentation: SDGCornerstone.RealArithmetic.arccsc(_:)_]
    /// Returns the arccosecant of a value.
    ///
    /// The returned angle will be between −90° and 90° inclusive, but never 0°.
    ///
    /// - Precondition: −1 ≥ `cosecant` ∨ `cosecant` ≤ 1
    ///
    /// - Parameters:
    ///     - cosecant: The cosecant.
    static func arccsc(_ cosecant: Self) -> Angle<Self>

    // [_Define Documentation: SDGCornerstone.RealArithmetic.arcsec(_:)_]
    /// Returns the arcsecant of a value.
    ///
    /// The returned angle will be between 0° and 180° inclusive, but never 90°.
    ///
    /// - Precondition: −1≥ `secant` ∨ `secant` ≤ 1
    ///
    /// - Parameters:
    ///     - secant: The secant.
    static func arcsec(_ secant: Self) -> Angle<Self>

    // [_Define Documentation: SDGCornerstone.RealArithmetic.arccot(_:)_]
    /// Returns the arccotangent of a value.
    ///
    /// The returned angle will be between 0° and 180°.
    ///
    /// - Parameters:
    ///     - cotangent: The cotangent.
    static func arccot(_ cotangent: Self) -> Angle<Self>
}

extension RealArithmetic {

    // [_Workaround: These can be removed when global generic constants are available. (Swift 4.0.3)_]

    /// π in the same type.
    ///
    /// - Note: This is an alias for `Self.π` to improve the legibility of code involving mathematical equations.
    @_inlineable public var π: Self {
        return Self.π
    }

    // [_Inherit Documentation: SDGCornerstone.RealArithmetic.τ_]
    /// An instance of τ.
    @_inlineable public static var τ: Self {
        return 2 × π
    }

    /// τ in the same type.
    ///
    /// - Note: This is an alias for `Self.τ` to improve the legibility of code involving mathematical equations.
    @_inlineable public var τ: Self {
        return Self.τ
    }

    /// *e* in the same type.
    ///
    /// - Note: This is an alias for `Self.e` to improve the legibility of code involving mathematical equations.
    @_inlineable public var e: Self {
        return Self.e
    }

    // [_Inherit Documentation: SDGCornerstone.RealArithmetic.root(ofDegree:)_]
    /// Returns the `degree`‐th root of `self`.
    ///
    /// - Parameters:
    ///     - degree: The degree of the root.
    @_inlineable public func root(ofDegree degree: Self) -> Self {
        return nonmutatingVariant(of: Self.formRoot, on: self, with: degree)
    }

    // [_Inherit Documentation: SDGCornerstone.RealArithmetic.formRoot(ofDegree:)_]
    /// Sets `self` to its `degree`‐th root.
    ///
    /// - Parameters:
    ///     - degree: The degree of the root.
    @_inlineable public mutating func formRoot(ofDegree degree: Self) {
        self ↑= (1 ÷ degree)
    }

    // [_Inherit Documentation: SDGCornerstone.RealArithmetic.√_]
    /// Returns the sequare root of `operand`.
    ///
    /// - Parameters:
    ///     - operand: The radicand.
    @_inlineable public static prefix func √ (operand: Self) -> Self {
        return nonmutatingVariant(of: √=, on: operand)
    }

    // [_Inherit Documentation: SDGCornerstone.RealArithmetic.√=_]
    /// Sets `operand` to its square root.
    ///
    /// - Parameters:
    ///     - operand: The value to modify.
    @_inlineable public static postfix func √= (operand: inout Self) {
        operand.formRoot(ofDegree: 2)
    }

    // [_Inherit Documentation: SDGCornerstone.RealArithmetic.log(toBase:of:)_]
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
    @_inlineable public static func log(toBase base: Self, of antilogarithm: Self) -> Self {
        return nonmutatingVariant(of: Self.formLogarithm, on: antilogarithm, with: base)
    }

    // [_Inherit Documentation: SDGCornerstone.RealArithmetic.log(_:)_]
    /// Returns the common logarithm of `antilogarithm`.
    ///
    /// - Precondition: `antilogarithm` > 0
    ///
    /// - Parameters:
    ///     - antilogarithm: The antilogarithm.
    @_inlineable public static func log(_ antilogarithm: Self) -> Self {
        return nonmutatingVariant(of: Self.formCommonLogarithm, on: antilogarithm)
    }

    // [_Inherit Documentation: SDGCornerstone.RealArithmetic.formCommonLogarithm()_]
    /// Sets `self` to its common logarithm.
    ///
    /// - Precondition: `self` > 0
    @_inlineable public mutating func formCommonLogarithm() {
        formLogarithm(toBase: 10)
    }

    // [_Inherit Documentation: SDGCornerstone.RealArithmetic.ln(_:)_]
    /// Returns the natural logarithm of `antilogarithm`.
    ///
    /// - Precondition: `antilogarithm` > 0
    ///
    /// - Parameters:
    ///     - antilogarithm: The antilogarithm.
    @_inlineable public static func ln(_ antilogarithm: Self) -> Self {
        return nonmutatingVariant(of: Self.formNaturalLogarithm, on: antilogarithm)
    }

    // [_Inherit Documentation: SDGCornerstone.RealArithmetic.formNaturalLogarithm()_]
    /// Sets `self` to its natural logarithm.
    ///
    /// - Precondition: `self` > 0
    @_inlineable public mutating func formNaturalLogarithm() {
        formLogarithm(toBase: e)
    }

    // [_Inherit Documentation: SDGCornerstone.RealArithmetic.cos(_:)_]
    /// Returns the cosine of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    @_inlineable public static func cos(_ angle: Angle<Self>) -> Self {
        return sin(angle + (π ÷ 2).rad)
    }

    // [_Inherit Documentation: SDGCornerstone.RealArithmetic.tan(_:)_]
    /// Returns the tangent of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    @_inlineable public static func tan(_ angle: Angle<Self>) -> Self {
        return sin(angle) ÷ cos(angle)
    }

    // [_Inherit Documentation: SDGCornerstone.RealArithmetic.csc(_:)_]
    /// Returns the cosecant of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    @_inlineable public static func csc(_ angle: Angle<Self>) -> Self {
        return 1 ÷ sin(angle)
    }

    // [_Inherit Documentation: SDGCornerstone.RealArithmetic.sec(_:)_]
    /// Returns the secant of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    @_inlineable public static func sec(_ angle: Angle<Self>) -> Self {
        return 1 ÷ cos(angle)
    }

    // [_Inherit Documentation: SDGCornerstone.RealArithmetic.cot(_:)_]
    /// Returns the cotangent of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    @_inlineable public static func cot(_ angle: Angle<Self>) -> Self {
        return 1 ÷ tan(angle)
    }

    // [_Inherit Documentation: SDGCornerstone.RealArithmetic.arcsin(_:)_]
    /// Returns the arcsine of a value.
    ///
    /// The returned angle will be between −90° and 90° inclusive.
    ///
    /// - Precondition: −1 ≤ `sine` ≤ 1
    ///
    /// - Parameters:
    ///     - sine: The sine.
    @_inlineable public static func arcsin(_ sine: Self) -> Angle<Self> {
        _assert((−1 ... 1).contains(sine), { (localization: _APILocalization) -> String in
            switch localization {
            case .englishCanada: // [_Exempt from Test Coverage_]
                return "There is no arcsine angle for any number x, where |x| > 1. (\(sine))"
            }
        })
        return arctan(sine ÷ √(1 − sine ↑ 2))
    }

    // [_Inherit Documentation: SDGCornerstone.RealArithmetic.arccos(_:)_]
    /// Returns the arccosine of a value.
    ///
    /// The returned angle will be between 0° and 180° inclusive.
    ///
    /// - Precondition: −1 ≤ `sine` ≤ 1
    ///
    /// - Parameters:
    ///     - cosine: The cosine.
    @_inlineable public static func arccos(_ cosine: Self) -> Angle<Self> {
        _assert((−1 ... 1).contains(cosine), { (localization: _APILocalization) -> String in
            switch localization {
            case .englishCanada: // [_Exempt from Test Coverage_]
                return "There is no arccosine angle for any number x, where |x| > 1. (\(cosine))"
            }
        })
        return (π ÷ 2).rad − arcsin(cosine)
    }

    // [_Inherit Documentation: SDGCornerstone.RealArithmetic.arccsc(_:)_]
    /// Returns the arccosecant of a value.
    ///
    /// The returned angle will be between −90° and 90° inclusive, but never 0°.
    ///
    /// - Precondition: −1 ≥ `cosecant` ∨ `cosecant` ≤ 1
    ///
    /// - Parameters:
    ///     - cosecant: The cosecant.
    @_inlineable public static func arccsc(_ cosecant: Self) -> Angle<Self> {
        _assert(¬(−1 ... 1).contains(cosecant), { (localization: _APILocalization) -> String in
            switch localization {
            case .englishCanada: // [_Exempt from Test Coverage_]
                return "There is no arccosecant angle for any number x, where |x| < 1. (\(cosecant))"
            }
        })
        return arcsin(1 ÷ cosecant)
    }

    // [_Inherit Documentation: SDGCornerstone.RealArithmetic.arcsec(_:)_]
    /// Returns the arcsecant of a value.
    ///
    /// The returned angle will be between 0° and 180° inclusive, but never 90°.
    ///
    /// - Precondition: −1≥ `secant` ∨ `secant` ≤ 1
    ///
    /// - Parameters:
    ///     - secant: The secant.
    @_inlineable public static func arcsec(_ secant: Self) -> Angle<Self> {
        _assert(¬(−1 ... 1).contains(secant), { (localization: _APILocalization) -> String in
            switch localization {
            case .englishCanada: // [_Exempt from Test Coverage_]
                return "There is no arccosecant angle for any number x, where |x| < 1. (\(secant))"
            }
        })
        return arccos(1 ÷ secant)
    }

    // [_Inherit Documentation: SDGCornerstone.RealArithmetic.arccot(_:)_]
    /// Returns the arccotangent of a value.
    ///
    /// The returned angle will be between 0° and 180°.
    ///
    /// - Parameters:
    ///     - cotangent: The cotangent.
    @_inlineable public static func arccot(_ cotangent: Self) -> Angle<Self> {
        let reference = arctan(1 ÷ cotangent)
        if reference < Angle.additiveIdentity {
            return reference + π.rad
        } else {
            return reference
        }
    }
}

// MARK: - Real Arithmetic

// [_Workaround: These should be switched to generic constants when they become available. (Swift 4.0.3)_]

/// An instance of π in the desired return type.
///
/// - Note: This is an alias for `N.π` to improve the legibility of code involving mathematical equations.
@_inlineable public func π<N : RealArithmetic>() -> N {
    return N.π
}

/// An instance of τ in the desired return type.
///
/// - Note: This is an alias for `N.τ` to improve the legibility of code involving mathematical equations.
@_inlineable public func τ<N : RealArithmetic>() -> N {
    return N.τ
}

/// An instance of *e* in the desired return type.
///
/// - Note: This is an alias for `N.e` to improve the legibility of code involving mathematical equations.
@_inlineable public func e<N : RealArithmetic>() -> N {
    return N.e
}

// [_Inherit Documentation: SDGCornerstone.RealArithmetic.log(toBase:of:)_]
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
@_inlineable public func log<N : RealArithmetic>(toBase base: N, of antilogarithm: N) -> N {
    return N.log(toBase: base, of: antilogarithm)
}

// [_Inherit Documentation: SDGCornerstone.RealArithmetic.log(_:)_]
/// Returns the common logarithm of `antilogarithm`.
///
/// - Precondition: `antilogarithm` > 0
///
/// - Parameters:
///     - antilogarithm: The antilogarithm.
@_inlineable public func log<N : RealArithmetic>(_ antilogarithm: N) -> N {
    return N.log(antilogarithm)
}

// [_Inherit Documentation: SDGCornerstone.RealArithmetic.ln(_:)_]
/// Returns the natural logarithm of `antilogarithm`.
///
/// - Precondition: `antilogarithm` > 0
///
/// - Parameters:
///     - antilogarithm: The antilogarithm.
@_inlineable public func ln<N : RealArithmetic>(_ antilogarithm: N) -> N {
    return N.ln(antilogarithm)
}

// [_Inherit Documentation: SDGCornerstone.RealArithmetic.sin(_:)_]
/// Returns the sine of an angle.
///
/// - Parameters:
///     - angle: The angle.
@_inlineable public func sin<N>(_ angle: Angle<N>) -> N {
    return N.sin(angle)
}

// [_Inherit Documentation: SDGCornerstone.RealArithmetic.cos(_:)_]
/// Returns the cosine of an angle.
///
/// - Parameters:
///     - angle: The angle.
@_inlineable public func cos<N>(_ angle: Angle<N>) -> N {
    return N.cos(angle)
}

// [_Inherit Documentation: SDGCornerstone.RealArithmetic.tan(_:)_]
/// Returns the tangent of an angle.
///
/// - Parameters:
///     - angle: The angle.
@_inlineable public func tan<N>(_ angle: Angle<N>) -> N {
    return N.tan(angle)
}

// [_Inherit Documentation: SDGCornerstone.RealArithmetic.csc(_:)_]
/// Returns the cosecant of an angle.
///
/// - Parameters:
///     - angle: The angle.
@_inlineable public func csc<N>(_ angle: Angle<N>) -> N {
    return N.csc(angle)
}

// [_Inherit Documentation: SDGCornerstone.RealArithmetic.sec(_:)_]
/// Returns the secant of an angle.
///
/// - Parameters:
///     - angle: The angle.
@_inlineable public func sec<N>(_ angle: Angle<N>) -> N {
    return N.sec(angle)
}

// [_Inherit Documentation: SDGCornerstone.RealArithmetic.cot(_:)_]
/// Returns the cotangent of an angle.
///
/// - Parameters:
///     - angle: The angle.
@_inlineable public func cot<N>(_ angle: Angle<N>) -> N {
    return N.cot(angle)
}

// [_Inherit Documentation: SDGCornerstone.RealArithmetic.arcsin(_:)_]
/// Returns the arcsine of a value.
///
/// The returned angle will be between −90° and 90° inclusive.
///
/// - Precondition: −1 ≤ `sine` ≤ 1
///
/// - Parameters:
///     - sine: The sine.
@_inlineable public func arcsin<N : RealArithmetic>(_ sine: N) -> Angle<N> {
    return N.arcsin(sine)
}

// [_Inherit Documentation: SDGCornerstone.RealArithmetic.arccos(_:)_]
/// Returns the arccosine of a value.
///
/// The returned angle will be between 0° and 180° inclusive.
///
/// - Precondition: −1 ≤ `sine` ≤ 1
///
/// - Parameters:
///     - cosine: The cosine.
@_inlineable public func arccos<N : RealArithmetic>(_ cosine: N) -> Angle<N> {
    return N.arccos(cosine)
}

// [_Inherit Documentation: SDGCornerstone.RealArithmetic.arctan(_:)_]
/// Returns the arctangent of a value.
///
/// The returned angle will be between −90° and 90°.
///
/// - Parameters:
///     - tangent: The tangent.
@_inlineable public func arctan<N : RealArithmetic>(_ tangent: N) -> Angle<N> {
    return N.arctan(tangent)
}

// [_Inherit Documentation: SDGCornerstone.RealArithmetic.arccsc(_:)_]
/// Returns the arccosecant of a value.
///
/// The returned angle will be between −90° and 90° inclusive, but never 0°.
///
/// - Precondition: −1 ≥ `cosecant` ∨ `cosecant` ≤ 1
///
/// - Parameters:
///     - cosecant: The cosecant.
@_inlineable public func arccsc<N : RealArithmetic>(_ cosecant: N) -> Angle<N> {
    return N.arccsc(cosecant)
}

// [_Inherit Documentation: SDGCornerstone.RealArithmetic.arcsec(_:)_]
/// Returns the arcsecant of a value.
///
/// The returned angle will be between 0° and 180° inclusive, but never 90°.
///
/// - Precondition: −1≥ `secant` ∨ `secant` ≤ 1
///
/// - Parameters:
///     - secant: The secant.
@_inlineable public func arcsec<N : RealArithmetic>(_ secant: N) -> Angle<N> {
    return N.arcsec(secant)
}

// [_Inherit Documentation: SDGCornerstone.RealArithmetic.arctan(_:)_]
/// Returns the arctangent of a value.
///
/// The returned angle will be between −90° and 90°.
///
/// - Parameters:
///     - tangent: The tangent.
@_inlineable public func arccot<N : RealArithmetic>(_ cotangent: N) -> Angle<N> {
    return N.arccot(cotangent)
}

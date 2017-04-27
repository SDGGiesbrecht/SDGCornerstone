/*
 AdditiveArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A value that can be added and subtracted.
///
/// - Note: Unlike `SignedNumber`, `AdditiveArithmetic` types do not need to conform to `Comparable`, allowing conformance by two‐dimensional vectors, etc. For additional behaviour specific to one‐dimensional types, see 	`NumericAdditiveArithmetic`.
///
/// Conformance Requirements:
///
/// - `Equatable`
/// - `Subtractable`
/// - `IntegralArithmetic`, `WholeNumberType`, `ExpressibleByIntegerLiteral` or `static var additiveIdentity: Self { get }`
public protocol AdditiveArithmetic : Equatable, Subtractable {

    // [_Define Documentation: SDGCornerstone.AdditiveArithmetic.additiveIdentity_]
    /// The additive identity (origin).
    static var additiveIdentity: Self { get }
}

extension AdditiveArithmetic where Self : ExpressibleByIntegerLiteral {
    // MARK: - where Self : ExpressibleByIntegerLiteral

    // [_Inherit Documentation: SDGCornerstone.AdditiveArithmetic.additiveIdentity_]
    /// The additive identity (origin).
    public static var additiveIdentity: Self {
        return 0
    }
}

extension AdditiveArithmetic where Self : Measurement {
    // MARK: - where Self : Measurement

    // [_Inherit Documentation: SDGCornerstone.AdditiveArithmetic.additiveIdentity_]
    /// The additive identity (origin).
    public static var additiveIdentity: Self {
        return Self(rawValue: 0)
    }
}

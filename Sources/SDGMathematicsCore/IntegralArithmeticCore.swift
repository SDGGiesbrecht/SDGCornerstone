/*
 IntegralArithmeticCore.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type that can be used for integral arithmetic.
///
/// Conformance Requirements:
///
/// - `WholeArithmeticCore`
/// - `Negatable`
/// - `init(_ int: IntMax)`
public protocol IntegralArithmeticCore : Negatable, SignedNumeric, WholeArithmeticCore {

    // [_Define Documentation: SDGCornerstone.IntegralArithmetic.init(int:)_]
    /// Creates an instance equal to `int`.
    ///
    /// - Properties:
    ///     - int: An instance of `IntMax`.
    init(_ int: IntMax)
}

extension IntegralArithmeticCore {

    // [_Define Documentation: SDGCornerstone.IntegralArithmetic.init(intFamily:)_]
    /// Creates an instance equal to `int`.
    ///
    /// - Properties:
    ///     - int: An instance of a member of the `Int` family.
    @_inlineable public init<I : IntFamilyCore>(_ int: I) {
        self.init(IntMax(int))
    }

    @_inlineable @_versioned internal mutating func raiseIntegerToThePowerOf(integer exponent: Self) {

        // [_Warning: Can this can be localized? Otherwise switch to “◊(Z ↑ Z− ∉ Z)”._]
        assert(exponent.isNonNegative, /*UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
            switch localization {
            case .englishCanada: // [_Exempt from Test Coverage_]
                return */"The result of a negative exponent may be outside the set of integers. Use a type that conforms to RationalArithmetic instead."/*
            }
        })*/)

        raiseWholeNumberToThePowerOf(wholeNumber: exponent)
    }
}

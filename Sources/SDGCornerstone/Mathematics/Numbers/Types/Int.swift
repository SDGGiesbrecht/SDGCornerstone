/*
 Int.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The member of the `Int` family with the largest bit field.
public typealias IntMax = Int64

/// A member of the `Int` family: `Int`, `Int64`, `Int32`, `Int16` or `Int8`.
public protocol IntFamily : CustomPlaygroundQuickLookable, CustomReflectable, CVarArg, FixedWidthInteger, IntegerProtocol, MirrorPath, PropertyListValue, SignedInteger {

}

extension Int : IntFamily {

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride
}

extension Int64 : IntFamily {

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride

    // MARK: - WholeArithmetic

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: ClosedRange<Int64>, fromRandomizer randomizer: Randomizer) {

        if range.lowerBound.isWhole {
            let unsignedRange: ClosedRange<UInt64> = UInt64(range.lowerBound) ... UInt64(range.upperBound)
            let unsigned = UInt64(randomInRange: unsignedRange, fromRandomizer: randomizer)
            self = Int64(unsigned)
        } else {
            let span = range.upperBound − range.lowerBound
            let unsignedRange: ClosedRange<UInt64> = 0 ... UInt64(span)
            let unsigned = UInt64(randomInRange: unsignedRange, fromRandomizer: randomizer)
            self = range.lowerBound + Int64(unsigned)
        }
    }

}

extension Int32 : IntFamily {

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride

}

extension Int16 : IntFamily {

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride

}

extension Int8 : IntFamily {

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    // MARK: - PointProtocol

    /// The vector type.
    public typealias Vector = Stride

}

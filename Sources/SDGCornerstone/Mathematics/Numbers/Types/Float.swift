/*
 Float.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
#if !os(Linux)
    import CoreGraphics
#endif

#if os(macOS) || os(Linux)
    public typealias FloatMax = Float80
#else
    public typealias FloatMax = Double
#endif

/// A member of the `Float` family: `Double`, `Float80` or `Float`
public protocol FloatFamily : Addable, AdditiveArithmetic, BinaryFloatingPoint, CustomDebugStringConvertible, IntegralArithmetic, Hashable, LosslessStringConvertible, Negatable, NumericAdditiveArithmetic, OneDimensionalPoint, PointProtocol, RationalArithmetic, RealNumberProtocol, Subtractable, WholeArithmetic {

    // [_Define Documentation: SDGCornerstone.FloatFamily.init(_:)_]
    /// Creates a new value, rounded to the closest possible representation.
    ///
    /// - Parameters:
    ///     - value: The number to convert to a floating‐point value.
    init(_ value: Exponent)

    // [_Define Documentation: SDGCornerstone.FloatFamily.ln2_]
    /// The value of ln2.
    static var ln2: Self { get }
}

extension Double : FloatFamily, PropertyListValue {

    // MARK: - FloatFamily

    // [_Inherit Documentation: SDGCornerstone.FloatFamily.ln2_]
    /// The value of ln2.
    public static let ln2: Double = 0x1.62E42FEFA39EFp-1

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride

    // MARK: - RealArithmetic

    // [_Inherit Documentation: SDGCornerstone.RealArithmetic.e_]
    /// An instance of *e*.
    public static let e: Double = 0x1.5BF0A8B145769p1
}

#if !(os(Linux) || LinuxDocs)

    extension CGFloat : FloatFamily, PropertyListValue {

        // MARK: - CustomDebugStringConvertible

        /// A textual representation of this instance, suitable for debugging.
        public var debugDescription: String {
            return NativeType(self).debugDescription
        }

        // MARK: - FloatFamily

        // [_Inherit Documentation: SDGCornerstone.FloatFamily.ln2_]
        /// The value of ln2.
        public static let ln2: CGFloat = CGFloat(Double.ln2)

        // MARK: - LosslessStringConvertible

        /// Instantiates an instance of the conforming type from a string representation.
        ///
        /// - Parameters:
        ///     - description: The string representation.
        public init?(_ description: String) {
            if let result = NativeType(description) {
                self = CGFloat(result)
            } else {
                return nil
            }
        }

        // MARK: - PointProtocol

        // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
        /// The type to be used as a vector.
        public typealias Vector = Stride

        // MARK: - RealArithmetic

        // [_Inherit Documentation: SDGCornerstone.RealArithmetic.e_]
        /// An instance of *e*.
        public static let e: CGFloat = CGFloat(Double.e)
    }
#endif

#if os(macOS) || os(Linux)
    extension Float80 : FloatFamily {

        // MARK: - FloatFamily

        // [_Inherit Documentation: SDGCornerstone.FloatFamily.ln2_]
        /// The value of ln2.
        public static let ln2: Float80 = 0x1.62E42FEFA39EF358p-1

        // MARK: - PointProtocol

        // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
        /// The type to be used as a vector.
        public typealias Vector = Stride

        // MARK: - RealArithmetic

        // [_Inherit Documentation: SDGCornerstone.RealArithmetic.e_]
        /// An instance of *e*.
        public static let e: Float80 = 0x1.5BF0A8B145769535p1
    }
#endif

extension Float : FloatFamily, PropertyListValue {

    // MARK: - FloatFamily

    // [_Inherit Documentation: SDGCornerstone.FloatFamily.ln2_]
    /// The value of ln2.
    public static let ln2: Float = 0x1.62E430p-1

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride

    // MARK: - RealArithmetic

    // [_Inherit Documentation: SDGCornerstone.RealArithmetic.e_]
    /// An instance of *e*.
    public static let e: Float = 0x1.5BF0A9p1
}

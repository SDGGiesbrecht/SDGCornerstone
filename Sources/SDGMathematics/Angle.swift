/*
 Angle.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An angle.
public struct Angle<Scalar : RealArithmetic> : CodableViaMeasurement {

    // MARK: - Initialization

    /// Creates an angle in radians.
    @inlinable public init(radians: Scalar) {
        self.inRadians = radians
    }

    /// Creates an angle in rotations.
    @inlinable public init(rotations: Scalar) {
        inRotations = rotations
    }

    /// Creates an angle in degrees.
    @inlinable public init(degrees: Scalar) {
        inDegrees = degrees
    }

    /// Creates an angle in minutes.
    @inlinable public init(minutes: Scalar) {
        inMinutes = minutes
    }

    /// Creates an angle in seconds.
    @inlinable public init(seconds: Scalar) {
        inSeconds = seconds
    }

    /// Creates an angle in gradians.
    @inlinable public init(gradians: Scalar) {
        inGradians = gradians
    }

    // MARK: - Units

    /// The numeric value in radians.
    public var inRadians: Scalar = Scalar.additiveIdentity

    @inlinable internal static var radiansPerRotation: Scalar {
        return Scalar.τ
    }
    /// The numeric value in rotations.
    @inlinable public var inRotations: Scalar {
        get {
            return inRadians ÷ Angle.radiansPerRotation
        }
        set {
            inRadians = newValue × Angle.radiansPerRotation
        }
    }

    @inlinable internal static var radiansPerDegree: Scalar {
        return radiansPerRotation ÷ 360
    }
    /// The numeric value in degrees.
    @inlinable public var inDegrees: Scalar {
        get {
            return inRadians ÷ Angle.radiansPerDegree
        }
        set {
            inRadians = newValue × Angle.radiansPerDegree
        }
    }

    @inlinable internal static var radiansPerMinute: Scalar {
        return radiansPerDegree ÷ 60
    }
    /// The numeric value in minutes.
    @inlinable public var inMinutes: Scalar {
        get {
            return inRadians ÷ Angle.radiansPerMinute
        }
        set {
            inRadians = newValue × Angle.radiansPerMinute
        }
    }

    @inlinable internal static var radiansPerSecond: Scalar {
        return radiansPerMinute ÷ 60
    }
    /// The numeric value in seconds.
    @inlinable public var inSeconds: Scalar {
        get {
            return inRadians ÷ Angle.radiansPerSecond
        }
        set {
            inRadians = newValue × Angle.radiansPerSecond
        }
    }

    @inlinable internal static var radiansPerGradian: Scalar {
        return radiansPerRotation ÷ 400
    }
    /// The numeric value in gradians.
    @inlinable public var inGradians: Scalar {
        get {
            return inRadians ÷ Angle.radiansPerGradian
        }
        set {
            inRadians = newValue × Angle.radiansPerGradian
        }
    }

    // MARK: - Measurement

    // #documentation(SDGCornerstone.Measurement.init(rawValue:))
    /// Creates a measurement from a raw value in undefined but consistent units.
    ///
    /// Used by `Measurement`’s default implementation of methods where various units make no difference (such as multiplication by a scalar).
    @inlinable public init(rawValue: Scalar) {
        inRadians = rawValue
    }

    // #documentation(SDGCornerstone.Measurement.rawValue)
    /// A raw value in undefined but consistent units.
    ///
    /// Used by `Measurement`’s default implementation of methods where various units make no difference (such as multiplication by a scalar).
    @inlinable public var rawValue: Scalar {
        get {
            return inRadians
        }
        set {
            inRadians = newValue
        }
    }
}

extension RealArithmetic {

    // ••••••• ••••••• ••••••• ••••••• ••••••• ••••••• •••••••
    // Symbol versions are more legible beside literals, but less legible beside variables. For this reason, both symbols and full names should remain available.
    // ••••••• ••••••• ••••••• ••••••• ••••••• ••••••• •••••••

    // @documentation(SDGCornerstone.RealArithmetic.radians)
    /// Returns an angle in radians.
    @inlinable public var radians: Angle<Self> {
        return Angle(radians: self)
    }

    // #documentation(SDGCornerstone.RealArithmetic.radians)
    /// Returns an angle in radians.
    @inlinable public var rad: Angle<Self> {
        return radians
    }

    // @documentation(SDGCornerstone.RealArithmetic.rotations)
    /// Returns an angle in rotations.
    @inlinable public var rotations: Angle<Self> {
        return Angle(rotations: self)
    }

    // @documentation(SDGCornerstone.RealArithmetic.degrees)
    /// Returns an angle in degrees.
    @inlinable public var degrees: Angle<Self> {
        return Angle(degrees: self)
    }

    // @documentation(SDGCornerstone.RealArithmetic.°)
    /// Returns an angle in degrees.
    ///
    /// - Parameters:
    ///     - value: The value in degrees.
    @inlinable public static postfix func ° (value: Self) -> Angle<Self> {
        return value.degrees
    }

    // @documentation(SDGCornerstone.RealArithmetic.minutes)
    /// Returns an angle in minutes.
    @inlinable public var minutes: Angle<Self> {
        return Angle(minutes: self)
    }

    // @documentation(SDGCornerstone.RealArithmetic.′)
    /// Returns an angle in minutes.
    ///
    /// - Parameters:
    ///     - value: The value in minutes.
    @inlinable public static postfix func ′ (value: Self) -> Angle<Self> {
        return value.minutes
    }

    // @documentation(SDGCornerstone.RealArithmetic.seconds)
    /// Returns an angle in seconds.
    @inlinable public var seconds: Angle<Self> {
        return Angle(seconds: self)
    }

    // @documentation(SDGCornerstone.RealArithmetic.′′)
    /// Returns an angle in seconds.
    ///
    /// - Parameters:
    ///     - value: The value in seconds.
    @inlinable public static postfix func ′′ (value: Self) -> Angle<Self> {
        return value.seconds
    }

    // @documentation(SDGCornerstone.RealArithmetic.gradians)
    /// Returns an angle in gradians.
    @inlinable public var gradians: Angle<Self> {
        return Angle(gradians: self)
    }

    // @documentation(SDGCornerstone.RealArithmetic.gradians)
    /// Returns an angle in gradians.
    @inlinable public var gon: Angle<Self> {
        return gradians
    }
}

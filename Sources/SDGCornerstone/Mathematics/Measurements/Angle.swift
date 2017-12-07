/*
 Angle.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An angle.
public struct Angle<Scalar : RealArithmetic> : CodableViaMeasurement {

    // MARK: - Initialization

    /// Creates an angle in radians.
    public init(radians: Scalar) {
        self.inRadians = radians
    }

    /// Creates an angle in rotations.
    public init(rotations: Scalar) {
        inRotations = rotations
    }

    /// Creates an angle in degrees.
    public init(degrees: Scalar) {
        inDegrees = degrees
    }

    /// Creates an angle in minutes.
    public init(minutes: Scalar) {
        inMinutes = minutes
    }

    /// Creates an angle in seconds.
    public init(seconds: Scalar) {
        inSeconds = seconds
    }

    /// Creates an angle in gradians.
    public init(gradians: Scalar) {
        inGradians = gradians
    }

    // MARK: - Units

    /// The numeric value in radians.
    public var inRadians: Scalar = Scalar.additiveIdentity

    private static var radiansPerRotation: Scalar {
        return Scalar.τ
    }
    /// The numeric value in rotations.
    public var inRotations: Scalar {
        get {
            return inRadians ÷ Angle.radiansPerRotation
        }
        set {
            inRadians = newValue × Angle.radiansPerRotation
        }
    }

    private static var radiansPerDegree: Scalar {
        return radiansPerRotation ÷ 360
    }
    /// The numeric value in degrees.
    public var inDegrees: Scalar {
        get {
            return inRadians ÷ Angle.radiansPerDegree
        }
        set {
            inRadians = newValue × Angle.radiansPerDegree
        }
    }

    private static var radiansPerMinute: Scalar {
        return radiansPerDegree ÷ 60
    }
    /// The numeric value in minutes.
    public var inMinutes: Scalar {
        get {
            return inRadians ÷ Angle.radiansPerMinute
        }
        set {
            inRadians = newValue × Angle.radiansPerMinute
        }
    }

    private static var radiansPerSecond: Scalar {
        return radiansPerMinute ÷ 60
    }
    /// The numeric value in seconds.
    public var inSeconds: Scalar {
        get {
            return inRadians ÷ Angle.radiansPerSecond
        }
        set {
            inRadians = newValue × Angle.radiansPerSecond
        }
    }

    private static var radiansPerGradian: Scalar {
        return radiansPerRotation ÷ 400
    }
    /// The numeric value in gradians.
    public var inGradians: Scalar {
        get {
            return inRadians ÷ Angle.radiansPerGradian
        }
        set {
            inRadians = newValue × Angle.radiansPerGradian
        }
    }

    // MARK: - Measurement

    // [_Inherit Documentation: SDGCornerstone.Measurement.init(rawValue:)_]
    /// Creates a measurement from a raw value in undefined but consistent units.
    ///
    /// Used by `Measurement`’s default implementation of methods where various units make no difference (such as multiplication by a scalar).
    public init(rawValue: Scalar) {
        inRadians = rawValue
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.rawValue_]
    /// A raw value in undefined but consistent units.
    ///
    /// Used by `Measurement`’s default implementation of methods where various units make no difference (such as multiplication by a scalar).
    public var rawValue: Scalar {
        get {
            return inRadians
        }
        set {
            inRadians = newValue
        }
    }
}

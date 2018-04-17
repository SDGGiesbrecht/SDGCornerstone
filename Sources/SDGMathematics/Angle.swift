/*
 Angle.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

#if canImport(CoreGraphics)
import CoreGraphics
#endif

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

import SDGControlFlow

/// An angle.
public struct Angle<Scalar : RealArithmetic> : CodableViaMeasurement, CustomPlaygroundDisplayConvertible {

    // MARK: - Initialization

    /// Creates an angle in radians.
    @_inlineable public init(radians: Scalar) {
        self.inRadians = radians
    }

    /// Creates an angle in rotations.
    @_inlineable public init(rotations: Scalar) {
        inRotations = rotations
    }

    /// Creates an angle in degrees.
    @_inlineable public init(degrees: Scalar) {
        inDegrees = degrees
    }

    /// Creates an angle in minutes.
    @_inlineable public init(minutes: Scalar) {
        inMinutes = minutes
    }

    /// Creates an angle in seconds.
    @_inlineable public init(seconds: Scalar) {
        inSeconds = seconds
    }

    /// Creates an angle in gradians.
    @_inlineable public init(gradians: Scalar) {
        inGradians = gradians
    }

    // MARK: - Units

    /// The numeric value in radians.
    public var inRadians: Scalar = Scalar.additiveIdentity

    @_inlineable @_versioned internal static var radiansPerRotation: Scalar {
        return Scalar.τ
    }
    /// The numeric value in rotations.
    @_inlineable public var inRotations: Scalar {
        get {
            return inRadians ÷ Angle.radiansPerRotation
        }
        set {
            inRadians = newValue × Angle.radiansPerRotation
        }
    }

    @_inlineable @_versioned internal static var radiansPerDegree: Scalar {
        return radiansPerRotation ÷ 360
    }
    /// The numeric value in degrees.
    @_inlineable public var inDegrees: Scalar {
        get {
            return inRadians ÷ Angle.radiansPerDegree
        }
        set {
            inRadians = newValue × Angle.radiansPerDegree
        }
    }

    @_inlineable @_versioned internal static var radiansPerMinute: Scalar {
        return radiansPerDegree ÷ 60
    }
    /// The numeric value in minutes.
    @_inlineable public var inMinutes: Scalar {
        get {
            return inRadians ÷ Angle.radiansPerMinute
        }
        set {
            inRadians = newValue × Angle.radiansPerMinute
        }
    }

    @_inlineable @_versioned internal static var radiansPerSecond: Scalar {
        return radiansPerMinute ÷ 60
    }
    /// The numeric value in seconds.
    @_inlineable public var inSeconds: Scalar {
        get {
            return inRadians ÷ Angle.radiansPerSecond
        }
        set {
            inRadians = newValue × Angle.radiansPerSecond
        }
    }

    @_inlineable @_versioned internal static var radiansPerGradian: Scalar {
        return radiansPerRotation ÷ 400
    }
    /// The numeric value in gradians.
    @_inlineable public var inGradians: Scalar {
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
    @_inlineable public init(rawValue: Scalar) {
        inRadians = rawValue
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.rawValue_]
    /// A raw value in undefined but consistent units.
    ///
    /// Used by `Measurement`’s default implementation of methods where various units make no difference (such as multiplication by a scalar).
    @_inlineable public var rawValue: Scalar {
        get {
            return inRadians
        }
        set {
            inRadians = newValue
        }
    }

    // MARK: - CustomPlaygroundDisplayConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomPlaygroundDisplayConvertible.playgroundDescription_]
    @_inlineable public var playgroundDescription: Any {
        #if canImport(CoreGraphics) && (canImport(AppKit) || canImport(UIKit))
        let arrow = BezierPath()
        arrow.move(to: CGPoint(x: 0, y: 0))
        arrow.line(to: CGPoint(x: 0, y: 70))
        arrow.line(to: CGPoint(x: 10, y: 60))
        arrow.line(to: CGPoint(x: 0, y: 70))
        arrow.line(to: CGPoint(x: −10, y: 60))
        arrow.line(to: CGPoint(x: 0, y: 70))

        let approximation = CGFloat((self − 90°).inRadians.floatingPointApproximation)
        let rotation = AffineTransform(rotationByRadians: approximation)
        arrow.transform(using: rotation)

        return arrow
        #else
        return String(describing: self)
        #endif
    }
}

extension RealArithmetic {

    // ••••••• ••••••• ••••••• ••••••• ••••••• ••••••• •••••••
    // Symbol versions are more legible beside literals, but less legible beside variables. For this reason, both symbols and full names should remain available.
    // ••••••• ••••••• ••••••• ••••••• ••••••• ••••••• •••••••

    // [_Define Documentation: SDGCornerstone.RealArithmetic.radians_]
    /// Returns an angle in radians.
    @_inlineable public var radians: Angle<Self> {
        return Angle(radians: self)
    }

    // [_Inherit Documentation: SDGCornerstone.RealArithmetic.radians_]
    /// Returns an angle in radians.
    @_inlineable public var rad: Angle<Self> {
        return radians
    }

    // [_Define Documentation: SDGCornerstone.RealArithmetic.rotations_]
    /// Returns an angle in rotations.
    @_inlineable public var rotations: Angle<Self> {
        return Angle(rotations: self)
    }

    // [_Define Documentation: SDGCornerstone.RealArithmetic.degrees_]
    /// Returns an angle in degrees.
    @_inlineable public var degrees: Angle<Self> {
        return Angle(degrees: self)
    }

    // [_Define Documentation: SDGCornerstone.RealArithmetic.°_]
    /// Returns an angle in degrees.
    ///
    /// - Parameters:
    ///     - value: The value in degrees.
    @_inlineable public static postfix func ° (value: Self) -> Angle<Self> {
        return value.degrees
    }

    // [_Define Documentation: SDGCornerstone.RealArithmetic.minutes_]
    /// Returns an angle in minutes.
    @_inlineable public var minutes: Angle<Self> {
        return Angle(minutes: self)
    }

    // [_Define Documentation: SDGCornerstone.RealArithmetic.′_]
    /// Returns an angle in minutes.
    ///
    /// - Parameters:
    ///     - value: The value in minutes.
    @_inlineable public static postfix func ′ (value: Self) -> Angle<Self> {
        return value.minutes
    }

    // [_Define Documentation: SDGCornerstone.RealArithmetic.seconds_]
    /// Returns an angle in seconds.
    @_inlineable public var seconds: Angle<Self> {
        return Angle(seconds: self)
    }

    // [_Define Documentation: SDGCornerstone.RealArithmetic.′′_]
    /// Returns an angle in seconds.
    ///
    /// - Parameters:
    ///     - value: The value in seconds.
    @_inlineable public static postfix func ′′ (value: Self) -> Angle<Self> {
        return value.seconds
    }

    // [_Define Documentation: SDGCornerstone.RealArithmetic.gradians_]
    /// Returns an angle in gradians.
    @_inlineable public var gradians: Angle<Self> {
        return Angle(gradians: self)
    }

    // [_Define Documentation: SDGCornerstone.RealArithmetic.gradians_]
    /// Returns an angle in gradians.
    @_inlineable public var gon: Angle<Self> {
        return gradians
    }
}

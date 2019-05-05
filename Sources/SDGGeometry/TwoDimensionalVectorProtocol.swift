/*
 TwoDimensionalVector.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A two‐dimensional vector.
///
/// Conformance Requirements:
///
/// - `var Δx: Scalar { get set }`
/// - `var Δy: Scalar { get set }`
public protocol TwoDimensionalVectorProtocol : Negatable, VectorProtocol {

    /// Creates a vector using the specified differences in *x* and *y*.
    ///
    /// - Parameters:
    ///     - Δx: The difference in *x*.
    ///     - Δy: The difference in *y*.
    init(Δx: Scalar, Δy: Scalar)

    /// The difference in *x*.
    var Δx: Scalar { get set }

    /// The difference in *y*.
    var Δy: Scalar { get set }
}

extension TwoDimensionalVectorProtocol {

    @inlinable public init(Δx: Scalar, Δy: Scalar) {
        self = Self.zero
        self.Δx = Δx
        self.Δy = Δy
    }
}

extension TwoDimensionalVectorProtocol where Self.Scalar : RealArithmetic {

    /// Creates a vector from an angular direction and a length.
    ///
    /// - Parameters:
    ///     - direction: The direction of the vector.
    ///     - length: The length of the vector.
    @inlinable public init(direction: Angle<Scalar>, length: Scalar) {
        self.init(Δx: cos(direction) × length, Δy: sin(direction) × length)
    }

    /// The angular direction of the vector.
    @inlinable public var direction: Angle<Scalar> {
        get {
            // Intercept Division by Zero
            if Δx == 0 {
                if Δy < 0 {
                    let result: Scalar = 3 × π() ÷ 2
                    return result.radians
                } else {
                    let result: Scalar = π() ÷ 2
                    return result.radians
                }
            }

            let referenceAngle = arctan(|(Δy ÷ Δx)|)
            if Δx < 0 {
                if Δy < 0 {
                    return (π() as Scalar).radians + referenceAngle
                } else {
                    return (π() as Scalar).radians − referenceAngle
                }
            } else {
                if Δy < 0 {
                    let constant: Scalar = 2 × π()
                    return constant.radians − referenceAngle
                } else {
                    return referenceAngle
                }
            }
        }
        set {
            self = Self(direction: newValue, length: length)
        }
    }

    /// The length of the vector.
    @inlinable public var length: Scalar {
        get {
            return √(Δx ↑ 2 + Δy ↑ 2)
        }
        set {
            self = Self(direction: direction, length: newValue)
        }
    }

    // MARK: - Addable

    @inlinable public static func += (precedingValue: inout Self, followingValue: Self) {
        precedingValue.Δx += followingValue.Δx
        precedingValue.Δy += followingValue.Δy
    }

    // MARK: - Subtractable

    @inlinable public static func −= (precedingValue: inout Self, followingValue: Self) {
        precedingValue.Δx −= followingValue.Δx
        precedingValue.Δy −= followingValue.Δy
    }

    // MARK: - Hashable

    @inlinable public func hash(into hasher: inout Hasher) {
        hasher.combine(Δx)
        hasher.combine(Δy)
    }

    // MARK: - VectorProtocol

    @inlinable public static func ×=(precedingValue: inout Self, followingValue: Scalar) {
        precedingValue.Δx ×= followingValue
        precedingValue.Δy ×= followingValue
    }

    @inlinable public static func ÷=(precedingValue: inout Self, followingValue: Scalar) {
        precedingValue.Δx ÷= followingValue
        precedingValue.Δy ÷= followingValue
    }
}

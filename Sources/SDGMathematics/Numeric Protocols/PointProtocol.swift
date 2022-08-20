/*
 PointProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A type that can be used with `+(_:_:)` and `−(_:_:)` in conjunction with an associated `Vector` type.
///
/// - Note: Unlike `Strideable`, types conforming to `PointProtocol` do not need to conform to `Comparable`, allowing conformance by two‐dimensional points, etc.
public protocol PointProtocol: Decodable, Encodable, Equatable, Sendable {

  /// The type to be used as a vector.
  associatedtype Vector: Negatable

  /// Returns the point arrived at by starting at the preceding point and moving according to the following vector.
  ///
  /// - Parameters:
  ///     - precedingValue: The starting point.
  ///     - followingValue: The vector to add.
  static func + (precedingValue: Self, followingValue: Vector) -> Self

  /// Moves the preceding point by the following vector.
  ///
  /// - Parameters:
  ///     - precedingValue: The point to modify.
  ///     - followingValue: The vector to add.
  static func += (precedingValue: inout Self, followingValue: Vector)

  /// Returns the point arrived at by starting at the preceding point and moving according to the inverse of the following vector.
  ///
  /// - Parameters:
  ///     - precedingValue: The starting point.
  ///     - followingValue: The vector to subtract.
  static func − (precedingValue: Self, followingValue: Vector) -> Self

  /// Returns the vector that leads from the preceding point to the following point.
  ///
  /// - Parameters:
  ///     - precedingValue: The endpoint.
  ///     - followingValue: The startpoint.
  static func − (precedingValue: Self, followingValue: Self) -> Vector

  /// Moves the preceding point by the inverse of the following vector.
  ///
  /// - Parameters:
  ///     - precedingValue: The point to modify.
  ///     - followingValue: The vector to subtract.
  static func −= (precedingValue: inout Self, followingValue: Vector)
}

extension PointProtocol {

  @inlinable public static func + (precedingValue: Self, followingValue: Vector) -> Self {
    return nonmutatingVariant(of: +=, on: precedingValue, with: followingValue)
  }

  @inlinable public static func − (precedingValue: Self, followingValue: Vector) -> Self {
    return nonmutatingVariant(of: −=, on: precedingValue, with: followingValue)
  }

  @inlinable public static func −= (precedingValue: inout Self, followingValue: Vector) {
    precedingValue += −followingValue
  }
}

extension PointProtocol where Self.Vector == Self {

  // This also covers all clashes with Addable and Subtractable, since Vector must conform to them via Negatable.

  @inlinable public static func + (precedingValue: Self, followingValue: Self) -> Self {
    // Disambiguate Addable.+ vs PointProtocol.+
    return nonmutatingVariant(of: +=, on: precedingValue, with: followingValue)
  }

  @inlinable public static func − (precedingValue: Self, followingValue: Self) -> Self {
    // Disambiguate Self − Vector vs Self − Self
    return nonmutatingVariant(of: −=, on: precedingValue, with: followingValue)
  }
}

extension PointProtocol where Self: Strideable {

  @inlinable public static func + (precedingValue: Self, followingValue: Vector) -> Self {
    // Disambiguate PointProtocol vs Strideable
    return nonmutatingVariant(of: +=, on: precedingValue, with: followingValue)
  }
}

extension PointProtocol where Self: Strideable, Self.Stride == Self.Vector {

  @inlinable public static func + (precedingValue: Self, followingValue: Vector) -> Self {
    // Disambiguate PointProtocol.+ vs Strideable.+
    return nonmutatingVariant(of: +=, on: precedingValue, with: followingValue)
  }
}

extension PointProtocol where Self.Vector == Self, Self: Strideable, Self.Stride == Self.Vector {

  @inlinable public static func + (precedingValue: Self, followingValue: Self) -> Self {
    // Disambiguate PointProtocol.+ vs Strideable.+
    return nonmutatingVariant(of: +=, on: precedingValue, with: followingValue)
  }
}

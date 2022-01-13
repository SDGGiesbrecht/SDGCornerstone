/*
 Addable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A type that can be used with `+(_:_:)`.
///
/// The precise behaviour of `+` depends on the conforming type. It may be arithmetic addition, string concatenation, etc.
public protocol Addable {

  // @documentation(Addable.+)
  /// Returns the sum, concatenation, or the result of a similar operation on two values implied by the “+” symbol.
  ///
  /// Exact behaviour depends on the type.
  ///
  /// - Parameters:
  ///     - precedingValue: The starting value.
  ///     - followingValue: The value to add.
  static func + (precedingValue: Self, followingValue: Self) -> Self

  /// Adds or concatenates the following value to the preceding value, or performs a similar operation implied by the “+” symbol.
  ///
  /// Exact behaviour depends on the type.
  ///
  /// - Parameters:
  ///     - precedingValue: The value to modify.
  ///     - followingValue: The value to add.
  static func += (precedingValue: inout Self, followingValue: Self)
}

extension Addable {
  
  #warning("Debugging...")
  public func verifyAddable() {
    _ = self + self
    print(#function, Self.self)
  }

  @inlinable public static func + (precedingValue: Self, followingValue: Self) -> Self {
    return nonmutatingVariant(of: +=, on: precedingValue, with: followingValue)
  }
}

extension Addable where Self: Strideable, Self.Stride == Self {

  @inlinable public static func + (precedingValue: Self, followingValue: Self) -> Self {
    // Disambiguate Addable vs Strideable
    return nonmutatingVariant(of: +=, on: precedingValue, with: followingValue)
  }
}

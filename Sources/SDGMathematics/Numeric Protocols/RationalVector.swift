/*
 RationalVector.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// An value that can be used with ×(_:_) and ÷(_:_:) in conjunction with a scalar.
public protocol RationalVector: VectorProtocol
where Scalar: RationalArithmetic {

  /// Returns the quotient of the preceding value divided by the following value.
  ///
  /// - Parameters:
  ///     - precedingValue: The dividend.
  ///     - followingValue: The divisor.
  static func ÷ (precedingValue: Self, followingValue: Scalar) -> Self

  // @documentation(RationalVector.÷=)
  /// Modifies the preceding value by dividing it by the following value.
  ///
  /// - Parameters:
  ///     - precedingValue: The value to modify.
  ///     - followingValue: The divisor.
  static func ÷= (precedingValue: inout Self, followingValue: Scalar)
}

extension RationalVector {

  @inlinable public static func ÷ (precedingValue: Self, followingValue: Scalar) -> Self {
    return nonmutatingVariant(of: ÷=, on: precedingValue, with: followingValue)
  }
}

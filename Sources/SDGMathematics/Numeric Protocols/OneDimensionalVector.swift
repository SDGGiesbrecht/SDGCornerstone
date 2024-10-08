/*
 OneDimensionalVector.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2024 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A one‐dimensional value that can be used with ×(_:_) and ÷(_:_:) in conjunction with a scalar.
public protocol OneDimensionalVector: VectorProtocol {

  /// Returns the quotient of the precedng value divided by the following value.
  ///
  /// - Parameters:
  ///   - precedingValue: The dividend.
  ///   - followingValue: The divisor.
  static func ÷ (precedingValue: Self, followingValue: Self) -> Scalar
}

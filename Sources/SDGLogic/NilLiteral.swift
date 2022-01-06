/*
 NilLiteral.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A `nil` literal.
public struct NilLiteral: ExpressibleByNilLiteral {

  // MARK: - Initialization

  /// Creates an instance of `NilLiteral`.
  ///
  /// - Parameters:
  ///     - nilLiteral: Void.
  @inlinable public init(nilLiteral: Void) {}

  // MARK: - Equality

  // #documentation(SDGCornerstone.Equatable.≠)
  /// Returns `true` if the two values are inequal.
  ///
  /// - Parameters:
  ///     - precedingValue: A value to compare.
  ///     - followingValue: Another value to compare.
  @inlinable public static func ≠ <T>(precedingValue: T?, followingValue: NilLiteral) -> Bool {
    return precedingValue != nil  // @exempt(from: unicode)
    // Allows “x ≠ nil” even when x is not Equatable.
  }
}

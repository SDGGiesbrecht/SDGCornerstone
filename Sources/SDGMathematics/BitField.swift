/*
 BitField.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A type that can be used with bitwise operations.
public protocol BitField: Equatable {

  /// Returns the bits not present in `self`.
  func bitwiseNot() -> Self

  /// Inverts the bits.
  mutating func formBitwiseNot()

  /// Returns the bits present in both `self` and `other`.
  ///
  /// - Parameters:
  ///     - other: The other bits.
  func bitwiseAnd(with other: Self) -> Self

  /// Removes the bits not also present in `other`.
  ///
  /// - Parameters:
  ///     - other: The other bits.
  mutating func formBitwiseAnd(with other: Self)

  /// Returns the bits present in either `self` or `other`.
  ///
  /// - Parameters:
  ///     - other: The other bits.
  func bitwiseOr(with other: Self) -> Self

  /// Inserts the bits present in `other`.
  ///
  /// - Parameters:
  ///     - other: The other bits.
  mutating func formBitwiseOr(with other: Self)

  /// Returns the bits present only in `self` or only in `other`.
  ///
  /// - Parameters:
  ///     - other: The other bits.
  func bitwiseExclusiveOr(with other: Self) -> Self

  /// Inserts the bits present in `other` and removes the bits present in both.
  ///
  /// - Parameters:
  ///     - other: The other bits.
  mutating func formBitwiseExclusiveOr(with other: Self)
}

extension BitField {

  @inlinable public func bitwiseNot() -> Self {
    return nonmutatingVariant(of: { $0.formBitwiseNot() }, on: self)
  }

  @inlinable public func bitwiseAnd(with other: Self) -> Self {
    return nonmutatingVariant(of: { $0.formBitwiseAnd(with: $1) }, on: self, with: other)
  }

  @inlinable public func bitwiseOr(with other: Self) -> Self {
    return nonmutatingVariant(of: { $0.formBitwiseOr(with: $1) }, on: self, with: other)
  }

  @inlinable public func bitwiseExclusiveOr(with other: Self) -> Self {
    return nonmutatingVariant(of: { $0.formBitwiseExclusiveOr(with: $1) }, on: self, with: other)
  }
}

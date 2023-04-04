/*
 Tuple.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// MARK: - Tuple

// #documentation(SDGCornerstone.Equatable.≠)
/// Returns `true` if the two values are inequal.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
@inlinable public func ≠ <A: Equatable, B: Equatable>(
  precedingValue: (A, B),
  followingValue: (A, B)
) -> Bool {
  return precedingValue != followingValue  // @exempt(from: unicode)
}

// #documentation(SDGCornerstone.Equatable.≠)
/// Returns `true` if the two values are inequal.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
@inlinable public func ≠ <A: Equatable, B: Equatable, C: Equatable>(
  precedingValue: (A, B, C),
  followingValue: (A, B, C)
) -> Bool {
  return precedingValue != followingValue  // @exempt(from: unicode)
}

// #documentation(SDGCornerstone.Equatable.≠)
/// Returns `true` if the two values are inequal.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
@inlinable public func ≠ <A: Equatable, B: Equatable, C: Equatable, D: Equatable>(
  precedingValue: (A, B, C, D),
  followingValue: (A, B, C, D)
) -> Bool {
  return precedingValue != followingValue  // @exempt(from: unicode)
}

// #documentation(SDGCornerstone.Equatable.≠)
/// Returns `true` if the two values are inequal.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
@inlinable public func ≠ <A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable>(
  precedingValue: (A, B, C, D, E),
  followingValue: (A, B, C, D, E)
) -> Bool {
  return precedingValue != followingValue  // @exempt(from: unicode)
}

// #documentation(SDGCornerstone.Equatable.≠)
/// Returns `true` if the two values are inequal.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
@inlinable
public func ≠ <
  A: Equatable,
  B: Equatable,
  C: Equatable,
  D: Equatable,
  E: Equatable,
  F: Equatable
>(precedingValue: (A, B, C, D, E, F), followingValue: (A, B, C, D, E, F)) -> Bool {
  return precedingValue != followingValue  // @exempt(from: unicode)
}

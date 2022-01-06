/*
 Any.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// MARK: - Any

// #documentation(SDGCornerstone.Equatable.≠)
/// Returns `true` if the two values are inequal.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
@inlinable public func ≠ (precedingValue: Any.Type?, followingValue: Any.Type?) -> Bool {
  return precedingValue != followingValue  // @exempt(from: unicode)
}

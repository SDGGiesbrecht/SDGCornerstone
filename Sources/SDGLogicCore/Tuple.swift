/*
 Tuple.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Workaround: Automatically handled by Equatable in Swift 4.1 (Swift 4.0.3)_]

// MARK: - Tuple

// [_Inherit Documentation: SDGCornerstone.Equatable.≠_]
/// Returns `true` if the two values are inequal.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
@_transparent public func ≠ <A : Equatable, B : Equatable>(precedingValue: (A, B), followingValue: (A, B)) -> Bool {
    return precedingValue != followingValue
}

// [_Inherit Documentation: SDGCornerstone.Equatable.≠_]
/// Returns `true` if the two values are inequal.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
@_transparent public func ≠ <A : Equatable, B : Equatable, C : Equatable>(precedingValue: (A, B, C), followingValue: (A, B, C)) -> Bool {
    return precedingValue != followingValue
}

// [_Inherit Documentation: SDGCornerstone.Equatable.≠_]
/// Returns `true` if the two values are inequal.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
@_transparent public func ≠ <A : Equatable, B : Equatable, C : Equatable, D : Equatable>(precedingValue: (A, B, C, D), followingValue: (A, B, C, D)) -> Bool {
    return precedingValue != followingValue
}

// [_Inherit Documentation: SDGCornerstone.Equatable.≠_]
/// Returns `true` if the two values are inequal.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
@_transparent public func ≠ <A : Equatable, B : Equatable, C : Equatable, D : Equatable, E : Equatable>(precedingValue: (A, B, C, D, E), followingValue: (A, B, C, D, E)) -> Bool {
    return precedingValue != followingValue
}

// [_Inherit Documentation: SDGCornerstone.Equatable.≠_]
/// Returns `true` if the two values are inequal.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
@_transparent public func ≠ <A : Equatable, B : Equatable, C : Equatable, D : Equatable, E : Equatable, F : Equatable>(precedingValue: (A, B, C, D, E, F), followingValue: (A, B, C, D, E, F)) -> Bool {
    return precedingValue != followingValue
}

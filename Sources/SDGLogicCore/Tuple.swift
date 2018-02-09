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
///     - lhs: A value to compare.
///     - rhs: Another value to compare.
@_inlineable public func ≠ <A : Equatable, B : Equatable>(lhs: (A, B), rhs: (A, B)) -> Bool {
    return lhs != rhs
}

// [_Inherit Documentation: SDGCornerstone.Equatable.≠_]
/// Returns `true` if the two values are inequal.
///
/// - Parameters:
///     - lhs: A value to compare.
///     - rhs: Another value to compare.
@_inlineable public func ≠ <A : Equatable, B : Equatable, C : Equatable>(lhs: (A, B, C), rhs: (A, B, C)) -> Bool {
    return lhs != rhs
}

// [_Inherit Documentation: SDGCornerstone.Equatable.≠_]
/// Returns `true` if the two values are inequal.
///
/// - Parameters:
///     - lhs: A value to compare.
///     - rhs: Another value to compare.
@_inlineable public func ≠ <A : Equatable, B : Equatable, C : Equatable, D : Equatable>(lhs: (A, B, C, D), rhs: (A, B, C, D)) -> Bool {
    return lhs != rhs
}

// [_Inherit Documentation: SDGCornerstone.Equatable.≠_]
/// Returns `true` if the two values are inequal.
///
/// - Parameters:
///     - lhs: A value to compare.
///     - rhs: Another value to compare.
@_inlineable public func ≠ <A : Equatable, B : Equatable, C : Equatable, D : Equatable, E : Equatable>(lhs: (A, B, C, D, E), rhs: (A, B, C, D, E)) -> Bool {
    return lhs != rhs
}

// [_Inherit Documentation: SDGCornerstone.Equatable.≠_]
/// Returns `true` if the two values are inequal.
///
/// - Parameters:
///     - lhs: A value to compare.
///     - rhs: Another value to compare.
@_inlineable public func ≠ <A : Equatable, B : Equatable, C : Equatable, D : Equatable, E : Equatable, F : Equatable>(lhs: (A, B, C, D, E, F), rhs: (A, B, C, D, E, F)) -> Bool {
    return lhs != rhs
}

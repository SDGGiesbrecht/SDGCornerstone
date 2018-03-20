/*
 Tuple.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Workaround: These are probably automatic in Swift 4.1 (Swift 4.0.3)_]

// [_Inherit Documentation: SDGCornerstone.Comparable.≤_]
/// Returns `true` if the preceding operand is ordered before or the same as the following operand.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
@_inlineable public func ≤ <A : Comparable, B : Comparable>(precedingValue: (A, B), followingValue: (A, B)) -> Bool {
    return precedingValue <= followingValue
}

// [_Inherit Documentation: SDGCornerstone.Comparable.≤_]
/// Returns `true` if the preceding operand is ordered before or the same as the following operand.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
@_inlineable public func ≤ <A : Comparable, B : Comparable, C : Comparable>(precedingValue: (A, B, C), followingValue: (A, B, C)) -> Bool {
    return precedingValue <= followingValue
}

// [_Inherit Documentation: SDGCornerstone.Comparable.≤_]
/// Returns `true` if the preceding operand is ordered before or the same as the following operand.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
@_inlineable public func ≤ <A : Comparable, B : Comparable, C : Comparable, D : Comparable>(precedingValue: (A, B, C, D), followingValue: (A, B, C, D)) -> Bool {
    return precedingValue <= followingValue
}

// [_Inherit Documentation: SDGCornerstone.Comparable.≤_]
/// Returns `true` if the preceding operand is ordered before or the same as the following operand.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
@_inlineable public func ≤ <A : Comparable, B : Comparable, C : Comparable, D : Comparable, E : Comparable>(precedingValue: (A, B, C, D, E), followingValue: (A, B, C, D, E)) -> Bool {
    return precedingValue <= followingValue
}

// [_Inherit Documentation: SDGCornerstone.Comparable.≤_]
/// Returns `true` if the preceding operand is ordered before or the same as the following operand.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
@_inlineable public func ≤ <A : Comparable, B : Comparable, C : Comparable, D : Comparable, E : Comparable, F : Comparable>(precedingValue: (A, B, C, D, E, F), followingValue: (A, B, C, D, E, F)) -> Bool {
    return precedingValue <= followingValue
}

// [_Inherit Documentation: SDGCornerstone.Comparable.≥_]
/// Returns `true` if the preceding operand is ordered after or the same as the following operand.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
@_inlineable public func ≥ <A : Comparable, B : Comparable>(precedingValue: (A, B), followingValue: (A, B)) -> Bool {
    return precedingValue >= followingValue
}

// [_Inherit Documentation: SDGCornerstone.Comparable.≥_]
/// Returns `true` if the preceding operand is ordered after or the same as the following operand.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
@_inlineable public func ≥ <A : Comparable, B : Comparable, C : Comparable>(precedingValue: (A, B, C), followingValue: (A, B, C)) -> Bool {
    return precedingValue >= followingValue
}

// [_Inherit Documentation: SDGCornerstone.Comparable.≥_]
/// Returns `true` if the preceding operand is ordered after or the same as the following operand.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
@_inlineable public func ≥ <A : Comparable, B : Comparable, C : Comparable, D : Comparable>(precedingValue: (A, B, C, D), followingValue: (A, B, C, D)) -> Bool {
    return precedingValue >= followingValue
}

// [_Inherit Documentation: SDGCornerstone.Comparable.≥_]
/// Returns `true` if the preceding operand is ordered after or the same as the following operand.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
@_inlineable public func ≥ <A : Comparable, B : Comparable, C : Comparable, D : Comparable, E : Comparable>(precedingValue: (A, B, C, D, E), followingValue: (A, B, C, D, E)) -> Bool {
    return precedingValue >= followingValue
}

// [_Inherit Documentation: SDGCornerstone.Comparable.≥_]
/// Returns `true` if the preceding operand is ordered after or the same as the following operand.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
@_inlineable public func ≥ <A : Comparable, B : Comparable, C : Comparable, D : Comparable, E : Comparable, F : Comparable>(precedingValue: (A, B, C, D, E, F), followingValue: (A, B, C, D, E, F)) -> Bool {
    return precedingValue >= followingValue
}

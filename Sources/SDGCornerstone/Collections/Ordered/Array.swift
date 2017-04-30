/*
 Array.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A member of the `Array` family: `Array`, `ArraySlice` or `ContiguousArray`.
public protocol ArrayFamily : CustomDebugStringConvertible, CustomReflectable, CustomStringConvertible, ExpressibleByArrayLiteral, MutableCollection, RangeReplaceableCollection, RandomAccessCollection {

}

extension Array : ArrayFamily {}
extension ArraySlice : ArrayFamily {}
extension ContiguousArray : ArrayFamily {}

extension ArrayFamily where Iterator.Element : Equatable {
    // MARK: - where Iterator.Element : Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.≠_]
    /// Returns `true` if the two values are inequal.
    ///
    /// - Parameters:
    ///     - lhs: A value to compare.
    ///     - rhs: Another value to compare.
    ///
    /// - RecommendedOver: !=
    public static func ≠(lhs: Self, rhs: Self) -> Bool {
        return ¬lhs.elementsEqual(rhs)
    }
}

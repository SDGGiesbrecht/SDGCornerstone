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

// [_Workaround: Should only conform to PropertyListValue when values conform to `PropertyListValue`. Currently not constrainable. (Swift 3.1.0)_]
extension Array : ArrayFamily, PropertyListValue {}
extension ArraySlice : ArrayFamily {}
extension ContiguousArray : ArrayFamily {}

extension ArrayFamily where Iterator.Element : Equatable {
    // MARK: - where Iterator.Element : Equatable

    // [_Workaround: This can be refactored once conditional conformance is available. (Swift 3.1.0)_]

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

extension ArrayFamily where Iterator.Element : RangeReplaceableCollection {
    // MARK: - where Iterator.Element : RangeReplaceableCollection

    /// Fills the collections in the array so that all of them have the same count.
    ///
    /// - Parameters:
    ///     - element: The element with which to fill the collections.
    ///     - direction: The direction from which to fill the collections.
    public mutating func equalizeCounts(byFillingWith element: Iterator.Element.Iterator.Element, from direction: FillDirection) {
        let count = reduce(0) { Swift.max($0, $1.count) }
        let mapped = map() { (collection: Iterator.Element) -> Iterator.Element in
            var mutable = collection
            mutable.fill(to: count, with: element, from: direction)
            return mutable
        }
        self = Self(mapped)
    }

    /// Returns the same array of collections, but with the shorter ones filled so that all of them have the same count.
    ///
    /// - Parameters:
    ///     - element: The element with which to fill the collections.
    ///     - direction: The direction from which to fill the collections.
    public func countsEqualized(byFillingWith element: Iterator.Element.Iterator.Element, from direction: FillDirection) -> Self {
        var result = self
        result.equalizeCounts(byFillingWith: element, from: direction)
        return result
    }
}

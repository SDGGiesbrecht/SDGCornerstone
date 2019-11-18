/*
 Array.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A member of the `Array` family: `Array`, `ArraySlice` or `ContiguousArray`.
public protocol ArrayFamily: CustomDebugStringConvertible, CustomReflectable,
  CustomStringConvertible, ExpressibleByArrayLiteral, MutableCollection, RangeReplaceableCollection,
  RandomAccessCollection
{}

extension Array: ArrayFamily {}
extension ArraySlice: ArrayFamily {}
extension ContiguousArray: ArrayFamily {}

extension Array: Pattern, SearchableBidirectionalCollection, SearchableCollection
where Element: Equatable {}
extension ArraySlice: Pattern, SearchableBidirectionalCollection, SearchableCollection
where Element: Equatable {}
extension ContiguousArray: Pattern, SearchableBidirectionalCollection, SearchableCollection
where Element: Equatable {}

extension ArrayFamily where Element: RangeReplaceableCollection {

  /// Fills the collections in the array so that all of them have the same count.
  ///
  /// - Parameters:
  ///     - element: The element with which to fill the collections.
  ///     - direction: The direction from which to fill the collections.
  @inlinable public mutating func equalizeCounts(
    byFillingWith element: Element.Element,
    from direction: FillDirection
  ) {
    let count = reduce(0) { Swift.max($0, $1.count) }
    let mapped = map { (collection: Element) -> Element in
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
  @inlinable public func countsEqualized(
    byFillingWith element: Element.Element,
    from direction: FillDirection
  ) -> Self {
    var result = self
    result.equalizeCounts(byFillingWith: element, from: direction)
    return result
  }
}

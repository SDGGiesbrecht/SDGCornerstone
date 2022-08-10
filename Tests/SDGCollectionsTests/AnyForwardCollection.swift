/*
 AnyForwardCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

struct AnyForwardCollection<Base>: Collection, Equatable, RangeReplaceableCollection,
  SearchableCollection
where Base: Equatable, Base: RangeReplaceableCollection, Base.Element: Equatable {

  // MARK: - Initialization

  init(_ base: Base) {
    self.base = base
  }

  // MARK: - Properties

  var base: Base

  // MARK: - Collection

  typealias Element = Base.Element

  var startIndex: Base.Index {
    return base.startIndex
  }

  var endIndex: Base.Index {
    return base.endIndex
  }

  func index(after i: Base.Index) -> Base.Index {
    return base.index(after: i)
  }

  subscript(position: Base.Index) -> Base.Element {
    return base[position]
  }

  // MARK: - Equatable

  static func == (precedingValue: Self, followingValue: Self) -> Bool {
    return precedingValue.base == followingValue.base
  }

  // MARK: - RangeReplaceableCollection

  init() {
    base = Base()
  }

  mutating func replaceSubrange<C>(_ subrange: Range<Base.Index>, with newElements: C)
  where C: Collection, C.Element == Base.Element {
    base.replaceSubrange(subrange, with: newElements)
  }

  // MARK: - SearchableCollection

  func temporaryWorkaroundFirstMatch<P>(
    for pattern: P,
    in subSequence: Slice<AnyForwardCollection<Base>>
  ) -> P.Match?
  where P: Pattern, Slice<AnyForwardCollection<Base>> == P.Match.Searched {
    return subSequence.firstMatch(for: pattern)
  }
}

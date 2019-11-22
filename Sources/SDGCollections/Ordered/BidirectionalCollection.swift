/*
 BidirectionalCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

extension BidirectionalCollection {

  /// Returns the backward version of the specified range.
  ///
  /// - Parameters:
  ///     - range: The range.
  @inlinable public func backward<R>(_ range: R) -> Range<ReversedCollection<Self>.Index>
  where R: RangeExpression, R.Bound == Self.Index {
    let resolved = range.relative(to: self)
    return ReversedCollection<Self>.Index(
      resolved.upperBound
    )..<ReversedCollection<Self>.Index(resolved.lowerBound)
  }

  /// Returns the forward version of the specified range.
  ///
  /// - Parameters:
  ///     - range: The range.
  @inlinable public func forward<R>(_ range: R) -> Range<Self.Index>
  where R: RangeExpression, R.Bound == ReversedCollection<Self>.Index {
    let resolved = range.relative(to: reversed())
    return resolved.upperBound.base..<resolved.lowerBound.base
  }

  // MARK: - Differences

  /// A shimmed version of `difference(from:by:)` with no availability constraints.
  @inlinable public func shimmedDifference<C>(
    from other: C,
    by areEquivalent: (Element, Element) -> Bool
  ) -> ShimmedCollectionDifference<Element>
  where C: BidirectionalCollection, C.Element == Self.Element {
    if #available(macOS 10.15, *) {
      let unshimmed = difference(from: other, by: areEquivalent)
      return ShimmedCollectionDifference(unshimmed)
    } else {
      return ShimmedCollectionDifference(unsafeChanges: changes(toMake: other, by: areEquivalent))
    }
  }
}

extension BidirectionalCollection where Element: Equatable {

  /// A shimmed version of `difference(from:)` with no availability constraints.
  @inlinable public func shimmedDifference<C>(
    from other: C
  ) -> ShimmedCollectionDifference<Element>
  where C: BidirectionalCollection, C.Element == Self.Element {
    return shimmedDifference(from: other, by: ==)
  }
}

/*
 BidirectionalPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A pattern that can be searched for in reverse.
///
/// - Requires: `Searchable` must conform to `SearchableBidirectionalCollection` even though the compiler is currently incapable of enforcing it.
public protocol BidirectionalPattern: Pattern
where Searchable: BidirectionalCollection {
  // #workaround(Swift 5.6.1, Should require Searchable: SearchableBidirectionalCollection, but for Windows compiler bug. Remove “requires” documentation too when fixed.)

  /// The type of the reverse pattern.
  associatedtype Reversed: Pattern
  where Reversed.Searchable == ReversedCollection<Searchable>

  /// Returns a pattern that checks for the reverse pattern.
  ///
  /// This is suitable for performing backward searches by applying it to the reversed collection.
  func reversed() -> Reversed

  /// Converts the reversed match into a match in the forward collection.
  ///
  /// - Parameters:
  ///     - reversedMatch: The reversed match.
  ///     - forwardCollection: The forward collection.
  func forward(
    match reversedMatch: Reversed.Match,
    in forwardCollection: Searchable
  ) -> Match
}

extension BidirectionalPattern {

  /// Converts a reversed range into a range in the forward collection.
  ///
  /// - Parameters:
  ///     - reversedRange: The reversed range.
  @inlinable public func forward(
    _ reversedRange: Range<Reversed.Searchable.Index>
  ) -> Range<Searchable.Index> {
    return reversedRange.upperBound.base..<reversedRange.lowerBound.base
  }
}

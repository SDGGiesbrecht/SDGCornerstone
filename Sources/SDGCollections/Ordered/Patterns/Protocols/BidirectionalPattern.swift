/*
 BidirectionalPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A pattern that can be searched for in reverse.
///
/// - Requires: The `Reversed.Searchable` must be `ReversedCollection<Searchable>`, but the Swift 5.8 compiler cannot enforce it due to a bug.
public protocol BidirectionalPattern: Pattern
where Searchable: SearchableBidirectionalCollection {

  // #workaround(Swift 5.8, The “#if” should not be necessary redundant; see BidirectionalPattern.Reversed for the reason.)
  #if compiler(<5.8)
    // #documentation(BidirectionalPattern.Reversed)
    /// The type of the reverse pattern.
    associatedtype Reversed: Pattern
    where Reversed.Searchable == ReversedCollection<Searchable>
  #else
    // @documentation(BidirectionalPattern.Reversed)
    /// The type of the reverse pattern.
    associatedtype Reversed: Pattern
  // #workaround(Swift 5.8, This constraint trips the compiler; also remove the “requires” documentation callout from “BidirectionalPattern” once fixed.)
  //where Reversed.Searchable == ReversedCollection<Searchable>
  #endif

  /// Returns a pattern that checks for the reverse pattern.
  ///
  /// This is suitable for performing backward searches by applying it to the reversed collection.
  func reversed() -> Reversed

  // @documentation(BidirectionalPattern.forward(match:in:))
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

extension BidirectionalPattern
// #workaround(Swift 5.8, The following constraint is redundant; see BidirectionalPattern.Reversed for the reason.)
where Reversed.Searchable == ReversedCollection<Searchable> {

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

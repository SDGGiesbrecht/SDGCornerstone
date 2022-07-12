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
public protocol BidirectionalPattern: Pattern
where Searchable: SearchableBidirectionalCollection {

  /// The type of the reverse pattern.
  associatedtype Reversed: Pattern
  where Reversed.Searchable == ReversedCollection<Searchable>

  /// Returns a pattern that checks for the reverse pattern.
  ///
  /// This is suitable for performing backward searches by applying it to the reversed collection.
  func reversed() -> Reversed
}

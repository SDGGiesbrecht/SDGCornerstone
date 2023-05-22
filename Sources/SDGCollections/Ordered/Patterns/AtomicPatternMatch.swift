/*
 AtomicPatternMatch.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A simple pattern match that cannot be further decomposed and contains no extra information.
public struct AtomicPatternMatch<Searched>: PatternMatch
where Searched: SearchableCollection {

  // MARK: - Initialization

  /// Creates a description of a match.
  ///
  /// - Parameters:
  ///   - range: The range of the match.
  ///   - collection: The collection containing the match.
  @inlinable public init<R>(range: R, in collection: Searched)
  where R: RangeExpression, R.Bound == Searched.Index {
    self.contents = collection[range.relative(to: collection)]
  }

  // MARK: - PatternMatch

  public let contents: Searched.SubSequence

  // MARK: - Conversions

  /// Returns the match converts to a different view of the same collection, such as from a slice to its base collection or vice versa.
  ///
  /// - Requires: All indices within the match must be valid for the target collection and point at the same elements.
  ///
  /// - Parameters:
  ///   - context: The new context of the match.
  @inlinable public func `in`<Context>(
    _ context: Context
  ) -> AtomicPatternMatch<Context>
  where Context: SearchableCollection, Context.Index == Searched.Index {
    return AtomicPatternMatch<Context>(range: range, in: context)
  }
}

extension AtomicPatternMatch: Sendable where Searched.SubSequence: Sendable {}

/*
 PatternMatch.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The result of a pattern search.
public protocol PatternMatch {

  // MARK: - Associated Types

  /// The searched collection.
  associatedtype Searched: SearchableCollection

  // MARK: - Properties

  /// The contents of the match.
  var contents: Searched.SubSequence { get }
}

extension PatternMatch {

  /// The range.
  @inlinable public var range: Range<Searched.Index> {
    return contents.bounds
  }
}

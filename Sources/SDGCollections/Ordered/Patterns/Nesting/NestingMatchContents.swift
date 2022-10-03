/*
 NestingMatchContents.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The contents of a nesting match.
public struct NestingMatchContents<Opening, Closing>: PatternMatch
where Opening: PatternMatch, Closing: PatternMatch, Closing.Searched == Opening.Searched {

  // MARK: - Initialization

  /// Creates nesting match contents.
  ///
  /// - Parameters:
  ///     - segments: The contents’ segments.
  ///     - contents: The subsequence corresponding to the segments taken together.
  @inlinable public init(
    segments: [NestingMatchSegment<Opening, Closing>],
    contents: Searched.SubSequence
  ) {
    self.segments = segments
    self._contents = contents
  }

  // MARK: - Properties

  /// The contents’ individual segments.
  public let segments: [NestingMatchSegment<Opening, Closing>]

  // MARK: - PatternMatch

  public typealias Searched = Opening.Searched
  // #workaround(workspace version 0.41.0, Indirection because “let” is not detected as protocol conformance during documentation.)
  @usableFromInline internal let _contents: Searched.SubSequence
  @inlinable public var contents: Searched.SubSequence {
    return _contents
  }
}

extension NestingMatchContents: Sendable
where Opening: Sendable, Closing: Sendable, Searched.SubSequence: Sendable {}

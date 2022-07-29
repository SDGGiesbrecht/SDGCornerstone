/*
 NestingMatchSegment.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A segment of the contents of a nesting match.
public enum NestingMatchSegment<Opening, Closing>: PatternMatch
where Opening: PatternMatch, Closing: PatternMatch, Closing.Searched == Opening.Searched {

  /// Other content.
  case other(AtomicPatternMatch<Searched>)
  /// A nested match.
  case nested(NestingMatch<Opening, Closing>)

  // MARK: - PatternMatch

  public typealias Searched = Opening.Searched

  @inlinable public var contents: Searched.SubSequence {
    switch self {
    case .other(let other):
      return other.contents
    case .nested(let nested):
      return nested.contents
    }
  }
}

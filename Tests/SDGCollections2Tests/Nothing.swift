/*
 Nothing.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections2

struct NothingSubPattern: SDGCollections2.Pattern {
  func matches(
    in collection: Substring,
    at location: Substring.Index
  ) -> [AtomicPatternMatch<Substring>] {
    return []
  }
  func forSubSequence() -> NothingSubPattern {
    return self
  }
  func convertMatch(
    from subSequenceMatch: AtomicPatternMatch<Substring>,
    in collection: Substring
  ) -> AtomicPatternMatch<Substring> {
    return subSequenceMatch.in(collection)
  }
}
struct Nothing: SDGCollections2.Pattern {
  func matches(
    in collection: String,
    at location: String.Index
  ) -> [AtomicPatternMatch<String>] {
    return []
  }
  func forSubSequence() -> NothingSubPattern {
    return NothingSubPattern()
  }
  func convertMatch(
    from subSequenceMatch: AtomicPatternMatch<Substring>,
    in collection: String
  ) -> AtomicPatternMatch<String> {
    return subSequenceMatch.in(collection)
  }
}

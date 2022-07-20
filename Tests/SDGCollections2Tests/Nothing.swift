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
struct ReversedNothingSubPattern: SDGCollections2.Pattern {
  func matches(
    in collection: Slice<ReversedCollection<String>>,
    at location: Slice<ReversedCollection<String>>.Index
  ) -> [AtomicPatternMatch<Slice<ReversedCollection<String>>>] {
    return []
  }
  func forSubSequence() -> ReversedNothingSubPattern {
    return self
  }
  func convertMatch(
    from subSequenceMatch: AtomicPatternMatch<Slice<ReversedCollection<String>>>,
    in collection: Slice<ReversedCollection<String>>
  ) -> AtomicPatternMatch<Slice<ReversedCollection<String>>> {
    return subSequenceMatch.in(collection)
  }
}
struct ReversedNothingPattern: SDGCollections2.Pattern {
  func matches(
    in collection: ReversedCollection<String>,
    at location: ReversedCollection<String>.Index
  ) -> [AtomicPatternMatch<ReversedCollection<String>>] {
    return []
  }
  func forSubSequence() -> ReversedNothingSubPattern {
    return ReversedNothingSubPattern()
  }
  func convertMatch(
    from subSequenceMatch: AtomicPatternMatch<Slice<ReversedCollection<String>>>,
    in collection: ReversedCollection<String>
  ) -> AtomicPatternMatch<ReversedCollection<String>> {
    return subSequenceMatch.in(collection)
  }
}
struct Nothing: SDGCollections2.BidirectionalPattern, SDGCollections2.Pattern {
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
  func reversed() -> ReversedNothingPattern {
    return ReversedNothingPattern()
  }
  func forward(
    match reversedMatch: AtomicPatternMatch<ReversedCollection<String>>,
    in forwardCollection: String
  ) -> AtomicPatternMatch<String> {
    let range = reversedMatch.range
    return AtomicPatternMatch(
      range: range.upperBound.base..<range.lowerBound.base,
      in: forwardCollection
    )
  }
}

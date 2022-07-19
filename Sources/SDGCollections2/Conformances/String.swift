/*
 String.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension String: BidirectionalPattern, SearchableBidirectionalCollection {
  @inlinable public func temporaryWorkaroundFirstMatch<P>(
    for pattern: P,
    in subSequence: Substring
  ) -> P.Match?
  where P: Pattern, Substring == P.Match.Searched {
    return subSequence.firstMatch(for: pattern)
  }
  @inlinable public func temporaryWorkaroundFirstMatch<P>(
    for pattern: P,
    in reversed: ReversedCollection<String>
  ) -> P.Match?
  where P : Pattern, P.Match.Searched == ReversedCollection<String> {
    return reversed.firstMatch(for: pattern)
  }
}
extension String.UnicodeScalarView: BidirectionalPattern, SearchableBidirectionalCollection {
  @inlinable public func temporaryWorkaroundFirstMatch<P>(
    for pattern: P,
    in subSequence: Substring.UnicodeScalarView
  ) -> P.Match?
  where P: Pattern, Substring.UnicodeScalarView == P.Match.Searched {
    return subSequence.firstMatch(for: pattern)
  }
  @inlinable public func temporaryWorkaroundFirstMatch<P>(
    for pattern: P,
    in reversed: ReversedCollection<String.UnicodeScalarView>
  ) -> P.Match?
  where P : Pattern, P.Match.Searched == ReversedCollection<String.UnicodeScalarView> {
    return reversed.firstMatch(for: pattern)
  }
}
extension String.UTF8View: BidirectionalPattern, SearchableBidirectionalCollection {
  @inlinable public func temporaryWorkaroundFirstMatch<P>(
    for pattern: P,
    in subSequence: Substring.UTF8View
  ) -> P.Match?
  where P: Pattern, Substring.UTF8View == P.Match.Searched {
    return subSequence.firstMatch(for: pattern)
  }
  @inlinable public func temporaryWorkaroundFirstMatch<P>(
    for pattern: P,
    in reversed: ReversedCollection<String.UTF8View>
  ) -> P.Match?
  where P : Pattern, P.Match.Searched == ReversedCollection<String.UTF8View> {
    return reversed.firstMatch(for: pattern)
  }
}
extension String.UTF16View: BidirectionalPattern, SearchableBidirectionalCollection {
  @inlinable public func temporaryWorkaroundFirstMatch<P>(
    for pattern: P,
    in subSequence: Substring.UTF16View
  ) -> P.Match?
  where P: Pattern, Substring.UTF16View == P.Match.Searched {
    return subSequence.firstMatch(for: pattern)
  }
  @inlinable public func temporaryWorkaroundFirstMatch<P>(
    for pattern: P,
    in reversed: ReversedCollection<String.UTF16View>
  ) -> P.Match?
  where P : Pattern, P.Match.Searched == ReversedCollection<String.UTF16View> {
    return reversed.firstMatch(for: pattern)
  }
}
extension Substring: BidirectionalPattern, SearchableBidirectionalCollection {
  @inlinable public func temporaryWorkaroundFirstMatch<P>(
    for pattern: P,
    in subSequence: Substring
  ) -> P.Match?
  where P: Pattern, Substring == P.Match.Searched {
    return subSequence.firstMatch(for: pattern)
  }
  @inlinable public func temporaryWorkaroundFirstMatch<P>(
    for pattern: P,
    in reversed: ReversedCollection<Substring>
  ) -> P.Match?
  where P : Pattern, P.Match.Searched == ReversedCollection<Substring> {
    return reversed.firstMatch(for: pattern)
  }
}
extension Substring.UnicodeScalarView: BidirectionalPattern, SearchableBidirectionalCollection {
  @inlinable public func temporaryWorkaroundFirstMatch<P>(
    for pattern: P,
    in subSequence: Substring.UnicodeScalarView
  ) -> P.Match?
  where P: Pattern, Substring.UnicodeScalarView == P.Match.Searched {
    return subSequence.firstMatch(for: pattern)
  }
  @inlinable public func temporaryWorkaroundFirstMatch<P>(
    for pattern: P,
    in reversed: ReversedCollection<Substring.UnicodeScalarView>
  ) -> P.Match?
  where P : Pattern, P.Match.Searched == ReversedCollection<Substring.UnicodeScalarView> {
    return reversed.firstMatch(for: pattern)
  }
}
extension Substring.UTF8View: BidirectionalPattern, SearchableBidirectionalCollection {
  @inlinable public func temporaryWorkaroundFirstMatch<P>(
    for pattern: P,
    in subSequence: Substring.UTF8View
  ) -> P.Match?
  where P: Pattern, Substring.UTF8View == P.Match.Searched {
    return subSequence.firstMatch(for: pattern)
  }
  @inlinable public func temporaryWorkaroundFirstMatch<P>(
    for pattern: P,
    in reversed: ReversedCollection<Substring.UTF8View>
  ) -> P.Match?
  where P : Pattern, P.Match.Searched == ReversedCollection<Substring.UTF8View> {
    return reversed.firstMatch(for: pattern)
  }
}
extension Substring.UTF16View: BidirectionalPattern, SearchableBidirectionalCollection {
  @inlinable public func temporaryWorkaroundFirstMatch<P>(
    for pattern: P,
    in subSequence: Substring.UTF16View
  ) -> P.Match?
  where P: Pattern, Substring.UTF16View == P.Match.Searched {
    return subSequence.firstMatch(for: pattern)
  }
  @inlinable public func temporaryWorkaroundFirstMatch<P>(
    for pattern: P,
    in reversed: ReversedCollection<Substring.UTF16View>
  ) -> P.Match?
  where P : Pattern, P.Match.Searched == ReversedCollection<Substring.UTF16View> {
    return reversed.firstMatch(for: pattern)
  }
}

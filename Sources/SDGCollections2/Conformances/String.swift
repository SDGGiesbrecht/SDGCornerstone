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
  // #workaround(Swift 5.6.1, This method is redundant and can be removed when the compiler can handle the default implementation.)
  @inlinable public func lastMatch(for pattern: Self) -> Match? {
    return _lastMatch(for: pattern)
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
  // #workaround(Swift 5.6.1, This method is redundant and can be removed when the compiler can handle the default implementation.)
  @inlinable public func lastMatch(for pattern: Self) -> Match? {
    return _lastMatch(for: pattern)
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
  // #workaround(Swift 5.6.1, This method is redundant and can be removed when the compiler can handle the default implementation.)
  @inlinable public func lastMatch(for pattern: Self) -> Match? {
    return _lastMatch(for: pattern)
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
  // #workaround(Swift 5.6.1, This method is redundant and can be removed when the compiler can handle the default implementation.)
  @inlinable public func lastMatch(for pattern: Self) -> Match? {
    return _lastMatch(for: pattern)
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
  // #workaround(Swift 5.6.1, This method is redundant and can be removed when the compiler can handle the default implementation.)
  @inlinable public func lastMatch(for pattern: Self) -> Match? {
    return _lastMatch(for: pattern)
  }
  // #workaround(Swift 5.6.1, This method is redundant and can be removed when the compiler can handle the default implementation.)
  @inlinable public func hasSuffix(_ pattern: Self) -> Bool {
    return _hasSuffix(pattern)
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
  // #workaround(Swift 5.6.1, This method is redundant and can be removed when the compiler can handle the default implementation.)
  @inlinable public func lastMatch(for pattern: Self) -> Match? {
    return _lastMatch(for: pattern)
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
  // #workaround(Swift 5.6.1, This method is redundant and can be removed when the compiler can handle the default implementation.)
  @inlinable public func lastMatch(for pattern: Self) -> Match? {
    return _lastMatch(for: pattern)
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
  // #workaround(Swift 5.6.1, This method is redundant and can be removed when the compiler can handle the default implementation.)
  @inlinable public func lastMatch(for pattern: Self) -> Match? {
    return _lastMatch(for: pattern)
  }
}

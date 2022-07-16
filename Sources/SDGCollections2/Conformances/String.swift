/*
 String.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension String: SearchableBidirectionalCollection {
  @inlinable public func windowsCompatibleFirstMatch<P>(
    for pattern: P,
    in subSequence: Substring
  ) -> P.Match?
  where P: Pattern, Substring == P.Match.Searched {
    return subSequence.firstMatch(for: pattern)
  }
}
extension String.UnicodeScalarView: SearchableBidirectionalCollection {
  @inlinable public func windowsCompatibleFirstMatch<P>(
    for pattern: P,
    in subSequence: Substring.UnicodeScalarView
  ) -> P.Match?
  where P: Pattern, Substring.UnicodeScalarView == P.Match.Searched {
    return subSequence.firstMatch(for: pattern)
  }
}
extension String.UTF8View: SearchableBidirectionalCollection {
  @inlinable public func windowsCompatibleFirstMatch<P>(
    for pattern: P,
    in subSequence: Substring.UTF8View
  ) -> P.Match?
  where P: Pattern, Substring.UTF8View == P.Match.Searched {
    return subSequence.firstMatch(for: pattern)
  }
}
extension String.UTF16View: SearchableBidirectionalCollection {
  @inlinable public func windowsCompatibleFirstMatch<P>(
    for pattern: P,
    in subSequence: Substring.UTF16View
  ) -> P.Match?
  where P: Pattern, Substring.UTF16View == P.Match.Searched {
    return subSequence.firstMatch(for: pattern)
  }
}
extension Substring: SearchableBidirectionalCollection {
  @inlinable public func windowsCompatibleFirstMatch<P>(
    for pattern: P,
    in subSequence: Substring
  ) -> P.Match?
  where P: Pattern, Substring == P.Match.Searched {
    return subSequence.firstMatch(for: pattern)
  }
}
extension Substring.UnicodeScalarView: SearchableBidirectionalCollection {
  @inlinable public func windowsCompatibleFirstMatch<P>(
    for pattern: P,
    in subSequence: Substring.UnicodeScalarView
  ) -> P.Match?
  where P: Pattern, Substring.UnicodeScalarView == P.Match.Searched {
    return subSequence.firstMatch(for: pattern)
  }
}
extension Substring.UTF8View: SearchableBidirectionalCollection {
  @inlinable public func windowsCompatibleFirstMatch<P>(
    for pattern: P,
    in subSequence: Substring.UTF8View
  ) -> P.Match?
  where P: Pattern, Substring.UTF8View == P.Match.Searched {
    return subSequence.firstMatch(for: pattern)
  }
}
extension Substring.UTF16View: SearchableBidirectionalCollection {
  @inlinable public func windowsCompatibleFirstMatch<P>(
    for pattern: P,
    in subSequence: Substring.UTF16View
  ) -> P.Match?
  where P: Pattern, Substring.UTF16View == P.Match.Searched {
    return subSequence.firstMatch(for: pattern)
  }
}

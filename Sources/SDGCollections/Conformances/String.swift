/*
 String.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension String: SearchableBidirectionalCollection {
  // #workaround(Swift 5.6.1, This method is redundant and can be removed when the compiler can handle the default implementation.)
  @inlinable public func lastMatch(for pattern: Self) -> Match? {
    return _lastMatch(for: pattern)
  }
}
extension String.UnicodeScalarView: SearchableBidirectionalCollection {
  // #workaround(Swift 5.6.1, This method is redundant and can be removed when the compiler can handle the default implementation.)
  @inlinable public func lastMatch(for pattern: Self) -> Match? {
    return _lastMatch(for: pattern)
  }
}
extension String.UTF8View: SearchableBidirectionalCollection {
  // #workaround(Swift 5.6.1, This method is redundant and can be removed when the compiler can handle the default implementation.)
  @inlinable public func lastMatch(for pattern: Self) -> Match? {
    return _lastMatch(for: pattern)
  }
}
extension String.UTF16View: SearchableBidirectionalCollection {
  // #workaround(Swift 5.6.1, This method is redundant and can be removed when the compiler can handle the default implementation.)
  @inlinable public func lastMatch(for pattern: Self) -> Match? {
    return _lastMatch(for: pattern)
  }
}
extension Substring: SearchableBidirectionalCollection {
  // #workaround(Swift 5.6.1, This method is redundant and can be removed when the compiler can handle the default implementation.)
  @inlinable public func lastMatch(for pattern: Self) -> Match? {
    return _lastMatch(for: pattern)
  }
  // #workaround(Swift 5.6.1, This method is redundant and can be removed when the compiler can handle the default implementation.)
  @inlinable public func hasSuffix(_ pattern: Self) -> Bool {
    return _hasSuffix(pattern)
  }
}
extension Substring.UnicodeScalarView: SearchableBidirectionalCollection {
  // #workaround(Swift 5.6.1, This method is redundant and can be removed when the compiler can handle the default implementation.)
  @inlinable public func lastMatch(for pattern: Self) -> Match? {
    return _lastMatch(for: pattern)
  }
}
extension Substring.UTF8View: SearchableBidirectionalCollection {
  // #workaround(Swift 5.6.1, This method is redundant and can be removed when the compiler can handle the default implementation.)
  @inlinable public func lastMatch(for pattern: Self) -> Match? {
    return _lastMatch(for: pattern)
  }
}
extension Substring.UTF16View: SearchableBidirectionalCollection {
  // #workaround(Swift 5.6.1, This method is redundant and can be removed when the compiler can handle the default implementation.)
  @inlinable public func lastMatch(for pattern: Self) -> Match? {
    return _lastMatch(for: pattern)
  }
}

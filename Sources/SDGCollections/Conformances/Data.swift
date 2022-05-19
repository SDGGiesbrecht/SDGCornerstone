/*
 Data.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic

extension Data: SearchableBidirectionalCollection {

  // #workaround(Swift 5.6.1, Redundant, but evades compiler bug in release configuration.)
  @inlinable public func lastMatch(
    for pattern: Self
  ) -> PatternMatch<Self>? {  // @exempt(from: tests)
    let backwards: ReversedCollection<Self> = reversed()
    guard let range = backwards.firstMatch(for: pattern.reversed())?.range else {
      return nil
    }
    return PatternMatch(range: forward(range), in: self)
  }

  // #workaround(Swift 5.6.1, Redundant, but evades compiler bug in release configuration.)
  @inlinable public func hasSuffix(_ pattern: Self) -> Bool {  // @exempt(from: tests)
    let backwards: ReversedCollection<Self> = reversed()
    return pattern.reversed().primaryMatch(in: backwards, at: backwards.startIndex) ≠ nil
  }
}

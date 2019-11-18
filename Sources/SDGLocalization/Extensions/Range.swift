/*
 Range.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections
import SDGText

extension RangeFamily {

  /// Returns the range in inequality notation. (eg. “1 ≤ x ≤ 10”)
  ///
  /// - Parameters:
  ///     - describe: A closure which provides the description of an individual bound.
  ///     - bound: The bound to describe.
  public func inInequalityNotation(_ describe: (_ bound: Bound) -> StrictString) -> StrictString {
    return
      "\(describe(lowerBound)) ≤ x \(Self.hasClosedUpperBound ? "≤" : "<") \(describe(upperBound))"
  }
}

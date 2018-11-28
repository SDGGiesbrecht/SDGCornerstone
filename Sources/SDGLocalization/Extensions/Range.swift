/*
 Range.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

extension RangeFamily {

    /// Returns the range in inequality notation. (eg. “1 ≤ x ≤ 10”)
    @inlinable public func inInequalityNotation(_ describe: (_ bound: Bound) -> StrictString) -> StrictString {
        return StrictString("\(describe(lowerBound)) ≤ x \(Self.hasClosedUpperBound ? "≤" : "<") \(describe(upperBound))")
    }
}

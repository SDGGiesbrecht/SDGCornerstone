/*
 StrictInterpolationExampleTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone
import SDGXCTestUtilities

class StrictInterpolationExampleTests : TestCase {

    func testStrictInterpolation() {
        func getError() -> Any {
            return ""
        }
        // @example(strictInterpolation)
        var strict: StrictString = ""

        // String‐like types can be interpolated directly:
        let string: String = "Hello, world!"
        let character: Unicode.Scalar = "?"
        strict = "\(string) ...\(character)"

        // Most other types must be explicitly converted to some predictable text representation:
        let number = Int.random(in: 0 ... 1000)
        strict = "“\(number.inRomanNumerals())” means the same as “\(number.inDigits())”."

        // The Swift compiler’s own description of any value can still be requested explicitly:
        let something: Any = getError()
        strict = "Error: \(arbitraryDescriptionOf: something)"
        // @endExample
        _ = strict
    }
}

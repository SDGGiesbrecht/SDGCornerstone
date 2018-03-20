/*
 RandomizableNumber.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Tests a type’s conformance to RandomizableNumber.
@_inlineable public func testRandomizableNumberConformance<T>(of type: T.Type, file: StaticString = #file, line: UInt = #line) where T : RandomizableNumber {

    let range: ClosedRange<T> = 0 ... 10

    for _ in 1 ... 10 {
        let random = T(randomInRange: range)
        test(range.contains(random), "\(random) ∉ \(range)")
    }
}

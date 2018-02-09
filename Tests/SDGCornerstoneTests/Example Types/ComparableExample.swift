/*
 ComparableExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

struct ComparableExample : Comparable {
    var value: Int

    // Comparable

    static func < (precedingValue: ComparableExample, followingValue: ComparableExample) -> Bool {
        return precedingValue.value < followingValue.value
    }

    // Equatable

    static func == (precedingValue: ComparableExample, followingValue: ComparableExample) -> Bool {
        return precedingValue.value == followingValue.value
    }
}

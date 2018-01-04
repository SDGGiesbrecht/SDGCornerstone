/*
 NegatableExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone

struct NegatableExample : Negatable {

    var value: Int

    init(_ value: Int) {
        self.value = value
    }

    // Addable

    static func += (lhs: inout NegatableExample, rhs: NegatableExample) {
        lhs.value += rhs.value
    }

    // AdditiveArithmetic

    static var additiveIdentity: NegatableExample {
        return NegatableExample(0)
    }

    // Equatable

    static func == (lhs: NegatableExample, rhs: NegatableExample) -> Bool {
        return lhs.value == rhs.value
    }

    // Hashable

    var hashValue: Int {
        return value
    }

    // Subtractable

    static func −= (lhs: inout NegatableExample, rhs: NegatableExample) {
        lhs.value −= rhs.value
    }
}

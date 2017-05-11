/*
 RangeReplaceableCollectionExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone

struct RangeReplaceableCollectionExample : ExpressibleByArrayLiteral, RangeReplaceableCollection {

    var value: [Int] = []

    init(_ value: [Int]) {
        self.value = value
    }

    // Collection

    var startIndex: Array<Int>.Index {
        return value.startIndex
    }

    var endIndex: Array<Int>.Index {
        return value.endIndex
    }

    subscript(position: Array<Int>.Index) -> Int {
        return value[position]
    }

    func index(after i: Array<Int>.Index) -> Array<Int>.Index {
        return value.index(after: i)
    }

    // RangeReplaceableCollection

    init() {}

    mutating func replaceSubrange<C : Collection>(_ subrange: Range<Array<Int>.Index>, with newElements: C) where C.Iterator.Element == Int {
        value.replaceSubrange(subrange, with: newElements)
    }
}

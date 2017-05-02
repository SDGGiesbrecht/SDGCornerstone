/*
 MutableSetExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone

struct MutableSetExample : FiniteSet, MutableSet {

    var value: Set<Int> = []

    init(_ value: Set<Int>) {
        self.value = value
    }

    // Collection

    var startIndex: Set<Int>.Index {
        return value.startIndex
    }

    var endIndex: Set<Int>.Index {
        return value.endIndex
    }

    subscript(position: Set<Int>.Index) -> Int {
        return value[position]
    }

    func index(after i: Set<Int>.Index) -> Set<Int>.Index {
        return value.index(after: i)
    }

    var isEmpty: Bool {
        return value.isEmpty
    }

    // ComparableSet

    static func ⊆ (lhs: MutableSetExample, rhs: MutableSetExample) -> Bool {
        return lhs.value ⊆ rhs.value
    }

    func overlaps(_ other: MutableSetExample) -> Bool {
        return value.overlaps(other.value)
    }

    // MutableSet

    init() {}

    @discardableResult mutating func insert(_ newMember: Int) -> (inserted: Bool, memberAfterInsert: Int) {
        return value.insert(newMember)
    }

    @discardableResult mutating func remove(_ member: Int) -> Int? {
        return value.remove(member)
    }

    @discardableResult mutating func update(with newMember: Element) -> Element? {
        return value.update(with: newMember)
    }

    // SetDefinition

    typealias Element = Int

    static func ∋ (lhs: MutableSetExample, rhs: Int) -> Bool {
        return lhs.value ∋ rhs
    }
}

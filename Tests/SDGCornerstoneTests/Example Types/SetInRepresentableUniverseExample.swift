/*
 SetInRepresentableUniverseExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone

struct SetInRepresentableUniverseExample : MutableSet, SetInRepresentableUniverse {

    var set: Set<Int> = []
    var isInverse: Bool = false

    init(_ value: Set<Int>) {
        self.set = value
    }

    // ComparableSet

    static func ⊆ (lhs: SetInRepresentableUniverseExample, rhs: SetInRepresentableUniverseExample) -> Bool {
        if lhs.isInverse {
            if rhs.isInverse {
                return rhs.set ⊆ lhs.set
            } else {
                return false
            }
        } else {
            if rhs.isInverse {
                return false
            } else {
                return lhs.set ⊆ rhs.set
            }
        }
    }

    func overlaps(_ other: SetInRepresentableUniverseExample) -> Bool {
        if isInverse {
            if other.isInverse {
                return true
            } else {
                return set ⊉ other.set
            }
        } else {
            if other.isInverse {
                return set ⊈ other.set
            } else {
                return set.overlaps(other.set)
            }
        }
    }

    // MutableSet

    init() {}

    @discardableResult mutating func insert(_ newMember: Int) -> (inserted: Bool, memberAfterInsert: Int) {
        if isInverse {
            let result = set.remove(newMember)
            if result ≠ nil {
                return (true, newMember)
            } else {
                return (false, newMember)
            }
        } else {
            return set.insert(newMember)
        }
    }

    @discardableResult mutating func remove(_ member: Int) -> Int? {
        if isInverse {
            let result = set.insert(member)
            if result.inserted {
                return result.memberAfterInsert
            } else {
                return nil
            }
        } else {
            return set.remove(member)
        }
    }

    @discardableResult mutating func update(with newMember: Int) -> Int? {
        if isInverse {
            return set.remove(newMember)
        } else {
            return set.update(with: newMember)
        }
    }

    static func ∩= (lhs: inout SetInRepresentableUniverseExample, rhs: SetInRepresentableUniverseExample) {
        if lhs.isInverse {
            if rhs.isInverse {
                lhs.set ∪= rhs.set
            } else {
                lhs.set = rhs.set ∖ lhs.set
            }
        } else {
            if rhs.isInverse {
                lhs.set ∖= lhs.set
            } else {
                lhs.set ∩= rhs.set
            }
        }
    }

    static func ∪= (lhs: inout SetInRepresentableUniverseExample, rhs: SetInRepresentableUniverseExample) {
        if lhs.isInverse {
            if rhs.isInverse {
                lhs.set ∩= rhs.set
            } else {
                lhs.set ∖= lhs.set
            }
        } else {
            if rhs.isInverse {
                lhs.set = rhs.set ∖ lhs.set
            } else {
                lhs.set ∪= rhs.set
            }
        }
    }

    static func ∖= (lhs: inout SetInRepresentableUniverseExample, rhs: SetInRepresentableUniverseExample) {
        if lhs.isInverse {
            if rhs.isInverse {
                lhs.set = rhs.set ∖ lhs.set
                lhs.isInverse¬=
            } else {
                lhs.set ∪= rhs.set
            }
        } else {
            if rhs.isInverse {
                lhs.set ∩= rhs.set
            } else {
                lhs.set ∖= rhs.set
            }
        }
    }

    // SetDefinition

    typealias Element = Int

    static func ∋ (lhs: SetInRepresentableUniverseExample, rhs: Int) -> Bool {
        if lhs.isInverse {
            return lhs.set′ ∋ rhs
        } else {
            return lhs.set ∋ rhs
        }
    }

    // SetInRepresentableUniverse

    static let universe: SetInRepresentableUniverseExample = {
        var result = SetInRepresentableUniverseExample()
        result.isInverse = true
        return result
    }()
}

/*
 SetInRepresentableUniverseExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

    static func ⊆ (precedingValue: SetInRepresentableUniverseExample, followingValue: SetInRepresentableUniverseExample) -> Bool {
        if precedingValue.isInverse {
            if followingValue.isInverse {
                return followingValue.set ⊆ precedingValue.set
            } else {
                return false
            }
        } else {
            if followingValue.isInverse {
                return false
            } else {
                return precedingValue.set ⊆ followingValue.set
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

    static func ∩= (precedingValue: inout SetInRepresentableUniverseExample, followingValue: SetInRepresentableUniverseExample) {
        if precedingValue.isInverse {
            if followingValue.isInverse {
                precedingValue.set ∪= followingValue.set
            } else {
                precedingValue.set = followingValue.set ∖ precedingValue.set
            }
        } else {
            if followingValue.isInverse {
                precedingValue.set ∖= precedingValue.set
            } else {
                precedingValue.set ∩= followingValue.set
            }
        }
    }

    static func ∪= (precedingValue: inout SetInRepresentableUniverseExample, followingValue: SetInRepresentableUniverseExample) {
        if precedingValue.isInverse {
            if followingValue.isInverse {
                precedingValue.set ∩= followingValue.set
            } else {
                precedingValue.set ∖= precedingValue.set
            }
        } else {
            if followingValue.isInverse {
                precedingValue.set = followingValue.set ∖ precedingValue.set
            } else {
                precedingValue.set ∪= followingValue.set
            }
        }
    }

    static func ∖= (precedingValue: inout SetInRepresentableUniverseExample, followingValue: SetInRepresentableUniverseExample) {
        if precedingValue.isInverse {
            if followingValue.isInverse {
                precedingValue.set = followingValue.set ∖ precedingValue.set
                precedingValue.isInverse¬=
            } else {
                precedingValue.set ∪= followingValue.set
            }
        } else {
            if followingValue.isInverse {
                precedingValue.set ∩= followingValue.set
            } else {
                precedingValue.set ∖= followingValue.set
            }
        }
    }

    // SetDefinition

    typealias Element = Int

    static func ∋ (precedingValue: SetInRepresentableUniverseExample, followingValue: Int) -> Bool {
        if precedingValue.isInverse {
            return precedingValue.set′ ∋ followingValue
        } else {
            return precedingValue.set ∋ followingValue
        }
    }

    // SetInRepresentableUniverse

    static let universe: SetInRepresentableUniverseExample = {
        var result = SetInRepresentableUniverseExample()
        result.isInverse = true
        return result
    }()
}

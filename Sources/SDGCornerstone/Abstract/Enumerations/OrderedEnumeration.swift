/*
 OrderedEnumeration.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An enumeration whose cases can be iterated over.
///
/// Conformance Requirements:
///
/// - `IterableEnumeration`
public protocol OrderedEnumeration : Comparable, IterableEnumeration {

    // [_Define Documentation: SDGCornerstone.OrderedEnumeration.successor()_]
    /// Returns the next case or `nil` if there are no later cases.
    func successor() -> Self?

    // [_Define Documentation: SDGCornerstone.OrderedEnumeration.predecessor()_]
    /// Returns the previous case or `nil` if there are no earlier cases.
    func predecessor() -> Self?

    // [_Define Documentation: SDGCornerstone.OrderedEnumeration.cyclicSuccessor()_]
    /// Returns the next case, wrapping around to the first case if necessary.
    func cyclicSuccessor() -> Self

    // [_Define Documentation: SDGCornerstone.OrderedEnumeration.cyclicPredecessor()_]
    /// Returns the previous case, wrapping around to the last case if necessary.
    func cyclicPredecessor() -> Self
}

extension OrderedEnumeration where RawValue.Vector : IntegerType {
    // MARK: - where RawValue.Vector : IntegerType

    // [_Inherit Documentation: SDGCornerstone.OrderedEnumeration.successor()_]
    /// Returns the next case or `nil` if there are no later cases.
    public func successor() -> Self? {
        return successorAsIterableEnumeration()
    }

    // [_Inherit Documentation: SDGCornerstone.OrderedEnumeration.predecessor()_]
    /// Returns the previous case or `nil` if there are no earlier cases.
    public func predecessor() -> Self? {
        return Self(rawValue: rawValue.predecessor())
    }

    // [_Inherit Documentation: SDGCornerstone.OrderedEnumeration.cyclicSuccessor()_]
    /// Returns the next case, wrapping around to the first case if necessary.
    func cyclicSuccessor() -> Self {
        if let next = successor() {
            return next
        } else {
            guard let next = Self.first else {
                preconditionFailure("\(Self.self) has no first case.")
            }
            return next
        }
    }

    // [_Inherit Documentation: SDGCornerstone.OrderedEnumeration.cyclicPredecessor()_]
    /// Returns the previous case, wrapping around to the last case if necessary.
    func cyclicPredecessor() -> Self {
        if let previous = predecessor() {
            return previous
        } else {
            guard let previous = Self.cases.last else {
                preconditionFailure("\(Self.self) has no last case.")
            }
            return previous
        }
    }
}

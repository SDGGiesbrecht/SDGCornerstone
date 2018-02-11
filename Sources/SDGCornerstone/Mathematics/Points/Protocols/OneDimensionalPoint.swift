/*
 OneDimensionalPoint.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematicsCore

extension OneDimensionalPoint where Vector : IntegerProtocol {
    // MARK: - where Vector : IntegerProtocol

    // [_Define Documentation: SDGCornerstone.OneDimensionalPoint.increment()_]
    /// Advances to the next value.
    public mutating func increment() {
        self += 1
    }

    // [_Define Documentation: SDGCornerstone.OneDimensionalPoint.decrement()_]
    /// Retreats to the previous value.
    public mutating func decrement() {
        self −= 1
    }

    // [_Define Documentation: SDGCornerstone.OneDimensionalPoint.successor()_]
    /// Returns the value which comes immediately after.
    public func successor() -> Self {
        return self + 1
    }

    // [_Define Documentation: SDGCornerstone.OneDimensionalPoint.predecessor()_]
    /// Returns the value which comes immediately before.
    public func predecessor() -> Self {
        return self − 1
    }
}

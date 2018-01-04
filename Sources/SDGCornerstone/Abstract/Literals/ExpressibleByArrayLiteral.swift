/*
 ExpressibleByArrayLiteral.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension ExpressibleByArrayLiteral {

    // [_Define Documentation: SDGCornerstone.ExpressibleByArrayLiteral.init(arrayLiteral:)_]
    /// Creates an instance from an array literal.
}

extension ExpressibleByArrayLiteral where Self : RangeReplaceableCollection {
    // MARK: - where Self : RangeReplaceableCollection

    // [_Inherit Documentation: SDGCornerstone.ExpressibleByArrayLiteral.init(arrayLiteral:)_]
    /// Creates an instance from an array literal.
    public init(arrayLiteral: Element...) {
        self.init()
        append(contentsOf: arrayLiteral)
    }
}

/*
 Union.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// A union of two sets.
public struct Union<Base1 : SetDefinition, Base2 : SetDefinition> : SetDefinition where Base1.Element == Base2.Element {

    // MARK: - Initialization

    /// Creates a union from two sets.
    ///
    /// - Parameters:
    ///     - a: A set.
    ///     - b: Another set.
    @_inlineable public init(_ a: Base1, _ b: Base2) {
        self.a = a
        self.b = b
    }

    // MARK: - Properties

    @_versioned internal let a: Base1
    @_versioned internal let b: Base2

    // MARK: - SetDefinition

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.Element_]
    /// The element type.
    public typealias Element = Base1.Element

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∋_]
    /// Returns `true` if `precedingValue` contains `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The set.
    ///     - followingValue: The element to test.
    @_inlineable public static func ∋ (precedingValue: Union, followingValue: Base1.Element) -> Bool {
        return precedingValue.a ∋ followingValue ∨ precedingValue.b ∋ followingValue
    }
}

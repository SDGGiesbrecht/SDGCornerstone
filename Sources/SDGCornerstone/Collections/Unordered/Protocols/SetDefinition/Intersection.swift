/*
 Intersection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An intersection of two sets.
public struct Intersection<Base1 : SetDefinition, Base2 : SetDefinition> : SetDefinition where Base1.Element == Base2.Element {

    // MARK: - Initialization

    /// Creates an intersection from two sets.
    ///
    /// - Parameters:
    ///     - a: A set.
    ///     - b: Another set.
    public init(_ a: Base1, _ b: Base2) {
        self.a = a
        self.b = b
    }

    // MARK: - Properties

    private let a: Base1
    private let b: Base2

    // MARK: - SetDefinition

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.Element_]
    /// The element type.
    public typealias Element = Base1.Element

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∋_]
    /// Returns `true` if `lhs` contains `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set.
    ///     - rhs: The element to test.
    public static func ∋ (lhs: Intersection, rhs: Base1.Element) -> Bool {
        return lhs.a ∋ rhs ∧ lhs.b ∋ rhs
    }
}

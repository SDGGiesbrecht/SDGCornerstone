/*
 RelativeComplement.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A relative complement of one set in another.
public struct RelativeComplement<Minuend : SetDefinition, Subtrahend : SetDefinition> : SetDefinition where Minuend.Element == Subtrahend.Element {

    // MARK: - Initialization

    /// Creates a relative complement from two sets.
    ///
    /// - Parameters:
    ///     - a: A set.
    ///     - b: Another set.
    public init(of subtrahend: Subtrahend, in minuend: Minuend) {
        definition = minuend ∩ subtrahend′
    }

    // MARK: - Properties

    private let definition: Intersection<Minuend, AbsoluteComplement<Subtrahend>>

    // MARK: - SetDefinition

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.Element_]
    /// The element type.
    public typealias Element = Minuend.Element

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∋_]
    /// Returns `true` if `lhs` contains `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set.
    ///     - rhs: The element to test.
    public static func ∋ (lhs: RelativeComplement, rhs: Minuend.Element) -> Bool {
        return lhs.definition ∋ rhs
    }
}

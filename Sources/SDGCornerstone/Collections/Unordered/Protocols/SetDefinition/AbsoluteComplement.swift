/*
 AbsoluteComplement.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An absolute complement of a set.
public struct AbsoluteComplement<Base : SetDefinition> : SetDefinition {

    // MARK: - Initialization

    /// Creates an absolute complement from a set.
    ///
    /// - Parameters:
    ///     - set: A set.
    public init(_ base: Base) {
        self.base = base
    }

    // MARK: - Properties

    private var base: Base

    // MARK: - SetDefinition

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.Element_]
    /// The element type.
    public typealias Element = Base.Element

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∋_]
    /// Returns `true` if `lhs` contains `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set.
    ///     - rhs: The element to test.
    public static func ∋ (lhs: AbsoluteComplement, rhs: Base.Element) -> Bool {
        return lhs.base ∌ rhs
    }
}

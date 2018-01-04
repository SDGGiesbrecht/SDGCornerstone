/*
 IntentionalSet.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A set with an intensional definion.
public struct IntensionalSet<Member> : SetDefinition {

    // MARK: - Initialization

    /// Creates a set with a condition.
    public init(where condition: @escaping (Element) -> Bool) {
        self.condition = condition
    }

    // MARK: - Properties

    private var condition: (Element) -> Bool

    // MARK: - SetDefinition

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.Element_]
    /// The element type.
    public typealias Element = Member

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∋_]
    /// Returns `true` if `lhs` contains `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set.
    ///     - rhs: The element to test.
    public static func ∋ (lhs: IntensionalSet, rhs: Element) -> Bool {
        return lhs.condition(rhs)
    }
}

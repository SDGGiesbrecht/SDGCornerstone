/*
 IntensionalSet.swift

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
    @inlinable public init(where condition: @escaping (Element) -> Bool) {
        self.condition = condition
    }

    // MARK: - Properties

    @usableFromInline internal let condition: (Element) -> Bool

    // MARK: - SetDefinition

    // #documentation(SDGCornerstone.SetDefinition.Element)
    /// The element type.
    public typealias Element = Member

    // #documentation(SDGCornerstone.SetDefinition.∋)
    /// Returns `true` if `precedingValue` contains `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The set.
    ///     - followingValue: The element to test.
    @inlinable public static func ∋ (precedingValue: IntensionalSet, followingValue: Element) -> Bool {
        return precedingValue.condition(followingValue)
    }
}

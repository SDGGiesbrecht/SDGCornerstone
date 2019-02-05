/*
 AbsoluteComplement.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// An absolute complement of a set.
public struct AbsoluteComplement<Base : SetDefinition> : CustomStringConvertible, SetDefinition, TextualPlaygroundDisplay {

    // MARK: - Initialization

    /// Creates an absolute complement from a set.
    ///
    /// - Parameters:
    ///     - base: A set.
    @inlinable public init(_ base: Base) {
        self.base = base
    }

    // MARK: - Properties

    @usableFromInline internal let base: Base

    // MARK: - CustomStringConvertible

    @inlinable public var description: String {
        return "(" + String(describing: base) + ")′"
    }

    // MARK: - SetDefinition

    public typealias Element = Base.Element

    @inlinable public static func ∋ (precedingValue: AbsoluteComplement, followingValue: Base.Element) -> Bool {
        return precedingValue.base ∌ followingValue
    }
}

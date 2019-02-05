/*
 LiteralPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A pattern that matches an exact subsequence.
public final class LiteralPattern<Element : Equatable> : Pattern<Element>, CustomStringConvertible, ExpressibleByArrayLiteral, TextualPlaygroundDisplay {

    // MARK: - Initialization

    /// Creates a literal pattern from a collection.
    ///
    /// - Parameters:
    ///     - literal: The collection to match as a literal.
    @inlinable public init<C : SearchableCollection>(_ literal: C) where C.Element == Element {
        self.literal = Array(literal)
    }

    // MARK: - Properties

    @usableFromInline internal let literal: [Element]

    // MARK: - ExpressibleByArrayLiteral

    @inlinable public convenience init(arrayLiteral: Element...) {
        self.init(arrayLiteral)
    }

    // MARK: - Pattern

    @inlinable public override func matches<C : SearchableCollection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Element {
        if let match = primaryMatch(in: collection, at: location) {
            return [match]
        } else {
            return []
        }
    }

    @inlinable public override func primaryMatch<C : SearchableCollection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Element == Element {
        return literal.primaryMatch(in: collection, at: location)
    }

    @inlinable public override func reversed() -> LiteralPattern<Element> {
        return LiteralPattern(literal.reversed())
    }

    // MARK: - CustomStringConvertible

    @inlinable public var description: String {
        return String(describing: literal)
    }
}

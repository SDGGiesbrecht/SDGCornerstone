/*
 LiteralPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

    // #documentation(SDGCornerstone.ExpressibleByArrayLiteral.init(arrayLiteral:))
    /// Creates an instance from an array literal.
    @inlinable public convenience init(arrayLiteral: Element...) {
        self.init(arrayLiteral)
    }

    // MARK: - Pattern

    // #documentation(SDGCornerstone.Pattern.match(in:at:))
    /// Returns the ranges of possible matches beginning at the specified index in the collection.
    ///
    /// The ranges are sorted in order of preference. Ranges can be tried one after another down through the list in the event that some should be disqualified for some external reason, such as being part of a larger composite pattern.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    @inlinable public override func matches<C : SearchableCollection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Element {
        if let match = primaryMatch(in: collection, at: location) {
            return [match]
        } else {
            return []
        }
    }

    // #documentation(SDGCornerstone.Pattern.primaryMatch(in:at:))
    /// Returns the primary match beginning at the specified index in the collection.
    ///
    /// This may be optimized, but the result must be the same as `matches(in: collection at: location).first`.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    @inlinable public override func primaryMatch<C : SearchableCollection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Element == Element {
        return literal.primaryMatch(in: collection, at: location)
    }

    // #documentation(SDGCornerstone.Pattern.reverse())
    /// A pattern that checks for the reverse pattern.
    ///
    /// This is suitable for performing backward searches by applying it to the reversed collection.
    @inlinable public override func reversed() -> LiteralPattern<Element> {
        return LiteralPattern(literal.reversed())
    }

    // MARK: - CustomStringConvertible

    // #documentation(SDGCornerstone.CustomStringConvertible.description)
    /// A textual representation of the instance.
    @inlinable public var description: String {
        return String(describing: literal)
    }
}

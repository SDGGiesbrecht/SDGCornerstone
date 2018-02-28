/*
 LiteralPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogicCore

/// A pattern that matches an exact subsequence.
public final class LiteralPattern<Element : Equatable> : Pattern<Element>, ExpressibleByArrayLiteral {

    // MARK: - Initialization

    /// Creates a literal pattern from a collection.
    ///
    /// - Parameters:
    ///     - literal: The collection to match as a literal.
    @_inlineable public init<C : Collection>(_ literal: C) where C.Element == Element {
        self.literal = Array(literal)
    }

    // MARK: - Properties

    @_versioned internal let literal: [Element]

    // MARK: - ExpressibleByArrayLiteral

    // [_Inherit Documentation: SDGCornerstone.ExpressibleByArrayLiteral.init(arrayLiteral:)_]
    /// Creates an instance from an array literal.
    @_inlineable public convenience init(arrayLiteral: Element...) {
        self.init(arrayLiteral)
    }

    // MARK: - Pattern

    // [_Inherit Documentation: SDGCornerstone.Pattern.match(in:at:)_]
    /// Returns the ranges of possible matches beginning at the specified index in the collection.
    ///
    /// The ranges are sorted in order of preference. Ranges can be tried one after another down through the list in the event that some should be disqualified for some external reason, such as being part of a larger composite pattern.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    @_inlineable public override func matches<C : Collection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Element {
        if let match = primaryMatch(in: collection, at: location) {
            return [match]
        } else {
            return []
        }
    }

    // [_Inherit Documentation: SDGCornerstone.Pattern.primaryMatch(in:at:)_]
    /// Returns the primary match beginning at the specified index in the collection.
    ///
    /// This may be optimized, but the result must be the same as `matches(in: collection at: location).first`.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    @_inlineable public override func primaryMatch<C : Collection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Element == Element {
        return literal.primaryMatch(in: collection, at: location)
    }

    // [_Inherit Documentation: SDGCornerstone.Pattern.reverse()_]
    /// A pattern that checks for the reverse pattern.
    ///
    /// This is suitable for performing backward searches by applying it to the reversed collection.
    @_inlineable public override func reversed() -> Pattern<Element> {
        return LiteralPattern(literal.reversed())
    }
}

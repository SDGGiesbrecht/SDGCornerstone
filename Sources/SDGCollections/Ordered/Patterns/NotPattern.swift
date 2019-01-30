/*
 NotPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A pattern that matches if the underlying pattern does not.
public final class NotPattern<Element : Equatable> : Pattern<Element>, CustomStringConvertible, TextualPlaygroundDisplay {

    // MARK: - Initialization

    @inlinable internal init(abstractBasePattern base: Pattern<Element>) {
        self.base = base
    }

    // @documentation(SDGCornerstone.Not.init(_:))
    /// Creates a repetition pattern from another pattern.
    ///
    /// - Parameters:
    ///     - pattern: The underlying pattern to negate.
    @inlinable public convenience init(_ pattern: Pattern<Element>) {
        self.init(abstractBasePattern: pattern)
    }

    // #documentation(SDGCornerstone.Not.init(_:))
    /// Creates a repetition pattern from another pattern.
    ///
    /// - Parameters:
    ///     - pattern: The underlying pattern to negate.
    @inlinable public convenience init(_ pattern: LiteralPattern<Element>) {
        self.init(abstractBasePattern: pattern)
    }

    // #documentation(SDGCornerstone.Not.init(_:))
    /// Creates a repetition pattern from another pattern.
    ///
    /// - Parameters:
    ///     - pattern: The underlying pattern to negate.
    @inlinable public convenience init(_ pattern: CompositePattern<Element>) {
        self.init(abstractBasePattern: pattern)
    }

    // MARK: - Properties

    @usableFromInline internal var base: Pattern<Element>

    // MARK: - Pattern

    // #documentation(SDGCornerstone.PatternProtocol.matches(in:at:))
    /// Returns the ranges of possible matches beginning at the specified index in the collection.
    ///
    /// The ranges are sorted in order of preference. Ranges can be tried one after another down through the list in the event that some should be disqualified for some external reason, such as being part of a larger composite pattern.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    @inlinable public override func matches<C : SearchableCollection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Element {

        if base.primaryMatch(in: collection, at: location) == nil {
            return [(location ... location).relative(to: collection)]
        } else {
            return []
        }
    }

    // #documentation(SDGCornerstone.PatternProtocol.primaryMatch(in:at:))
    /// Returns the primary match beginning at the specified index in the collection.
    ///
    /// This may be optimized, but the result must be the same as `matches(in: collection at: location).first`.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    @inlinable public override func primaryMatch<C : SearchableCollection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Element == Element {

        if base.primaryMatch(in: collection, at: location) == nil {
            return (location ... location).relative(to: collection)
        } else {
            return nil
        }
    }

    // #documentation(SDGCornerstone.PatternProtocol.reversed())
    /// Retruns a pattern that checks for the reverse pattern.
    ///
    /// This is suitable for performing backward searches by applying it to the reversed collection.
    @inlinable public override func reversed() -> NotPattern<Element> {
        return NotPattern(base.reversed())
    }

    // MARK: - CustomStringConvertible

    // #documentation(SDGCornerstone.CustomStringConvertible.description)
    /// A textual representation of the instance.
    @inlinable public var description: String {
        return "¬(" + String(describing: base) + ")"
    }
}

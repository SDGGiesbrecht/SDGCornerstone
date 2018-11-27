/*
 AlternativePatterns.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A pattern that matches against several alternative patterns.
///
/// The order of the alternatives is significant. If multiple alternatives match, preference will be given to one higher in the list.
public final class AlternativePatterns<Element : Equatable> : Pattern<Element>, CustomStringConvertible, TextualPlaygroundDisplay {

    // MARK: - Initialization

    /// Creates a set of alternative patterns.
    ///
    /// - Parameters:
    ///     - alternatives: The alternative patterns.
    @inlinable public init(_ alternatives: [Pattern<Element>]) {
        self.alternatives = alternatives
    }

    /// Creates a set of alternative elements.
    ///
    /// - Parameters:
    ///     - elements: The alternative element.
    @inlinable public init(_ elements: [Element]) {
        self.alternatives = elements.map { LiteralPattern([$0]) }
    }

    // MARK: - Properties

    @usableFromInline internal var alternatives: [Pattern<Element>]

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

        var results: [Range<C.Index>] = []
        for alternative in alternatives {
            results.append(contentsOf: alternative.matches(in: collection, at: location))
        }
        return results
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
        for alternative in alternatives {
            if let match = alternative.primaryMatch(in: collection, at: location) {
                return match
            }
        }
        return nil
    }

    // #documentation(SDGCornerstone.Pattern.reverse())
    /// A pattern that checks for the reverse pattern.
    ///
    /// This is suitable for performing backward searches by applying it to the reversed collection.
    @inlinable public override func reversed() -> AlternativePatterns<Element> {
        return AlternativePatterns(alternatives.map({ $0.reversed() }))
    }

    // MARK: - CustomStringConvertible

    // #documentation(SDGCornerstone.CustomStringConvertible.description)
    /// A textual representation of the instance.
    @inlinable public var description: String {
        let entries = alternatives.map { "(" + String(describing: $0) + ")" }
        return entries.joined(separator: " ∨ ")
    }
}

/*
 CompositePattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A pattern that matches against several component patterns contiguously.
public final class CompositePattern<Element : Equatable> : Pattern<Element>, CustomStringConvertible, ExpressibleByArrayLiteral, TextualPlaygroundDisplay {

    // MARK: - Initialization

    /// Creates a repetition pattern from several component patterns.
    ///
    /// - Parameters:
    ///     - components: The component patterns.
    @_inlineable public  init(_ components: [Pattern<Element>]) {
        self.components = components
    }

    // MARK: - Properties

    @_versioned internal var components: [Pattern<Element>]

    // MARK: - ExpressibleByArrayLiteral

    // #documentation(SDGCornerstone.ExpressibleByArrayLiteral.init(arrayLiteral:))
    /// Creates an instance from an array literal.
    @_inlineable public convenience init(arrayLiteral: Pattern<Element>...) {
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
    @_inlineable public override func matches<C : SearchableCollection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Element {

        var endIndices: [C.Index] = [location]
        for component in components {
            if endIndices.isEmpty {
                // No matches
                return []
            } else {
                // Continue
                endIndices = endIndices.map({ component.matches(in: collection, at: $0) }).joined().map({ $0.upperBound })
            }
        }

        return endIndices.map { location ..< $0 }
    }

    // #documentation(SDGCornerstone.Pattern.primaryMatch(in:at:))
    /// Returns the primary match beginning at the specified index in the collection.
    ///
    /// This may be optimized, but the result must be the same as `matches(in: collection at: location).first`.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    @_inlineable public override func primaryMatch<C : SearchableCollection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Element == Element {

        var endIndices: [C.Index] = [location]
        for component in components {
            if endIndices.isEmpty {
                // No matches
                return nil
            } else {
                // Continue
                endIndices = endIndices.map({ component.matches(in: collection, at: $0) }).joined().map({ $0.upperBound })
            }
        }

        return endIndices.first.map { location ..< $0 }
    }

    // #documentation(SDGCornerstone.Pattern.reverse())
    /// A pattern that checks for the reverse pattern.
    ///
    /// This is suitable for performing backward searches by applying it to the reversed collection.
    @_inlineable public override func reversed() -> CompositePattern<Element> {
        return CompositePattern(components.map({ $0.reversed() }).reversed())
    }

    // MARK: - CustomStringConvertible

    // #documentation(SDGCornerstone.CustomStringConvertible.description)
    /// A textual representation of the instance.
    @_inlineable public var description: String {
        let entries = components.map { "(" + String(describing: $0) + ")" }
        return entries.joined(separator: " + ")
    }
}

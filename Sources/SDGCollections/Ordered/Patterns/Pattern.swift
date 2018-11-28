/*
 Pattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A pattern that can be searched for in collections with equatable elements.
///
/// Required Overrides for Subclasses:
///     - `func matches<C : Collection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Element`
///     - `func reversed() -> Pattern<Element>`
open class Pattern<Element : Equatable> : PatternProtocol {

    /// Pattern consumption behaviour.
    public enum Consumption {
        /// Prefers longer matches.
        case greedy
        /// Prefers shorter matches.
        case lazy
    }

    /// This initializer does nothing. It only exists so that subclasses have an available parent initializer they can forward to in order to satisfy the compiler.
    @inlinable public init() { // @exempt(from: tests) False result with Xcode 9.3.

    }

    // @documentation(SDGCornerstone.Pattern.match(in:at:))
    /// Returns the ranges of possible matches beginning at the specified index in the collection.
    ///
    /// The ranges are sorted in order of preference. Ranges can be tried one after another down through the list in the event that some should be disqualified for some external reason, such as being part of a larger composite pattern.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    @inlinable open func matches<C : SearchableCollection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Element {
        _primitiveMethod()
    }

    // @documentation(SDGCornerstone.Pattern.primaryMatch(in:at:))
    /// Returns the primary match beginning at the specified index in the collection.
    ///
    /// This may be optimized, but the result must be the same as `matches(in: collection at: location).first`.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    @inlinable open func primaryMatch<C : SearchableCollection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Element == Element {
        return matches(in: collection, at: location).first
    }

    // @documentation(SDGCornerstone.Pattern.reverse())
    /// A pattern that checks for the reverse pattern.
    ///
    /// This is suitable for performing backward searches by applying it to the reversed collection.
    @inlinable open func reversed() -> Pattern<Element> {
        _primitiveMethod()
    }
}

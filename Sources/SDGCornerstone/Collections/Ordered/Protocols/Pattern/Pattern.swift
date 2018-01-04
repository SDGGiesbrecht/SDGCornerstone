/*
 Pattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A pattern that can be searched for in collections with equatable elements.
///
/// Required Overrides for Subclasses:
///     - `func match<C : Collection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Element == Element`
///     - `func reverse() -> Pattern<Element>`
open class Pattern<Element : Equatable> {

    /// Pattern consumption behaviour.
    public enum Consumption {
        /// Prefers longer matches.
        case greedy
        /// Prefers shorter matches.
        case lazy
    }

    // [_Define Documentation: SDGCornerstone.Pattern.match(in:at:)_]
    /// Returns the ranges of possible matches beginning at the specified index in the collection.
    ///
    /// The ranges are sorted in order of preference. Ranges can be tried one after another down through the list in the event that some should be disqualified for some external reason, such as being part of a larger composite pattern.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    open func matches<C : Collection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Element {
        primitiveMethod()
    }

    // [_Define Documentation: SDGCornerstone.Pattern.primaryMatch(in:at:)_]
    /// Returns the primary match beginning at the specified index in the collection.
    ///
    /// This may be optimized, but the result must be the same as `matches(in: collection at: location).first`.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    open func primaryMatch<C : Collection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Element == Element {
        return matches(in: collection, at: location).first
    }

    // [_Define Documentation: SDGCornerstone.Pattern.reverse()_]
    /// A pattern that checks for the reverse pattern.
    ///
    /// This is suitable for performing backward searches by applying it to the reversed collection.
    open func reversed() -> Pattern<Element> {
        primitiveMethod()
    }
}

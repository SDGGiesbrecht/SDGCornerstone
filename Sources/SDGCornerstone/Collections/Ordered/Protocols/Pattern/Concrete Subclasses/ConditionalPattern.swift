/*
 ConditionalPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A pattern that matches based on a condition.
public final class ConditionalPattern<Element : Equatable> : Pattern<Element> {

    // MARK: - Initialization

    /// Creates an algorithmic pattern based on a condition.
    ///
    /// - Parameters:
    ///     - condition: The condition an element must meet in order to match.
    public init(condition: @escaping (Element) -> Bool) {
        self.condition = condition
    }
    // MARK: - Properties

    private var condition: (Element) -> Bool

    // MARK: - Pattern

    // [_Inherit Documentation: SDGCornerstone.Pattern.match(in:at:)_]
    /// Returns the ranges of possible matches beginning at the specified index in the collection.
    ///
    /// The ranges are sorted in order of preference. Ranges can be tried one after another down through the list in the event that some should be disqualified for some external reason, such as being part of a larger composite pattern.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    public override func matches<C : Collection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Element {

        if condition(collection[location]) {
            return [location ..< collection.index(after: location)]
        } else {
            return []
        }
    }

    // [_Inherit Documentation: SDGCornerstone.Pattern.reverse()_]
    /// A pattern that checks for the reverse pattern.
    ///
    /// This is suitable for performing backward searches by applying it to the reversed collection.
    public override func reversed() -> Pattern<Element> {
        return self
    }
}

/*
 NotPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A pattern that matches if the underlying pattern does not.
public final class NotPattern<Element : Equatable> : Pattern<Element> {

    // MARK: - Initialization

    private init(abstractBasePattern base: Pattern<Element>) {
        self.base = base
    }

    // [_Define Documentation: SDGCornerstone.Not.init(_:)_]
    /// Creates a repetition pattern from another pattern.
    ///
    /// - Parameters:
    ///     - pattern: The underlying pattern to negate.
    public convenience init(_ pattern: Pattern<Element>) {
        self.init(abstractBasePattern: pattern)
    }

    // [_Inherit Documentation: SDGCornerstone.Repetition.init(of:count:consumption)_]
    /// Creates a repetition pattern from another pattern.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to repeat.
    ///     - count: A range representing the allowed number of repetitions.
    ///     - consumption: The desired consumption behaviour.
    public convenience init(_ pattern: LiteralPattern<Element>) {
        self.init(abstractBasePattern: pattern)
    }

    // [_Inherit Documentation: SDGCornerstone.Repetition.init(of:count:consumption)_]
    /// Creates a repetition pattern from another pattern.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to repeat.
    ///     - count: A range representing the allowed number of repetitions.
    ///     - consumption: The desired consumption behaviour.
    public convenience init(_ pattern: CompositePattern<Element>) {
        self.init(abstractBasePattern: pattern)
    }

    // MARK: - Properties

    private var base: Pattern<Element>

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

        if base.primaryMatch(in: collection, at: location) == nil {
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
        return NotPattern(base.reversed())
    }
}

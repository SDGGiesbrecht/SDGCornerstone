/*
 CompositePattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A pattern that matches against several component patterns contiguously.
public final class CompositePattern<Element : Equatable> : Pattern<Element>, ExpressibleByArrayLiteral {

    // MARK: - Initialization

    /// Creates a repetition pattern from several component patterns.
    ///
    /// - Parameters:
    ///     - components: The component patterns.
    public  init(_ components: [Pattern<Element>]) {
        self.components = components
    }

    // MARK: - Properties

    private var components: [Pattern<Element>]

    // MARK: - ExpressibleByArrayLiteral

    // [_Inherit Documentation: SDGCornerstone.ExpressibleByArrayLiteral.init(arrayLiteral:)_]
    /// Creates an instance from an array literal.
    public convenience init(arrayLiteral: Pattern<Element>...) {
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
    public override func matches<C : Collection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Element {

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

    // [_Inherit Documentation: SDGCornerstone.Pattern.reverse()_]
    /// A pattern that checks for the reverse pattern.
    ///
    /// This is suitable for performing backward searches by applying it to the reversed collection.
    public override func reversed() -> Pattern<Element> {
        return CompositePattern(components.map({ $0.reversed() }).reversed())
    }
}

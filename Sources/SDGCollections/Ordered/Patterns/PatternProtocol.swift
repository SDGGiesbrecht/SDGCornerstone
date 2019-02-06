/*
 PatternProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A pattern that can be searched for in collections with equatable elements.
///
/// Instead of conforming to this protocol directly, it is advised to subclass `Pattern`. That way the type will also be nestable with other patterns like `CompositePattern` and `RepetitionPattern`.
public protocol PatternProtocol {

    /// The type of the pattern elements.
    associatedtype Element : Equatable

    /// The type of the reverse pattern.
    associatedtype Reversed : PatternProtocol where Reversed.Element == Self.Element

    /// Returns the ranges of possible matches beginning at the specified index in the collection.
    ///
    /// The ranges are sorted in order of preference. Ranges can be tried one after another down through the list in the event that some should be disqualified for some external reason, such as being part of a larger composite pattern.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    func matches<C : SearchableCollection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Element

    /// Returns the primary match beginning at the specified index in the collection.
    ///
    /// This may be optimized, but the result must be the same as `matches(in: collection at: location).first`.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    func primaryMatch<C : SearchableCollection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Element == Element

    /// Retruns a pattern that checks for the reverse pattern.
    ///
    /// This is suitable for performing backward searches by applying it to the reversed collection.
    func reversed() -> Reversed
}

extension PatternProtocol {

    // MARK: - Switch Expression Pattern

    // #example(1, patternSwitch)
    /// Enables use of any set pattern in switch cases.
    ///
    /// ```swift
    /// switch "This is a string." {
    /// case RepetitionPattern(LiteralPattern(".")):
    ///     XCTFail("This case does not match.")
    /// case CompositePattern([
    ///     RepetitionPattern(NotPattern(LiteralPattern("."))),
    ///     LiteralPattern(".")
    ///     ]):
    ///     print("This case does match.")
    /// default:
    ///     XCTFail("This case is never reached.")
    /// }
    /// ```
    ///
    /// - Parameters:
    ///     - pattern: The pattern to match against.
    ///     - value: The value to check.
    @inlinable public static func ~= <C : SearchableCollection>(pattern: Self, value: C) -> Bool where C.Element == Element {
        return value.isMatch(for: pattern)
    }
}

/*
 PatternProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public protocol PatternProtocol {

    /// The type of the pattern elements.
    associatedtype Element : Equatable

    // @documentation(SDGCornerstone.PatternProtocol.Reversed)
    /// The type of the reverse pattern.
    associatedtype Reversed : PatternProtocol where Reversed.Element == Self.Element

    // @documentation(SDGCornerstone.PatternProtocol.primaryMatch(in:at:))
    /// Returns the primary match beginning at the specified index in the collection.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    func primaryMatch<C : SearchableCollection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Element == Element

    // @documentation(SDGCornerstone.PatternProtocol.reversed())
    /// A pattern that checks for the reverse pattern.
    ///
    /// This is suitable for performing backward searches by applying it to the reversed collection.
    func reversed() -> Reversed
}

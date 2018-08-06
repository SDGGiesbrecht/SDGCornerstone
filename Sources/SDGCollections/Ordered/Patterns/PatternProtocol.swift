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

    // @documentation(SDGCornerstone.PatternProtocol.primaryMatch(in:at:limitedTo:))
    /// Returns the primary match beginning at the specified index in the collection.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    ///     - upperBound: An index beyond which matches are not allowed to extend.
    func primaryMatch<C : SearchableCollection>(in collection: C, at location: C.Index, limitedTo upperBound: C.Index) -> Range<C.Index>? where C.Element == Element
}

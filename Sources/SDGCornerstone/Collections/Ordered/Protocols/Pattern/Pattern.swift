/*
 Pattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A pattern that can be searched for in collections with equatable elements.
public protocol Pattern {

    // [_Define Documentation: SDGCornerstone.Pattern.Element_]
    /// The element type.
    associatedtype Element : Equatable

    // [_Define Documentation: SDGCornerstone.Pattern.match(in:at:)_]
    /// Returns the range of the match beginning at the specified index in the collection, or `nil` if there is no match.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    func match<C : Collection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Iterator.Element == Element
}

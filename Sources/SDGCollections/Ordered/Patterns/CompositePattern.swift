/*
 CompositePattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A pattern that matches against a pair of component patterns contiguously.
public struct CompositePattern<First, Second> : PatternProtocol, CustomStringConvertible, TextualPlaygroundDisplay where First : PatternProtocol, Second : PatternProtocol, First.Element == Second.Element {

    // MARK: - Initialization

    /// Creates a pattern from a pair of component patterns.
    ///
    /// - Parameters:
    ///     - first: The first pattern.
    ///     - second: The second pattern.
    @inlinable public  init(_ first: First, _ second: Second) {
        self.first = first
        self.second = second
    }

    // MARK: - Properties

    @usableFromInline internal var first: First
    @usableFromInline internal var second: Second

    // MARK: - Pattern

    public typealias Element = First.Element

    @inlinable internal func advance<P, C>(
        ends endIndices: inout [C.Index],
        for pattern: P,
        in collection: C)
        where P : PatternProtocol, C : SearchableCollection, C.Element == Element, P.Element == Element {
        endIndices = endIndices
            .lazy.map({ pattern.matches(in: collection, at: $0) })
            .joined()
            .map({ $0.upperBound })
    }

    @inlinable public func matches<C : SearchableCollection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Element {
        var endIndices: [C.Index] = [location]
        advance(ends: &endIndices, for: first, in: collection)
        if endIndices.isEmpty { return [] }
        advance(ends: &endIndices, for: second, in: collection)
        return endIndices.map { location ..< $0 }
    }

    @inlinable public func primaryMatch<C : SearchableCollection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Element == Element {
        var endIndices: [C.Index] = [location]
        advance(ends: &endIndices, for: first, in: collection)
        if endIndices.isEmpty { return nil }
        advance(ends: &endIndices, for: second, in: collection)
        return endIndices.first.map { location ..< $0 }
    }

    @inlinable public func reversed() -> CompositePattern<Second.Reversed, First.Reversed> {
        return CompositePattern<Second.Reversed, First.Reversed>(second.reversed(), first.reversed())
    }

    // MARK: - CustomStringConvertible

    public var description: String {
        return "(\(String(describing: first))) + (\(String(describing: second)))"
    }
}

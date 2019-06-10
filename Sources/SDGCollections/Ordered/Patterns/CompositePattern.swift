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

/// A pattern that matches against several component patterns contiguously.
public final class CompositePattern<Element : Equatable> : Pattern<Element>, CustomStringConvertible, ExpressibleByArrayLiteral, TextualPlaygroundDisplay {

    // MARK: - Initialization

    /// Creates a repetition pattern from several component patterns.
    ///
    /// - Parameters:
    ///     - components: The component patterns.
    @inlinable public  init(_ components: [Pattern<Element>]) {
        self.components = components
    }

    // MARK: - Properties

    @usableFromInline internal var components: [Pattern<Element>]

    // MARK: - ExpressibleByArrayLiteral

    @inlinable public convenience init(arrayLiteral: Pattern<Element>...) {
        self.init(arrayLiteral)
    }

    // MARK: - Pattern

    @inlinable public override func matches<C : SearchableCollection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Element {

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

    @inlinable public override func primaryMatch<C : SearchableCollection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Element == Element {

        var endIndices: [C.Index] = [location]
        for component in components {
            if endIndices.isEmpty {
                // No matches
                return nil
            } else {
                // Continue
                endIndices = endIndices.map({ component.matches(in: collection, at: $0) }).joined().map({ $0.upperBound })
            }
        }

        return endIndices.first.map { location ..< $0 }
    }

    @inlinable public override func reversed() -> CompositePattern<Element> {
        return CompositePattern(components.map({ $0.reversed() }).reversed())
    }

    // MARK: - CustomStringConvertible

    public var description: String {
        let entries = components.map { "(" + String(describing: $0) + ")" }
        return entries.joined(separator: " + ")
    }
}

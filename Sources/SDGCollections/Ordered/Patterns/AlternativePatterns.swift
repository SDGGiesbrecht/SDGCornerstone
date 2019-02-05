/*
 AlternativePatterns.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A pattern that matches against several alternative patterns.
///
/// The order of the alternatives is significant. If multiple alternatives match, preference will be given to one higher in the list.
public final class AlternativePatterns<Element : Equatable> : Pattern<Element>, CustomStringConvertible, TextualPlaygroundDisplay {

    // MARK: - Initialization

    /// Creates a set of alternative patterns.
    ///
    /// - Parameters:
    ///     - alternatives: The alternative patterns.
    @inlinable public init(_ alternatives: [Pattern<Element>]) {
        self.alternatives = alternatives
    }

    /// Creates a set of alternative elements.
    ///
    /// - Parameters:
    ///     - elements: The alternative element.
    @inlinable public init(_ elements: [Element]) {
        self.alternatives = elements.map { LiteralPattern([$0]) }
    }

    // MARK: - Properties

    @usableFromInline internal var alternatives: [Pattern<Element>]

    // MARK: - Pattern

    @inlinable public override func matches<C : SearchableCollection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Element {

        var results: [Range<C.Index>] = []
        for alternative in alternatives {
            results.append(contentsOf: alternative.matches(in: collection, at: location))
        }
        return results
    }

    @inlinable public override func primaryMatch<C : SearchableCollection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Element == Element {
        for alternative in alternatives {
            if let match = alternative.primaryMatch(in: collection, at: location) {
                return match
            }
        }
        return nil
    }

    @inlinable public override func reversed() -> AlternativePatterns<Element> {
        return AlternativePatterns(alternatives.map({ $0.reversed() }))
    }

    // MARK: - CustomStringConvertible

    @inlinable public var description: String {
        let entries = alternatives.map { "(" + String(describing: $0) + ")" }
        return entries.joined(separator: " ∨ ")
    }
}

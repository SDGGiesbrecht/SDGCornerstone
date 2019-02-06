/*
 ConditionalPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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
    @inlinable public init(_ condition: @escaping (Element) -> Bool) {
        self.condition = condition
    }
    // MARK: - Properties

    @usableFromInline internal var condition: (Element) -> Bool

    // MARK: - Pattern

    @inlinable public override func matches<C : SearchableCollection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Element {

        if condition(collection[location]) {
            return [(location ... location).relative(to: collection)]
        } else {
            return []
        }
    }

    @inlinable public override func primaryMatch<C : SearchableCollection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Element == Element {

        if condition(collection[location]) {
            return (location ... location).relative(to: collection)
        } else {
            return nil
        }
    }

    @inlinable public override func reversed() -> ConditionalPattern<Element> {
        return self
    }
}

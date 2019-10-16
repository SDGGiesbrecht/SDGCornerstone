/*
 NotPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

#warning("Rename to negated pattern.")
/// A pattern that matches if the underlying pattern does not.
public struct NotPattern<Base> : CustomStringConvertible, PatternProtocol, TextualPlaygroundDisplay
where Base : PatternProtocol {

    // MARK: - Initialization

    // @documentation(SDGCornerstone.Not.init(_:))
    /// Creates a not pattern from another pattern.
    ///
    /// - Parameters:
    ///     - pattern: The underlying pattern to negate.
    @inlinable public init(_ pattern: Base) {
        self.base = pattern
    }

    // MARK: - Properties

    @usableFromInline internal var base: Base

    // MARK: - Pattern

    public typealias Element = Base.Element

    @inlinable public func matches<C : SearchableCollection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Element {

        if base.primaryMatch(in: collection, at: location) == nil {
            return [(location ... location).relative(to: collection)]
        } else {
            return []
        }
    }

    @inlinable public func primaryMatch<C : SearchableCollection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Element == Element {

        if base.primaryMatch(in: collection, at: location) == nil {
            return (location ... location).relative(to: collection)
        } else {
            return nil
        }
    }

    @inlinable public func reversed() -> NotPattern<Base.Reversed> {
        return NotPattern<Base.Reversed>(base.reversed())
    }

    // MARK: - CustomStringConvertible

    public var description: String {
        return "¬(" + String(describing: base) + ")"
    }
}

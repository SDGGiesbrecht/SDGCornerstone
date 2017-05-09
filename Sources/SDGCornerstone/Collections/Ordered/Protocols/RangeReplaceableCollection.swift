/*
 RangeReplaceableCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension RangeReplaceableCollection {

    /// Adds an element to the beginning of the collection.
    ///
    /// - Parameters:
    ///     - newElement: The element to prepend to the collection
    public mutating func prepend(_ newElement: Self.Iterator.Element) {
        insert(newElement, at: startIndex)
    }

    /// Adds the contents of another collection to the beginning of `self`.
    ///
    /// - Parameters:
    ///     - newElement: The element to prepend to the collection
    public mutating func prepend<C : Collection>(contentsOf newElements: C) where C.Iterator.Element == Self.Iterator.Element {
        insert(contentsOf: newElements, at: startIndex)
    }

    /// Truncates the `self` at `index`.
    public mutating func truncate(at index: Index) {
        removeSubrange(index ..< endIndex)
    }
}

extension RangeReplaceableCollection where Iterator.Element : Equatable {
    // MARK: - where Iterator.Element : Equatable

    // [_Define Documentation: SDGCornerstone.Collection.trucate(before:)_]
    /// Truncates `self` at the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    mutating public func truncate(before pattern: Pattern<Iterator.Element>) {
        if let match = firstMatch(for: pattern) {
            removeSubrange(match.range.lowerBound ..< endIndex)
        }
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucate(before:)_]
    /// Truncates `self` at the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    mutating public func truncate(before pattern: LiteralPattern<Iterator.Element>) {
        truncate(before: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucate(before:)_]
    /// Truncates `self` at the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    mutating public func truncate(before pattern: CompositePattern<Iterator.Element>) {
        truncate(before: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucate(after:)_]
    /// Truncates `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    mutating public func truncate<C : Collection>(before pattern: C) where C.Iterator.Element == Self.Iterator.Element {
        truncate(before: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.trucate(after:)_]
    /// Truncates `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    mutating public func truncate(after pattern: Pattern<Iterator.Element>) {
        if let match = firstMatch(for: pattern) {
            removeSubrange(match.range.upperBound ..< endIndex)
        }
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucate(after:)_]
    /// Truncates `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    mutating public func truncate(after pattern: LiteralPattern<Iterator.Element>) {
        truncate(after: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucate(after:)_]
    /// Truncates `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    mutating public func truncate(after pattern: CompositePattern<Iterator.Element>) {
        truncate(after: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucate(after:)_]
    /// Truncates `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    mutating public func truncate<C : Collection>(after pattern: C) where C.Iterator.Element == Self.Iterator.Element {
        truncate(after: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.drop(upTo:)_]
    /// Drops elements from the beginning of the collection to the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    mutating public func drop(upTo pattern: Pattern<Iterator.Element>) {
        if let match = firstMatch(for: pattern) {
            removeSubrange(startIndex ..< match.range.lowerBound)
        } else {
            self = Self()
        }
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.drop(upTo:)_]
    /// Drops elements from the beginning of the collection to the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    mutating public func drop(upTo pattern: LiteralPattern<Iterator.Element>) {
        drop(upTo: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.drop(upTo:)_]
    /// Drops elements from the beginning of the collection to the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    mutating public func drop(upTo pattern: CompositePattern<Iterator.Element>) {
        drop(upTo: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.drop(upTo:)_]
    /// Drops elements from the beginning of the collection to the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    mutating public func drop<C : Collection>(upTo pattern: C) where C.Iterator.Element == Self.Iterator.Element {
        drop(upTo: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.drop(through:)_]
    /// Drops elements from the beginning of the collection to the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    mutating public func drop(through pattern: Pattern<Iterator.Element>) {
        if let match = firstMatch(for: pattern) {
            removeSubrange(startIndex ..< match.range.upperBound)
        } else {
            self = Self()
        }
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.drop(through:)_]
    /// Drops elements from the beginning of the collection to the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    mutating public func drop(through pattern: LiteralPattern<Iterator.Element>) {
        drop(through: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.drop(through:)_]
    /// Drops elements from the beginning of the collection to the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    mutating public func drop(through pattern: CompositePattern<Iterator.Element>) {
        drop(through: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.drop(through:)_]
    /// Drops elements from the beginning of the collection to the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    mutating public func drop<C : Collection>(through pattern: C) where C.Iterator.Element == Self.Iterator.Element {
        drop(through: LiteralPattern(pattern))
    }
}

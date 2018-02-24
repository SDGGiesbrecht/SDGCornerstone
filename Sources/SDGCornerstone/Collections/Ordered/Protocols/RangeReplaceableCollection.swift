/*
 RangeReplaceableCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension RangeReplaceableCollection where Element : Equatable {
    // MARK: - where Element : Equatable

    // [_Define Documentation: SDGCornerstone.Collection.trucate(before:)_]
    /// Truncates `self` at the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func truncate(before pattern: Pattern<Element>) {
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
    public mutating func truncate(before pattern: LiteralPattern<Element>) {
        truncate(before: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucate(before:)_]
    /// Truncates `self` at the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func truncate(before pattern: CompositePattern<Element>) {
        truncate(before: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucate(after:)_]
    /// Truncates `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func truncate<C : Collection>(before pattern: C) where C.Element == Self.Element {
        truncate(before: LiteralPattern(pattern))
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucate(after:)_]
    /// Truncates `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func truncate(before pattern: Self) {
        truncate(before: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.trucated(before:)_]
    /// Returns a collection formed by truncating `self` at the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func truncated(before pattern: Pattern<Element>) -> Self {
        var result = self
        result.truncate(before: pattern)
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucated(before:)_]
    /// Returns a collection formed by truncating `self` at the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func truncated(before pattern: LiteralPattern<Element>) -> Self {
        return truncated(before: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucated(before:)_]
    /// Returns a collection formed by truncating `self` at the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func truncated(before pattern: CompositePattern<Element>) -> Self {
        return truncated(before: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucated(after:)_]
    /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func truncated<C : Collection>(before pattern: C) -> Self where C.Element == Self.Element {
        return truncated(before: LiteralPattern(pattern))
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucated(after:)_]
    /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func truncated(before pattern: Self) -> Self {
        return truncated(before: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.trucate(after:)_]
    /// Truncates `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func truncate(after pattern: Pattern<Element>) {
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
    public mutating func truncate(after pattern: LiteralPattern<Element>) {
        truncate(after: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucate(after:)_]
    /// Truncates `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func truncate(after pattern: CompositePattern<Element>) {
        truncate(after: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucate(after:)_]
    /// Truncates `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func truncate<C : Collection>(after pattern: C) where C.Element == Self.Element {
        truncate(after: LiteralPattern(pattern))
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucate(after:)_]
    /// Truncates `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func truncate(after pattern: Self) {
        truncate(after: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.trucated(after:)_]
    /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func truncated(after pattern: Pattern<Element>) -> Self {
        var result = self
        result.truncate(after: pattern)
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucated(after:)_]
    /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func truncated(after pattern: LiteralPattern<Element>) -> Self {
        return truncated(after: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucated(after:)_]
    /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func truncated(after pattern: CompositePattern<Element>) -> Self {
        return truncated(after: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucated(after:)_]
    /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func truncated<C : Collection>(after pattern: C) -> Self where C.Element == Self.Element {
        return truncated(after: LiteralPattern(pattern))
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucated(after:)_]
    /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func truncated(after pattern: Self) -> Self {
        return truncated(after: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.drop(upTo:)_]
    /// Drops elements from the beginning of the collection to the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func drop(upTo pattern: Pattern<Element>) {
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
    public mutating func drop(upTo pattern: LiteralPattern<Element>) {
        drop(upTo: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.drop(upTo:)_]
    /// Drops elements from the beginning of the collection to the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func drop(upTo pattern: CompositePattern<Element>) {
        drop(upTo: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.drop(upTo:)_]
    /// Drops elements from the beginning of the collection to the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func drop<C : Collection>(upTo pattern: C) where C.Element == Self.Element {
        drop(upTo: LiteralPattern(pattern))
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.drop(upTo:)_]
    /// Drops elements from the beginning of the collection to the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func drop(upTo pattern: Self) {
        drop(upTo: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.dropping(upTo:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the start of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func dropping(upTo pattern: Pattern<Element>) -> Self {
        var result = self
        result.drop(upTo: pattern)
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.dropping(upTo:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the start of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func dropping(upTo pattern: LiteralPattern<Element>) -> Self {
        return dropping(upTo: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.dropping(upTo:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the start of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func dropping(upTo pattern: CompositePattern<Element>) -> Self {
        return dropping(upTo: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.dropping(upTo:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the start of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func dropping<C : Collection>(upTo pattern: C) -> Self where C.Element == Self.Element {
        return dropping(upTo: LiteralPattern(pattern))
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.dropping(upTo:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the start of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func dropping(upTo pattern: Self) -> Self {
        return dropping(upTo: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.drop(through:)_]
    /// Drops elements from the beginning of the collection to the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func drop(through pattern: Pattern<Element>) {
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
    public mutating func drop(through pattern: LiteralPattern<Element>) {
        drop(through: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.drop(through:)_]
    /// Drops elements from the beginning of the collection to the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func drop(through pattern: CompositePattern<Element>) {
        drop(through: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.drop(through:)_]
    /// Drops elements from the beginning of the collection to the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func drop<C : Collection>(through pattern: C) where C.Element == Self.Element {
        drop(through: LiteralPattern(pattern))
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.drop(through:)_]
    /// Drops elements from the beginning of the collection to the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func drop(through pattern: Self) {
        drop(through: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.dropping(through:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the end of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func dropping(through pattern: Pattern<Element>) -> Self {
        var result = self
        result.drop(through: pattern)
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.dropping(through:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the end of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func dropping(through pattern: LiteralPattern<Element>) -> Self {
        return dropping(through: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.dropping(through:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the end of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func dropping(through pattern: CompositePattern<Element>) -> Self {
        return dropping(through: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.dropping(through:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the end of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func dropping<C : Collection>(through pattern: C) -> Self where C.Element == Self.Element {
        return dropping(through: LiteralPattern(pattern))
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.dropping(through:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the end of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func dropping(through pattern: Self) -> Self {
        return dropping(through: LiteralPattern(pattern))
    }
}

extension RangeReplaceableCollection where Element : Equatable, SubSequence : Collection {
    // MARK: - where Element == Equatable, SubSequence : Collection

    // [_Define Documentation: SDGCornerstone.Collection.replaceMatches(for:with:)_]
    /// Replaces each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public mutating func replaceMatches<C : Collection>(for pattern: Pattern<Element>, with replacement: C) where C.Element == Self.Element {
        mutateMatches(for: pattern, mutation: { (_) -> C in
            return replacement
        })
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.replaceMatches(for:with:)_]
    /// Replaces each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public mutating func replaceMatches<C : Collection>(for pattern: LiteralPattern<Element>, with replacement: C) where C.Element == Self.Element {
        replaceMatches(for: pattern as Pattern<Element>, with: replacement)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.replaceMatches(for:with:)_]
    /// Replaces each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public mutating func replaceMatches<C : Collection>(for pattern: CompositePattern<Element>, with replacement: C) where C.Element == Self.Element {
        replaceMatches(for: pattern as Pattern<Element>, with: replacement)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.replaceMatches(for:with:)_]
    /// Replaces each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public mutating func replaceMatches<P : Collection, C : Collection>(for pattern: P, with replacement: C) where P.Element == Self.Element, C.Element == Self.Element {
        replaceMatches(for: LiteralPattern(pattern), with: replacement)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.replaceMatches(for:with:)_]
    /// Replaces each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public mutating func replaceMatches(for pattern: Self, with replacement: Self) {
        replaceMatches(for: LiteralPattern(pattern), with: replacement)
    }

    // [_Define Documentation: SDGCornerstone.Collection.replacingMatches(for:with:)_]
    /// Returns a collection formed by replacing each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public func replacingMatches<C : Collection>(for pattern: Pattern<Element>, with replacement: C) -> Self where C.Element == Self.Element {
        var result = self
        result.replaceMatches(for: pattern, with: replacement)
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.replacingMatches(for:with:)_]
    /// Returns a collection formed by replacing each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public func replacingMatches<C : Collection>(for pattern: LiteralPattern<Element>, with replacement: C) -> Self where C.Element == Self.Element {
        return replacingMatches(for: pattern as Pattern<Element>, with: replacement)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.replacingMatches(for:with:)_]
    /// Returns a collection formed by replacing each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public func replacingMatches<C : Collection>(for pattern: CompositePattern<Element>, with replacement: C) -> Self where C.Element == Self.Element {
        return replacingMatches(for: pattern as Pattern<Element>, with: replacement)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.replacingMatches(for:with:)_]
    /// Returns a collection formed by replacing each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public func replacingMatches<P : Collection, C : Collection>(for pattern: P, with replacement: C) -> Self where P.Element == Self.Element, C.Element == Self.Element {
        return replacingMatches(for: LiteralPattern(pattern), with: replacement)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.replacingMatches(for:with:)_]
    /// Returns a collection formed by replacing each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public func replacingMatches(for pattern: Self, with replacement: Self) -> Self {
        return replacingMatches(for: LiteralPattern(pattern), with: replacement)
    }

    // [_Define Documentation: SDGCornerstone.Collection.mutateMatches(for:mutation:)_]
    /// Mutates each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - mutation: A closure that generates a replacement collection from a match.
    public mutating func mutateMatches<C : Collection>(for pattern: Pattern<Element>, mutation: (_ match: PatternMatch<Self>) -> C) where C.Element == Self.Element {

        let hits = matches(for: pattern)
        var unaltered = ranges(separatedBy: hits.map({ $0.range }))

        var replacements = hits.map({ mutation($0) })

        var result = Self()
        while ¬replacements.isEmpty {
            result.append(contentsOf: self[unaltered.removeFirst()])
            result.append(contentsOf: replacements.removeFirst())
        }

        result.append(contentsOf: self[unaltered.removeFirst()])

        self = result
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.mutateMatches(for:mutation:)_]
    /// Mutates each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - mutation: A closure that generates a replacement collection from a match.
    public mutating func mutateMatches<C : Collection>(for pattern: LiteralPattern<Element>, mutation: (_ match: PatternMatch<Self>) -> C) where C.Element == Self.Element {
        mutateMatches(for: pattern as Pattern<Element>, mutation: mutation)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.mutateMatches(for:mutation:)_]
    /// Mutates each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - mutation: A closure that generates a replacement collection from a match.
    public mutating func mutateMatches<C : Collection>(for pattern: CompositePattern<Element>, mutation: (_ match: PatternMatch<Self>) -> C) where C.Element == Self.Element {
        mutateMatches(for: pattern as Pattern<Element>, mutation: mutation)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.mutateMatches(for:mutation:)_]
    /// Mutates each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - mutation: A closure that generates a replacement collection from a match.
    public mutating func mutateMatches<P : Collection, C : Collection>(for pattern: P, mutation: (_ match: PatternMatch<Self>) -> C) where P.Element == Self.Element, C.Element == Self.Element {
        mutateMatches(for: LiteralPattern(pattern), mutation: mutation)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.mutateMatches(for:mutation:)_]
    /// Mutates each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - mutation: A closure that generates a replacement collection from a match.
    public mutating func mutateMatches<C : Collection>(for pattern: Self, mutation: (_ match: PatternMatch<Self>) -> C) where C.Element == Self.Element {
        mutateMatches(for: LiteralPattern(pattern), mutation: mutation)
    }

    // [_Define Documentation: SDGCornerstone.Collection.mutatingMatches(for:mutation:)_]
    /// Returns a collection formed by mutating each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public func mutatingMatches<C : Collection>(for pattern: Pattern<Element>, mutation: (_ match: PatternMatch<Self>) -> C) -> Self where C.Element == Self.Element {
        var result = self
        result.mutateMatches(for: pattern, mutation: mutation)
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.mutatingMatches(for:mutation:)_]
    /// Returns a collection formed by mutating each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public func mutatingMatches<C : Collection>(for pattern: LiteralPattern<Element>, mutation: (_ match: PatternMatch<Self>) -> C) -> Self where C.Element == Self.Element {
        return mutatingMatches(for: pattern as Pattern<Element>, mutation: mutation)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.mutatingMatches(for:mutation:)_]
    /// Returns a collection formed by mutating each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public func mutatingMatches<C : Collection>(for pattern: CompositePattern<Element>, mutation: (_ match: PatternMatch<Self>) -> C) -> Self where C.Element == Self.Element {
        return mutatingMatches(for: pattern as Pattern<Element>, mutation: mutation)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.mutatingMatches(for:mutation:)_]
    /// Returns a collection formed by mutating each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public func mutatingMatches<P : Collection, C : Collection>(for pattern: P, mutation: (_ match: PatternMatch<Self>) -> C) -> Self where P.Element == Self.Element, C.Element == Self.Element {
        return mutatingMatches(for: LiteralPattern(pattern), mutation: mutation)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.mutatingMatches(for:mutation:)_]
    /// Returns a collection formed by mutating each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public func mutatingMatches<C : Collection>(for pattern: Self, mutation: (_ match: PatternMatch<Self>) -> C) -> Self where C.Element == Self.Element {
        return mutatingMatches(for: LiteralPattern(pattern), mutation: mutation)
    }
}

extension RangeReplaceableCollection where IndexDistance : WholeArithmetic {
    // MARK: - where IndexDistance : WholeArithmetic

    /// Shuffles the collection.
    ///
    /// - Parameters:
    ///     - randomizer: A particular randomizer to use. (A `PseudorandomNumberGenerator` by default.)
    public mutating func shuffle(usingRandomizer randomizer: Randomizer = PseudorandomNumberGenerator.defaultGenerator) {
        for i in indices {
            let originalLocation = distance(from: startIndex, to: i)
            let newLocation = IndexDistance(randomInRange: 0 ... originalLocation, fromRandomizer: randomizer)
            let element = remove(at: index(startIndex, offsetBy: originalLocation))
            insert(element, at: index(startIndex, offsetBy: newLocation))
        }
    }

    /// Returns a shuffled collection.
    ///
    /// - Parameters:
    ///     - randomizer: A particular randomizer to use. (A `PseudorandomNumberGenerator` by default.)
    public func shuffled(usingRandomizer randomizer: Randomizer = PseudorandomNumberGenerator.defaultGenerator) -> Self {
        var result = self
        result.shuffle(usingRandomizer: randomizer)
        return result
    }
}

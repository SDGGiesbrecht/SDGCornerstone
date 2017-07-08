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

    // [_Define Documentation: SDGCornerstone.RangeReplaceableCollection.init()_]
    /// Creates a new, empty collection.

    // [_Define Documentation: SDGCornerstone.RangeReplaceableCollection.init(_:)_]
    /// Creates a new instance of a collection containing the elements of a sequence.

    // [_Define Documentation: SDGCornerstone.RangeReplaceableCollection.append(contentsOf:)_]
    /// Appends the contents of the sequence to the end of the collection.

    private mutating func appendAsCollection<S>(contentsOf newElements: S) where S : Sequence, S.Iterator.Element == Self.Iterator.Element {
        append(contentsOf: newElements)
    }
    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.append(contentsOf:)_]
    /// Appends the contents of the sequence to the end of the collection.
    public mutating func append(contentsOf newElements: Self) {
        appendAsCollection(contentsOf: newElements)
    }

    // [_Define Documentation: SDGCornerstone.RangeReplaceableCollection.insert(contentsOf:at:)_]
    /// Inserts the contents of the sequence to the specified index.

    private mutating func insertAsCollection<S>(contentsOf newElements: S, at i: Self.Index) where S : Collection, S.Iterator.Element == Self.Iterator.Element {
        insert(contentsOf: newElements, at: i)
    }
    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.insert(contentsOf:at:)_]
    /// Inserts the contents of the sequence to the specified index.
    public mutating func insert(contentsOf newElements: Self, at i: Self.Index) {
        insertAsCollection(contentsOf: newElements, at: i)
    }

    // [_Define Documentation: SDGCornerstone.RangeReplaceableCollection.replaceSubrange(_:with:)_]
    /// Replaces the specified subrange of elements with the given collection.

    private mutating func replaceSubrangeAsCollection<C>(_ subrange: Range<Self.Index>, with newElements: C) where C : Collection, C.Iterator.Element == Self.Iterator.Element {
        replaceSubrange(subrange, with: newElements)
    }
    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.insert(contentsOf:at:)_]
    /// Inserts the contents of the sequence to the specified index.
    public mutating func replaceSubrange(_ subrange: Range<Self.Index>, with newElements: Self) {
        replaceSubrangeAsCollection(subrange, with: newElements)
    }

    /// Returns a collection formed by appending an element to the end of the collection.
    ///
    /// - Parameters:
    ///     - newElement: The element to append to the collection
    public func appending(_ newElement: Self.Iterator.Element) -> Self {
        var result = self
        result.append(newElement)
        return result
    }

    // [_Define Documentation: SDGCornerstone.RangeReplaceableCollectionType.appending(contentsOf:)_]
    /// Returns a collection formed by appending the contents of another collection to the end of `self`.
    ///
    /// - Parameters:
    ///     - newElements: The elements to append to the collection
    public func appending<C : Collection>(contentsOf newElements: C) -> Self where C.Iterator.Element == Self.Iterator.Element {
        var result = self
        result.append(contentsOf: newElements)
        return result
    }

    private func appendingAsCollection<C : Collection>(contentsOf newElements: C) -> Self where C.Iterator.Element == Self.Iterator.Element {
        return appending(contentsOf: newElements)
    }
    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollectionType.appending(contentsOf:)_]
    /// Returns a collection formed by appending the contents of another collection to the end of `self`.
    ///
    /// - Parameters:
    ///     - newElements: The elements to append to the collection
    public func appending(contentsOf newElements: Self) -> Self {
        return appendingAsCollection(contentsOf: newElements)
    }

    /// Adds an element to the beginning of the collection.
    ///
    /// - Parameters:
    ///     - newElement: The element to prepend to the collection
    public mutating func prepend(_ newElement: Self.Iterator.Element) {
        insert(newElement, at: startIndex)
    }

    // [_Define Documentation: SDGCornerstone.RangeReplaceableCollection.prepend(contentsOf:)_]
    /// Adds the contents of another collection to the beginning of `self`.
    ///
    /// - Parameters:
    ///     - newElements: The elements to prepend to the collection
    public mutating func prepend<C : Collection>(contentsOf newElements: C) where C.Iterator.Element == Self.Iterator.Element {
        insert(contentsOf: newElements, at: startIndex)
    }

    private mutating func prependAsCollection<C : Collection>(contentsOf newElements: C) where C.Iterator.Element == Self.Iterator.Element {
        prepend(contentsOf: newElements)
    }
    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.prepend(contentsOf:)_]
    /// Adds the contents of another collection to the beginning of `self`.
    ///
    /// - Parameters:
    ///     - newElements: The elements to prepend to the collection
    public mutating func prepend(contentsOf newElements: Self) {
        prependAsCollection(contentsOf: newElements)
    }

    /// Returns a collection formed by prepending an element to the beginning of the collection.
    ///
    /// - Parameters:
    ///     - newElement: The element to prepend to the collection
    public func prepending(_ newElement: Self.Iterator.Element) -> Self {
        var result = self
        result.prepend(newElement)
        return result
    }

    // [_Define Documentation: SDGCornerstone.RangeReplaceableCollection.prepending(contentsOf:)_]
    /// Returns a collection formed by prepending the contents of another collection to the beginning of `self`.
    ///
    /// - Parameters:
    ///     - newElements: The elements to prepend to the collection
    public func prepending<C : Collection>(contentsOf newElements: C) -> Self where C.Iterator.Element == Self.Iterator.Element {
        var result = self
        result.prepend(contentsOf: newElements)
        return result
    }

    private func prependingAsCollection<C : Collection>(contentsOf newElements: C) -> Self where C.Iterator.Element == Self.Iterator.Element {
        return prepending(contentsOf: newElements)
    }
    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.prepend(contentsOf:)_]
    /// Adds the contents of another collection to the beginning of `self`.
    ///
    /// - Parameters:
    ///     - newElements: The elements to prepend to the collection
    public func prepending(contentsOf newElements: Self) -> Self {
        return prependingAsCollection(contentsOf: newElements)
    }

    /// Truncates the `self` at `index`.
    public mutating func truncate(at index: Index) {
        removeSubrange(index ..< endIndex)
    }

    /// Returns a collection formed by truncating `self` at `index`.
    public func truncated(at index: Index) -> Self {
        var result = self
        result.truncate(at: index)
        return result
    }

    /// Fills the collection to a certain count.
    ///
    /// - Parameters:
    ///     - count: The target count.
    ///     - element: The element with which to fill the collection.
    ///     - direction: The direction from which to fill the collection.
    public mutating func fill(to count: IndexDistance, with element: Iterator.Element, from direction: FillDirection) {
        while self.count < count {
            switch direction {
            case .start:
                prepend(element)
            case .end:
                append(element)
            }
        }
    }

    /// Returns the collection filled to a certain count.
    ///
    /// - Parameters:
    ///     - count: The target count.
    ///     - element: The element with which to fill the collection.
    ///     - direction: The direction from which to fill the collection.
    public func filled(to count: IndexDistance, with element: Iterator.Element, from direction: FillDirection) -> Self {
        var result = self
        result.fill(to: count, with: element, from: direction)
        return result
    }
}

extension RangeReplaceableCollection where IndexDistance : WholeArithmetic, Indices.Iterator.Element == Index {
    // MARK: - where IndexDistance : WholeArithmetic, Indices.Iterator.Element == Index

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

extension RangeReplaceableCollection where Iterator.Element : Equatable {
    // MARK: - where Iterator.Element : Equatable

    // [_Define Documentation: SDGCornerstone.Collection.trucate(before:)_]
    /// Truncates `self` at the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func truncate(before pattern: Pattern<Iterator.Element>) {
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
    public mutating func truncate(before pattern: LiteralPattern<Iterator.Element>) {
        truncate(before: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucate(before:)_]
    /// Truncates `self` at the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func truncate(before pattern: CompositePattern<Iterator.Element>) {
        truncate(before: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucate(after:)_]
    /// Truncates `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func truncate<C : Collection>(before pattern: C) where C.Iterator.Element == Self.Iterator.Element {
        truncate(before: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.trucated(before:)_]
    /// Returns a collection formed by truncating `self` at the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func truncated(before pattern: Pattern<Iterator.Element>) -> Self {
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
    public func truncated(before pattern: LiteralPattern<Iterator.Element>) -> Self {
        return truncated(before: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucated(before:)_]
    /// Returns a collection formed by truncating `self` at the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func truncated(before pattern: CompositePattern<Iterator.Element>) -> Self {
        return truncated(before: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucated(after:)_]
    /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func truncated<C : Collection>(before pattern: C) -> Self where C.Iterator.Element == Self.Iterator.Element {
        return truncated(before: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.trucate(after:)_]
    /// Truncates `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func truncate(after pattern: Pattern<Iterator.Element>) {
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
    public mutating func truncate(after pattern: LiteralPattern<Iterator.Element>) {
        truncate(after: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucate(after:)_]
    /// Truncates `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func truncate(after pattern: CompositePattern<Iterator.Element>) {
        truncate(after: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucate(after:)_]
    /// Truncates `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func truncate<C : Collection>(after pattern: C) where C.Iterator.Element == Self.Iterator.Element {
        truncate(after: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.trucated(after:)_]
    /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func truncated(after pattern: Pattern<Iterator.Element>) -> Self {
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
    public func truncated(after pattern: LiteralPattern<Iterator.Element>) -> Self {
        return truncated(after: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucated(after:)_]
    /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func truncated(after pattern: CompositePattern<Iterator.Element>) -> Self {
        return truncated(after: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucated(after:)_]
    /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func truncated<C : Collection>(after pattern: C) -> Self where C.Iterator.Element == Self.Iterator.Element {
        return truncated(after: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.drop(upTo:)_]
    /// Drops elements from the beginning of the collection to the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func drop(upTo pattern: Pattern<Iterator.Element>) {
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
    public mutating func drop(upTo pattern: LiteralPattern<Iterator.Element>) {
        drop(upTo: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.drop(upTo:)_]
    /// Drops elements from the beginning of the collection to the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func drop(upTo pattern: CompositePattern<Iterator.Element>) {
        drop(upTo: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.drop(upTo:)_]
    /// Drops elements from the beginning of the collection to the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func drop<C : Collection>(upTo pattern: C) where C.Iterator.Element == Self.Iterator.Element {
        drop(upTo: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.dropping(upTo:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the start of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func dropping(upTo pattern: Pattern<Iterator.Element>) -> Self {
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
    public func dropping(upTo pattern: LiteralPattern<Iterator.Element>) -> Self {
        return dropping(upTo: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.dropping(upTo:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the start of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func dropping(upTo pattern: CompositePattern<Iterator.Element>) -> Self {
        return dropping(upTo: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.dropping(upTo:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the start of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func dropping<C : Collection>(upTo pattern: C) -> Self where C.Iterator.Element == Self.Iterator.Element {
        return dropping(upTo: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.drop(through:)_]
    /// Drops elements from the beginning of the collection to the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func drop(through pattern: Pattern<Iterator.Element>) {
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
    public mutating func drop(through pattern: LiteralPattern<Iterator.Element>) {
        drop(through: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.drop(through:)_]
    /// Drops elements from the beginning of the collection to the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func drop(through pattern: CompositePattern<Iterator.Element>) {
        drop(through: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.drop(through:)_]
    /// Drops elements from the beginning of the collection to the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public mutating func drop<C : Collection>(through pattern: C) where C.Iterator.Element == Self.Iterator.Element {
        drop(through: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.dropping(through:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the end of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func dropping(through pattern: Pattern<Iterator.Element>) -> Self {
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
    public func dropping(through pattern: LiteralPattern<Iterator.Element>) -> Self {
        return dropping(through: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.dropping(through:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the end of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func dropping(through pattern: CompositePattern<Iterator.Element>) -> Self {
        return dropping(through: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.dropping(through:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the end of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func dropping<C : Collection>(through pattern: C) -> Self where C.Iterator.Element == Self.Iterator.Element {
        return dropping(through: LiteralPattern(pattern))
    }
}

extension RangeReplaceableCollection where SubSequence : Collection, SubSequence.Iterator.Element == Iterator.Element, Iterator.Element : Equatable {
    // MARK: - where SubSequence : Collection, SubSequence.Iterator.Element == Iterator.Element, Iterator.Element == Equatable

    // [_Define Documentation: SDGCornerstone.Collection.replaceMatches(for:with:)_]
    /// Replaces each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public mutating func replaceMatches<C : Collection>(for pattern: Pattern<Iterator.Element>, with replacement: C) where C.Iterator.Element == Self.Iterator.Element {
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
    public mutating func replaceMatches<C : Collection>(for pattern: LiteralPattern<Iterator.Element>, with replacement: C) where C.Iterator.Element == Self.Iterator.Element {
        replaceMatches(for: pattern as Pattern<Iterator.Element>, with: replacement)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.replaceMatches(for:with:)_]
    /// Replaces each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public mutating func replaceMatches<C : Collection>(for pattern: CompositePattern<Iterator.Element>, with replacement: C) where C.Iterator.Element == Self.Iterator.Element {
        replaceMatches(for: pattern as Pattern<Iterator.Element>, with: replacement)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.replaceMatches(for:with:)_]
    /// Replaces each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public mutating func replaceMatches<P : Collection, C : Collection>(for pattern: P, with replacement: C) where P.Iterator.Element == Self.Iterator.Element, C.Iterator.Element == Self.Iterator.Element {
        replaceMatches(for: LiteralPattern(pattern), with: replacement)
    }

    // [_Define Documentation: SDGCornerstone.Collection.replacingMatches(for:with:)_]
    /// Returns a collection formed by replacing each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public func replacingMatches<C : Collection>(for pattern: Pattern<Iterator.Element>, with replacement: C) -> Self where C.Iterator.Element == Self.Iterator.Element {
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
    public func replacingMatches<C : Collection>(for pattern: LiteralPattern<Iterator.Element>, with replacement: C) -> Self where C.Iterator.Element == Self.Iterator.Element {
        return replacingMatches(for: pattern as Pattern<Iterator.Element>, with: replacement)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.replacingMatches(for:with:)_]
    /// Returns a collection formed by replacing each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public func replacingMatches<C : Collection>(for pattern: CompositePattern<Iterator.Element>, with replacement: C) -> Self where C.Iterator.Element == Self.Iterator.Element {
        return replacingMatches(for: pattern as Pattern<Iterator.Element>, with: replacement)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.replacingMatches(for:with:)_]
    /// Returns a collection formed by replacing each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public func replacingMatches<P : Collection, C : Collection>(for pattern: P, with replacement: C) -> Self where P.Iterator.Element == Self.Iterator.Element, C.Iterator.Element == Self.Iterator.Element {
        return replacingMatches(for: LiteralPattern(pattern), with: replacement)
    }

    // [_Define Documentation: SDGCornerstone.Collection.mutateMatches(for:mutation:)_]
    /// Mutates each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - mutation: A closure that generates a replacement collection from a match.
    public mutating func mutateMatches<C : Collection>(for pattern: Pattern<Iterator.Element>, mutation: (_ match: PatternMatch<Self>) -> C) where C.Iterator.Element == Self.Iterator.Element {

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
    public mutating func mutateMatches<C : Collection>(for pattern: LiteralPattern<Iterator.Element>, mutation: (_ match: PatternMatch<Self>) -> C) where C.Iterator.Element == Self.Iterator.Element {
        mutateMatches(for: pattern as Pattern<Iterator.Element>, mutation: mutation)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.mutateMatches(for:mutation:)_]
    /// Mutates each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - mutation: A closure that generates a replacement collection from a match.
    public mutating func mutateMatches<C : Collection>(for pattern: CompositePattern<Iterator.Element>, mutation: (_ match: PatternMatch<Self>) -> C) where C.Iterator.Element == Self.Iterator.Element {
        mutateMatches(for: pattern as Pattern<Iterator.Element>, mutation: mutation)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.mutateMatches(for:mutation:)_]
    /// Mutates each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - mutation: A closure that generates a replacement collection from a match.
    public mutating func mutateMatches<P : Collection, C : Collection>(for pattern: P, mutation: (_ match: PatternMatch<Self>) -> C) where P.Iterator.Element == Self.Iterator.Element, C.Iterator.Element == Self.Iterator.Element {
        mutateMatches(for: LiteralPattern(pattern), mutation: mutation)
    }

    // [_Define Documentation: SDGCornerstone.Collection.mutatingMatches(for:mutation:)_]
    /// Returns a collection formed by mutating each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public func mutatingMatches<C : Collection>(for pattern: Pattern<Iterator.Element>, mutation: (_ match: PatternMatch<Self>) -> C) -> Self where C.Iterator.Element == Self.Iterator.Element {
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
    public func mutatingMatches<C : Collection>(for pattern: LiteralPattern<Iterator.Element>, mutation: (_ match: PatternMatch<Self>) -> C) -> Self where C.Iterator.Element == Self.Iterator.Element {
        return mutatingMatches(for: pattern as Pattern<Iterator.Element>, mutation: mutation)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.mutatingMatches(for:mutation:)_]
    /// Returns a collection formed by mutating each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public func mutatingMatches<C : Collection>(for pattern: CompositePattern<Iterator.Element>, mutation: (_ match: PatternMatch<Self>) -> C) -> Self where C.Iterator.Element == Self.Iterator.Element {
        return mutatingMatches(for: pattern as Pattern<Iterator.Element>, mutation: mutation)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.mutatingMatches(for:mutation:)_]
    /// Returns a collection formed by mutating each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    public func mutatingMatches<P : Collection, C : Collection>(for pattern: P, mutation: (_ match: PatternMatch<Self>) -> C) -> Self where P.Iterator.Element == Self.Iterator.Element, C.Iterator.Element == Self.Iterator.Element {
        return mutatingMatches(for: LiteralPattern(pattern), mutation: mutation)
    }
}

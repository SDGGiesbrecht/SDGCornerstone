/*
 RangeReplaceableCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic

extension RangeReplaceableCollection {

    // [_Define Documentation: SDGCornerstone.RangeReplaceableCollection.init()_]
    /// Creates a new, empty collection.

    // [_Define Documentation: SDGCornerstone.RangeReplaceableCollection.init(_:)_]
    /// Creates a new instance of a collection containing the elements of a sequence.

    // [_Define Documentation: SDGCornerstone.RangeReplaceableCollection.append(contentsOf:)_]
    /// Appends the contents of the sequence to the end of the collection.

    @_transparent @_versioned internal mutating func appendAsCollection<S>(contentsOf newElements: S) where S : Sequence, S.Element == Self.Element {
        append(contentsOf: newElements)
    }
    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.append(contentsOf:)_]
    /// Appends the contents of the sequence to the end of the collection.
    @_transparent public mutating func append(contentsOf newElements: Self) {
        appendAsCollection(contentsOf: newElements)
    }

    // [_Define Documentation: SDGCornerstone.RangeReplaceableCollection.insert(contentsOf:at:)_]
    /// Inserts the contents of the sequence to the specified index.

    @_transparent @_versioned internal mutating func insertAsCollection<S>(contentsOf newElements: S, at i: Self.Index) where S : Collection, S.Element == Self.Element {
        insert(contentsOf: newElements, at: i)
    }
    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.insert(contentsOf:at:)_]
    /// Inserts the contents of the sequence to the specified index.
    @_transparent public mutating func insert(contentsOf newElements: Self, at i: Self.Index) {
        insertAsCollection(contentsOf: newElements, at: i)
    }

    // [_Define Documentation: SDGCornerstone.RangeReplaceableCollection.replaceSubrange(_:with:)_]
    /// Replaces the specified subrange of elements with the given collection.

    @_transparent @_versioned internal mutating func replaceSubrangeAsCollection<C>(_ subrange: Range<Self.Index>, with newElements: C) where C : Collection, C.Element == Self.Element {
        replaceSubrange(subrange, with: newElements)
    }
    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.insert(contentsOf:at:)_]
    /// Inserts the contents of the sequence to the specified index.
    @_transparent public mutating func replaceSubrange(_ subrange: Range<Self.Index>, with newElements: Self) {
        replaceSubrangeAsCollection(subrange, with: newElements)
    }

    /// Returns a collection formed by appending an element to the end of the collection.
    ///
    /// - Parameters:
    ///     - newElement: The element to append to the collection
    @_inlineable public func appending(_ newElement: Self.Element) -> Self {
        return nonmutatingVariant(of: Self.append, on: self, with: newElement)
    }

    // [_Define Documentation: SDGCornerstone.RangeReplaceableCollectionType.appending(contentsOf:)_]
    /// Returns a collection formed by appending the contents of another collection to the end of `self`.
    ///
    /// - Parameters:
    ///     - newElements: The elements to append to the collection
    @_inlineable public func appending<C : Collection>(contentsOf newElements: C) -> Self where C.Element == Self.Element {
        return nonmutatingVariant(of: Self.append, on: self, with: newElements)
    }

    @_transparent @_versioned internal func appendingAsCollection<C : Collection>(contentsOf newElements: C) -> Self where C.Element == Self.Element {
        return appending(contentsOf: newElements)
    }
    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollectionType.appending(contentsOf:)_]
    /// Returns a collection formed by appending the contents of another collection to the end of `self`.
    ///
    /// - Parameters:
    ///     - newElements: The elements to append to the collection
    @_transparent public func appending(contentsOf newElements: Self) -> Self {
        return appendingAsCollection(contentsOf: newElements)
    }

    /// Adds an element to the beginning of the collection.
    ///
    /// - Parameters:
    ///     - newElement: The element to prepend to the collection
    @_inlineable public mutating func prepend(_ newElement: Self.Element) {
        insert(newElement, at: startIndex)
    }

    // [_Define Documentation: SDGCornerstone.RangeReplaceableCollection.prepend(contentsOf:)_]
    /// Adds the contents of another collection to the beginning of `self`.
    ///
    /// - Parameters:
    ///     - newElements: The elements to prepend to the collection
    @_inlineable public mutating func prepend<C : Collection>(contentsOf newElements: C) where C.Element == Self.Element {
        insert(contentsOf: newElements, at: startIndex)
    }

    @_transparent @_versioned internal mutating func prependAsCollection<C : Collection>(contentsOf newElements: C) where C.Element == Self.Element {
        prepend(contentsOf: newElements)
    }
    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.prepend(contentsOf:)_]
    /// Adds the contents of another collection to the beginning of `self`.
    ///
    /// - Parameters:
    ///     - newElements: The elements to prepend to the collection
    @_transparent public mutating func prepend(contentsOf newElements: Self) {
        prependAsCollection(contentsOf: newElements)
    }

    /// Returns a collection formed by prepending an element to the beginning of the collection.
    ///
    /// - Parameters:
    ///     - newElement: The element to prepend to the collection
    @_inlineable public func prepending(_ newElement: Self.Element) -> Self {
        return nonmutatingVariant(of: Self.prepend, on: self, with: newElement)
    }

    // [_Define Documentation: SDGCornerstone.RangeReplaceableCollection.prepending(contentsOf:)_]
    /// Returns a collection formed by prepending the contents of another collection to the beginning of `self`.
    ///
    /// - Parameters:
    ///     - newElements: The elements to prepend to the collection
    @_inlineable public func prepending<C : Collection>(contentsOf newElements: C) -> Self where C.Element == Self.Element {
        return nonmutatingVariant(of: Self.prepend, on: self, with: newElements)
    }

    @_transparent @_versioned internal func prependingAsCollection<C : Collection>(contentsOf newElements: C) -> Self where C.Element == Self.Element {
        return prepending(contentsOf: newElements)
    }
    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.prepend(contentsOf:)_]
    /// Adds the contents of another collection to the beginning of `self`.
    ///
    /// - Parameters:
    ///     - newElements: The elements to prepend to the collection
    @_transparent public func prepending(contentsOf newElements: Self) -> Self {
        return prependingAsCollection(contentsOf: newElements)
    }

    /// Truncates the `self` at `index`.
    @_inlineable public mutating func truncate(at index: Index) {
        removeSubrange(index ..< endIndex)
    }

    /// Returns a collection formed by truncating `self` at `index`.
    @_inlineable public func truncated(at index: Index) -> Self {
        return nonmutatingVariant(of: Self.truncate, on: self, with: index)
    }

    /// Fills the collection to a certain count.
    ///
    /// - Parameters:
    ///     - count: The target count.
    ///     - element: The element with which to fill the collection.
    ///     - direction: The direction from which to fill the collection.
    @_inlineable public mutating func fill(to count: IndexDistance, with element: Element, from direction: FillDirection) {
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
    @_inlineable public func filled(to count: IndexDistance, with element: Element, from direction: FillDirection) -> Self {
        return nonmutatingVariant(of: Self.fill, on: self, with: (count, element, direction))
    }

    // MARK: ExpressibleByArrayLiteral

    // [_Inherit Documentation: SDGCornerstone.ExpressibleByArrayLiteral.init(arrayLiteral:)_]
    /// Creates an instance from an array literal.
    @_inlineable public init(arrayLiteral: Element...) {
        self.init()
        append(contentsOf: arrayLiteral)
    }
}

extension RangeReplaceableCollection where Element : Equatable {
    // MARK: - where Element : Equatable

    // [_Define Documentation: SDGCornerstone.Collection.trucate(before:)_]
    /// Truncates `self` at the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_inlineable public mutating func truncate(before pattern: Pattern<Element>) {
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
    @_transparent public mutating func truncate(before pattern: CompositePattern<Element>) {
        truncate(before: pattern as Pattern<Element>)
    }

    @_inlineable @_versioned internal mutating func _truncate<C : Collection>(before pattern: C) where C.Element == Self.Element {
        if let match = firstMatch(for: pattern) {
            removeSubrange(match.range.lowerBound ..< endIndex)
        }
    }
    // [_Inherit Documentation: SDGCornerstone.Collection.trucate(after:)_]
    /// Truncates `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_transparent public mutating func truncate<C : Collection>(before pattern: C) where C.Element == Self.Element {
        _truncate(before: pattern)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucate(after:)_]
    /// Truncates `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_transparent public mutating func truncate(before pattern: Self) {
        _truncate(before: pattern)
    }

    // [_Define Documentation: SDGCornerstone.Collection.trucated(before:)_]
    /// Returns a collection formed by truncating `self` at the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_inlineable public func truncated(before pattern: Pattern<Element>) -> Self {
        return nonmutatingVariant(of: Self.truncate(before:), on: self, with: pattern)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucated(before:)_]
    /// Returns a collection formed by truncating `self` at the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_inlineable public func truncated(before pattern: CompositePattern<Element>) -> Self {
        return nonmutatingVariant(of: Self.truncate(before:), on: self, with: pattern)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucated(after:)_]
    /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_inlineable public func truncated<C : Collection>(before pattern: C) -> Self where C.Element == Self.Element {
        return nonmutatingVariant(of: Self.truncate(before:), on: self, with: pattern)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucated(after:)_]
    /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_inlineable public func truncated(before pattern: Self) -> Self {
        return nonmutatingVariant(of: Self.truncate(before:), on: self, with: pattern)
    }

    // [_Define Documentation: SDGCornerstone.Collection.trucate(after:)_]
    /// Truncates `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_inlineable public mutating func truncate(after pattern: Pattern<Element>) {
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
    @_transparent public mutating func truncate(after pattern: CompositePattern<Element>) {
        truncate(after: pattern as Pattern<Element>)
    }

    @_inlineable @_versioned internal mutating func _truncate<C : Collection>(after pattern: C) where C.Element == Self.Element {
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
    @_transparent public mutating func truncate<C : Collection>(after pattern: C) where C.Element == Self.Element {
        _truncate(after: pattern)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucate(after:)_]
    /// Truncates `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_transparent public mutating func truncate(after pattern: Self) {
        _truncate(after: pattern)
    }

    // [_Define Documentation: SDGCornerstone.Collection.trucated(after:)_]
    /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_inlineable public func truncated(after pattern: Pattern<Element>) -> Self {
        return nonmutatingVariant(of: Self.truncate(after:), on: self, with: pattern)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucated(after:)_]
    /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_inlineable public func truncated(after pattern: CompositePattern<Element>) -> Self {
        return nonmutatingVariant(of: Self.truncate(after:), on: self, with: pattern)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucated(after:)_]
    /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_inlineable public func truncated<C : Collection>(after pattern: C) -> Self where C.Element == Self.Element {
        return nonmutatingVariant(of: Self.truncate(after:), on: self, with: pattern)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.trucated(after:)_]
    /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_inlineable public func truncated(after pattern: Self) -> Self {
        return nonmutatingVariant(of: Self.truncate(after:), on: self, with: pattern)
    }

    // [_Define Documentation: SDGCornerstone.Collection.drop(upTo:)_]
    /// Drops elements from the beginning of the collection to the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_inlineable public mutating func drop(upTo pattern: Pattern<Element>) {
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
    @_transparent public mutating func drop(upTo pattern: CompositePattern<Element>) {
        drop(upTo: pattern as Pattern<Element>)
    }

    @_inlineable @_versioned internal mutating func _drop<C : Collection>(upTo pattern: C) where C.Element == Self.Element {
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
    @_transparent public mutating func drop<C : Collection>(upTo pattern: C) where C.Element == Self.Element {
        _drop(upTo: pattern)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.drop(upTo:)_]
    /// Drops elements from the beginning of the collection to the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_transparent public mutating func drop(upTo pattern: Self) {
        _drop(upTo: pattern)
    }

    // [_Define Documentation: SDGCornerstone.Collection.dropping(upTo:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the start of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_inlineable public func dropping(upTo pattern: Pattern<Element>) -> Self {
        return nonmutatingVariant(of: Self.drop(upTo:), on: self, with: pattern)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.dropping(upTo:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the start of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_inlineable public func dropping(upTo pattern: CompositePattern<Element>) -> Self {
        return nonmutatingVariant(of: Self.drop(upTo:), on: self, with: pattern)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.dropping(upTo:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the start of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_inlineable public func dropping<C : Collection>(upTo pattern: C) -> Self where C.Element == Self.Element {
        return nonmutatingVariant(of: Self.drop(upTo:), on: self, with: pattern)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.dropping(upTo:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the start of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_inlineable public func dropping(upTo pattern: Self) -> Self {
        return nonmutatingVariant(of: Self.drop(upTo:), on: self, with: pattern)
    }

    // [_Define Documentation: SDGCornerstone.Collection.drop(through:)_]
    /// Drops elements from the beginning of the collection to the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_inlineable public mutating func drop(through pattern: Pattern<Element>) {
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
    @_transparent public mutating func drop(through pattern: CompositePattern<Element>) {
        drop(through: pattern as Pattern<Element>)
    }

    @_inlineable @_versioned internal mutating func _drop<C : Collection>(through pattern: C) where C.Element == Self.Element {
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
    @_transparent public mutating func drop<C : Collection>(through pattern: C) where C.Element == Self.Element {
        _drop(through: pattern)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.drop(through:)_]
    /// Drops elements from the beginning of the collection to the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_transparent public mutating func drop(through pattern: Self) {
        _drop(through: pattern)
    }

    // [_Define Documentation: SDGCornerstone.Collection.dropping(through:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the end of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_inlineable public func dropping(through pattern: Pattern<Element>) -> Self {
        return nonmutatingVariant(of: Self.drop(through:), on: self, with: pattern)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.dropping(through:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the end of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_inlineable public func dropping(through pattern: CompositePattern<Element>) -> Self {
        return nonmutatingVariant(of: Self.drop(through:), on: self, with: pattern)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.dropping(through:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the end of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_inlineable public func dropping<C : Collection>(through pattern: C) -> Self where C.Element == Self.Element {
        return nonmutatingVariant(of: Self.drop(through:), on: self, with: pattern)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.dropping(through:)_]
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the end of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @_inlineable public func dropping(through pattern: Self) -> Self {
        return nonmutatingVariant(of: Self.drop(through:), on: self, with: pattern)
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
    @_inlineable public mutating func replaceMatches<C : Collection>(for pattern: Pattern<Element>, with replacement: C) where C.Element == Self.Element {
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
    @_transparent public mutating func replaceMatches<C : Collection>(for pattern: CompositePattern<Element>, with replacement: C) where C.Element == Self.Element {
        replaceMatches(for: pattern as Pattern<Element>, with: replacement)
    }

    @_inlineable @_versioned internal mutating func _replaceMatches<P : Collection, C : Collection>(for pattern: P, with replacement: C) where P.Element == Self.Element, C.Element == Self.Element {
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
    @_transparent public mutating func replaceMatches<P : Collection, C : Collection>(for pattern: P, with replacement: C) where P.Element == Self.Element, C.Element == Self.Element {
        _replaceMatches(for: pattern, with: replacement)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.replaceMatches(for:with:)_]
    /// Replaces each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    @_transparent public mutating func replaceMatches(for pattern: Self, with replacement: Self) {
        _replaceMatches(for: pattern, with: replacement)
    }

    // [_Define Documentation: SDGCornerstone.Collection.replacingMatches(for:with:)_]
    /// Returns a collection formed by replacing each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    @_inlineable public func replacingMatches<C : Collection>(for pattern: Pattern<Element>, with replacement: C) -> Self where C.Element == Self.Element {
        return nonmutatingVariant(of: Self.replaceMatches, on: self, with: (pattern, replacement))
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.replacingMatches(for:with:)_]
    /// Returns a collection formed by replacing each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    @_inlineable public func replacingMatches<C : Collection>(for pattern: CompositePattern<Element>, with replacement: C) -> Self where C.Element == Self.Element {
        return nonmutatingVariant(of: Self.replaceMatches, on: self, with: (pattern, replacement))
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.replacingMatches(for:with:)_]
    /// Returns a collection formed by replacing each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    @_inlineable public func replacingMatches<P : Collection, C : Collection>(for pattern: P, with replacement: C) -> Self where P.Element == Self.Element, C.Element == Self.Element {
        return nonmutatingVariant(of: Self.replaceMatches, on: self, with: (pattern, replacement))
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.replacingMatches(for:with:)_]
    /// Returns a collection formed by replacing each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    @_inlineable public func replacingMatches(for pattern: Self, with replacement: Self) -> Self {
        return nonmutatingVariant(of: Self.replaceMatches, on: self, with: (pattern, replacement))
    }

    // [_Define Documentation: SDGCornerstone.Collection.mutateMatches(for:mutation:)_]
    /// Mutates each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - mutation: A closure that generates a replacement collection from a match.
    @_inlineable public mutating func mutateMatches<C : Collection>(for pattern: Pattern<Element>, mutation: (_ match: PatternMatch<Self>) -> C) where C.Element == Self.Element {

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
    @_transparent public mutating func mutateMatches<C : Collection>(for pattern: CompositePattern<Element>, mutation: (_ match: PatternMatch<Self>) -> C) where C.Element == Self.Element {
        mutateMatches(for: pattern as Pattern<Element>, mutation: mutation)
    }

    @_inlineable @_versioned internal mutating func _mutateMatches<P : Collection, C : Collection>(for pattern: P, mutation: (_ match: PatternMatch<Self>) -> C) where P.Element == Self.Element, C.Element == Self.Element {

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
    @_transparent public mutating func mutateMatches<P : Collection, C : Collection>(for pattern: P, mutation: (_ match: PatternMatch<Self>) -> C) where P.Element == Self.Element, C.Element == Self.Element {
        _mutateMatches(for: pattern, mutation: mutation)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.mutateMatches(for:mutation:)_]
    /// Mutates each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - mutation: A closure that generates a replacement collection from a match.
    @_transparent public mutating func mutateMatches<C : Collection>(for pattern: Self, mutation: (_ match: PatternMatch<Self>) -> C) where C.Element == Self.Element {
        _mutateMatches(for: pattern, mutation: mutation)
    }

    // [_Define Documentation: SDGCornerstone.Collection.mutatingMatches(for:mutation:)_]
    /// Returns a collection formed by mutating each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    @_inlineable public func mutatingMatches<C : Collection>(for pattern: Pattern<Element>, mutation: (_ match: PatternMatch<Self>) -> C) -> Self where C.Element == Self.Element {
        var copy = self
        copy.mutateMatches(for: pattern, mutation: mutation)
        return copy
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.mutatingMatches(for:mutation:)_]
    /// Returns a collection formed by mutating each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    @_inlineable public func mutatingMatches<C : Collection>(for pattern: CompositePattern<Element>, mutation: (_ match: PatternMatch<Self>) -> C) -> Self where C.Element == Self.Element {
        var copy = self
        copy.mutateMatches(for: pattern, mutation: mutation)
        return copy
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.mutatingMatches(for:mutation:)_]
    /// Returns a collection formed by mutating each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    @_inlineable public func mutatingMatches<P : Collection, C : Collection>(for pattern: P, mutation: (_ match: PatternMatch<Self>) -> C) -> Self where P.Element == Self.Element, C.Element == Self.Element {
        var copy = self
        copy.mutateMatches(for: pattern, mutation: mutation)
        return copy
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.mutatingMatches(for:mutation:)_]
    /// Returns a collection formed by mutating each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    @_inlineable public func mutatingMatches<C : Collection>(for pattern: Self, mutation: (_ match: PatternMatch<Self>) -> C) -> Self where C.Element == Self.Element {
        var copy = self
        copy.mutateMatches(for: pattern, mutation: mutation)
        return copy
    }
}

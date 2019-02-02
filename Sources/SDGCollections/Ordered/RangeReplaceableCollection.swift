/*
 RangeReplaceableCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

extension RangeReplaceableCollection {

    // @documentation(SDGCornerstone.RangeReplaceableCollection.init())
    /// Creates a new, empty collection.

    // @documentation(SDGCornerstone.RangeReplaceableCollection.init(_:))
    /// Creates a new instance of a collection containing the elements of a sequence.

    // @documentation(SDGCornerstone.RangeReplaceableCollection.append(contentsOf:))
    /// Appends the contents of the sequence to the end of the collection.
    ///
    /// - Parameters:
    ///     - newElements: The new elements to append.

    @inlinable internal mutating func appendAsCollection<S>(contentsOf newElements: S) where S : Sequence, S.Element == Self.Element {
        append(contentsOf: newElements)
    }
    // #documentation(SDGCornerstone.RangeReplaceableCollection.append(contentsOf:))
    /// Appends the contents of the sequence to the end of the collection.
    ///
    /// - Parameters:
    ///     - newElements: The new elements to append.
    @inlinable public mutating func append(contentsOf newElements: Self) {
        appendAsCollection(contentsOf: newElements)
    }

    // @documentation(SDGCornerstone.RangeReplaceableCollection.insert(contentsOf:at:))
    /// Inserts the contents of the sequence to the specified index.
    ///
    /// - Parameters:
    ///     - newElements: The new elements to insert into the collection.
    ///     - i: The position at which to insert the new elements.

    @inlinable internal mutating func insertAsCollection<S>(contentsOf newElements: S, at i: Self.Index) where S : Collection, S.Element == Self.Element {
        insert(contentsOf: newElements, at: i)
    }
    // #documentation(SDGCornerstone.RangeReplaceableCollection.insert(contentsOf:at:))
    /// Inserts the contents of the sequence to the specified index.
    ///
    /// - Parameters:
    ///     - newElements: The new elements to insert into the collection.
    ///     - i: The position at which to insert the new elements.
    @inlinable public mutating func insert(contentsOf newElements: Self, at i: Self.Index) {
        insertAsCollection(contentsOf: newElements, at: i)
    }

    // @documentation(SDGCornerstone.RangeReplaceableCollection.replaceSubrange(_:with:))
    /// Replaces the specified subrange of elements with the given collection.
    ///
    /// - Parameters:
    ///     - subrange: The subrange of the collection to replace.
    ///     - newElements: The new elements to add to the collection.

    @inlinable internal mutating func replaceSubrangeAsCollection<C>(_ subrange: Range<Index>, with newElements: C) where C : Collection, C.Element == Self.Element {
        replaceSubrange(subrange, with: newElements)
    }
    @inlinable public mutating func replaceSubrange(_ subrange: Range<Index>, with newElements: Self) {
        replaceSubrangeAsCollection(subrange, with: newElements)
    }
    @inlinable internal mutating func replaceSubrangeAsCollection<R, C>(_ subrange: R, with newElements: C) where R : RangeExpression, R.Bound == Self.Index, C : Collection, C.Element == Self.Element {
        replaceSubrange(subrange, with: newElements)
    }
    // #documentation(SDGCornerstone.RangeReplaceableCollection.replaceSubrange(_:with:))
    /// Replaces the specified subrange of elements with the given collection.
    ///
    /// - Parameters:
    ///     - subrange: The subrange of the collection to replace.
    ///     - newElements: The new elements to add to the collection.
    @inlinable public mutating func replaceSubrange<R>(_ subrange: R, with newElements: Self) where R : RangeExpression, R.Bound == Self.Index {
        replaceSubrangeAsCollection(subrange, with: newElements)
    }

    /// Returns a collection formed by appending an element to the end of the collection.
    ///
    /// - Parameters:
    ///     - newElement: The element to append to the collection
    @inlinable public func appending(_ newElement: Self.Element) -> Self {
        return nonmutatingVariant(of: { $0.append($1) }, on: self, with: newElement)
    }

    // @documentation(SDGCornerstone.RangeReplaceableCollectionType.appending(contentsOf:))
    /// Returns a collection formed by appending the contents of another collection to the end of `self`.
    ///
    /// - Parameters:
    ///     - newElements: The elements to append to the collection
    @inlinable public func appending<C : Collection>(contentsOf newElements: C) -> Self where C.Element == Self.Element {
        return nonmutatingVariant(of: { $0.append(contentsOf: $1) }, on: self, with: newElements)
    }

    @inlinable internal func appendingAsCollection<C : Collection>(contentsOf newElements: C) -> Self where C.Element == Self.Element {
        return appending(contentsOf: newElements)
    }
    // #documentation(SDGCornerstone.RangeReplaceableCollectionType.appending(contentsOf:))
    /// Returns a collection formed by appending the contents of another collection to the end of `self`.
    ///
    /// - Parameters:
    ///     - newElements: The elements to append to the collection
    @inlinable public func appending(contentsOf newElements: Self) -> Self {
        return appendingAsCollection(contentsOf: newElements)
    }

    /// Adds an element to the beginning of the collection.
    ///
    /// - Parameters:
    ///     - newElement: The element to prepend to the collection
    @inlinable public mutating func prepend(_ newElement: Self.Element) {
        insert(newElement, at: startIndex)
    }

    // @documentation(SDGCornerstone.RangeReplaceableCollection.prepend(contentsOf:))
    /// Adds the contents of another collection to the beginning of `self`.
    ///
    /// - Parameters:
    ///     - newElements: The elements to prepend to the collection
    @inlinable public mutating func prepend<C : Collection>(contentsOf newElements: C) where C.Element == Self.Element {
        insert(contentsOf: newElements, at: startIndex)
    }

    @inlinable internal mutating func prependAsCollection<C : Collection>(contentsOf newElements: C) where C.Element == Self.Element {
        prepend(contentsOf: newElements)
    }
    // #documentation(SDGCornerstone.RangeReplaceableCollection.prepend(contentsOf:))
    /// Adds the contents of another collection to the beginning of `self`.
    ///
    /// - Parameters:
    ///     - newElements: The elements to prepend to the collection
    @inlinable public mutating func prepend(contentsOf newElements: Self) {
        prependAsCollection(contentsOf: newElements)
    }

    /// Returns a collection formed by prepending an element to the beginning of the collection.
    ///
    /// - Parameters:
    ///     - newElement: The element to prepend to the collection
    @inlinable public func prepending(_ newElement: Self.Element) -> Self {
        return nonmutatingVariant(of: { $0.prepend($1) }, on: self, with: newElement)
    }

    // @documentation(SDGCornerstone.RangeReplaceableCollection.prepending(contentsOf:))
    /// Returns a collection formed by prepending the contents of another collection to the beginning of `self`.
    ///
    /// - Parameters:
    ///     - newElements: The elements to prepend to the collection
    @inlinable public func prepending<C : Collection>(contentsOf newElements: C) -> Self where C.Element == Self.Element {
        return nonmutatingVariant(of: { $0.prepend(contentsOf: $1) }, on: self, with: newElements)
    }

    @inlinable internal func prependingAsCollection<C : Collection>(contentsOf newElements: C) -> Self where C.Element == Self.Element {
        return prepending(contentsOf: newElements)
    }
    // #documentation(SDGCornerstone.RangeReplaceableCollection.prepend(contentsOf:))
    /// Adds the contents of another collection to the beginning of `self`.
    ///
    /// - Parameters:
    ///     - newElements: The elements to prepend to the collection
    @inlinable public func prepending(contentsOf newElements: Self) -> Self {
        return prependingAsCollection(contentsOf: newElements)
    }

    /// Truncates the `self` at `index`.
    ///
    /// - Parameters:
    ///     - index: The index at which to truncate.
    @inlinable public mutating func truncate(at index: Index) {
        removeSubrange(index...)
    }

    /// Returns a collection formed by truncating `self` at `index`.
    ///
    /// - Parameters:
    ///     - index: The index at which to truncate.
    @inlinable public func truncated(at index: Index) -> Self {
        return nonmutatingVariant(of: { $0.truncate(at: $1) }, on: self, with: index)
    }

    /// Fills the collection to a certain count.
    ///
    /// - Parameters:
    ///     - count: The target count.
    ///     - element: The element with which to fill the collection.
    ///     - direction: The direction from which to fill the collection.
    @inlinable public mutating func fill(to count: Int, with element: Element, from direction: FillDirection) {
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
    @inlinable public func filled(to count: Int, with element: Element, from direction: FillDirection) -> Self {
        return nonmutatingVariant(of: { $0.fill(to: $1, with: $2, from: $3) }, on: self, with: (count, element, direction))
    }

    /// Shuffles the collection.
    @inlinable public mutating func shuffle() {
        var generator = SystemRandomNumberGenerator()
        shuffle(using: &generator)
    }

    /// Shuffles the collection.
    ///
    /// - Parameters:
    ///     - generator: A particular randomizer to use. (A `PseudorandomNumberGenerator` by default.)
    @inlinable public mutating func shuffle<R>(using generator: inout R) where R : RandomNumberGenerator {
        self = Self(shuffled(using: &generator))
    }

    // MARK: - ExpressibleByArrayLiteral

    // #documentation(SDGCornerstone.ExpressibleByArrayLiteral.init(arrayLiteral:))
    /// Creates an instance from an array literal.
    ///
    /// - Parameters:
    ///     - arrayLiteral: The array literal.
    @inlinable public init(arrayLiteral: Element...) {
        self.init()
        append(contentsOf: arrayLiteral)
    }
}

/*
 StrictString.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A string that maintains Unicode normalization form NFKD.
public struct StrictString : Addable, BidirectionalCollection, Collection, Comparable, Equatable, ExpressibleByStringLiteral, Hashable, RangeReplaceableCollection, StringFamily, UnicodeScalarView, TextOutputStream, TextOutputStreamable, TextualPlaygroundDisplay {

    // MARK: - Initialization

    @inlinable internal init(unsafeString: String) {
        self.string = unsafeString
    }

    /// Creates a string from a scalar.
    @inlinable public init(_ scalar: Unicode.Scalar) {
        self.init(String(scalar))
    }

    /// Creates a string from an extended grapheme cluster.
    @inlinable public init(_ cluster: ExtendedGraphemeCluster) {
        self.init(String(cluster))
    }

    /// Creates a string from a `String`.
    @inlinable public init(_ string: String) {
        self.string = StrictString.normalizeAsString(string)
    }

    /// Creates a string from a `StaticString`.
    @inlinable public init(_ string: StaticString) {
        self.init("\(string)")
    }

    /// Creates a string from a `StrictString`.
    @inlinable public init(_ string: StrictString) {
        self = string
    }

    // #documentation(SDGCornerstone.StringFamily.init(clusters:))
    /// Creates a string from a collection of clusters.
    @inlinable public init(_ clusters: ClusterView) {
        self = clusters.string
    }

    // MARK: - Properties

    @usableFromInline internal var string: String

    // MARK: - Normalization

    @inlinable internal static func normalizeAsString(_ string: String) -> String {
        return string.decomposedStringWithCompatibilityMapping
    }

    @inlinable internal static func normalize(_ string: String) -> StrictString {
        return StrictString(unsafeString: normalizeAsString(string))
    }

    @inlinable internal static func normalize(_ scalars: String.ScalarView) -> StrictString {
        return normalize(String(scalars))
    }

    @inlinable internal static func normalize<S : Sequence>(_ sequence: S) -> StrictString where S.Element == UnicodeScalar {
        switch sequence {

        // Already normalized.
        case let strict as StrictString:
            return strict
        case let strictSlice as Slice<StrictString>:
            return StrictString(unsafeString: String(strictSlice.base.string.scalars[strictSlice.bounds]))

        // Need normalization.
        case let nonStrictScalars as String.ScalarView:
            return normalize(nonStrictScalars)
        default:
            return normalize(String.ScalarView(sequence))
        }
    }

    // MARK: - Addable

    @inlinable public static func += (precedingValue: inout StrictString, followingValue: StrictString) {
        precedingValue.append(contentsOf: followingValue)
    }

    // MARK: - BidirectionalCollection

    // #documentation(SDGCornerstone.BidirectionalCollection.index(before:))
    /// Returns the index immediately before the specified index.
    ///
    /// - Parameters:
    ///     - i: The following index.
    @inlinable public func index(before i: String.ScalarView.Index) -> String.ScalarView.Index {
        return string.scalars.index(before: i)
    }

    // MARK: - Codable

    @inlinable public func encode(to encoder: Encoder) throws {
        try encode(to: encoder, via: description)
    }

    @inlinable public init(from decoder: Decoder) throws {
        try self.init(from: decoder, via: String.self, convert: { StrictString($0) })
    }

    // MARK: - Collection

    // #documentation(SDGCornerstone.Collection.startIndex)
    /// The position of the first element in a non‐empty collection.
    @inlinable public var startIndex: String.ScalarView.Index {
        return string.scalars.startIndex
    }

    // #documentation(SDGCornerstone.Collection.endIndex)
    /// The position following the last valid index.
    @inlinable public var endIndex: String.ScalarView.Index {
        return string.scalars.endIndex
    }

    // #documentation(SDGCornerstone.Collection.index(after:))
    /// Returns the index immediately after the specified index.
    ///
    /// - Parameters:
    ///     - i: The preceding index.
    @inlinable public func index(after i: String.ScalarView.Index) -> String.ScalarView.Index {
        return string.scalars.index(after: i)
    }

    // #documentation(SDGCornerstone.Collection.subscript(position:))
    /// Accesses the element at the specified position.
    @inlinable public subscript(position: String.ScalarView.Index) -> UnicodeScalar {
        return string.scalars[position]
    }

    // MARK: - Comparable

    @inlinable public static func < (precedingValue: StrictString, followingValue: StrictString) -> Bool {
        return precedingValue.string < followingValue.string
    }

    // MARK: - CustomStringConvertible

    @inlinable public var description: String {
        return string
    }

    // MARK: - Equatable

    @inlinable public static func == (precedingValue: StrictString, followingValue: StrictString) -> Bool {
        return precedingValue.string.scalars.elementsEqual(followingValue.string.scalars)
    }

    // MARK: - ExpressibleByStringLiteral

    // #documentation(SDGCornerstone.ExpressibleByStringLiteral.init(stringLiteral:))
    /// Creates an instance from a string literal.
    ///
    /// - Parameters:
    ///     - stringLiteral: The string literal.
    @inlinable public init(stringLiteral: String) {
        self.init(stringLiteral)
    }

    // MARK: - Hashable

    // #documentation(SDGCornerstone.Hashable.hash(into:))
    /// Hashes the essential components of this value by feeding them into the given hasher.
    @inlinable public func hash(into hasher: inout Hasher) {
        hasher.combine(string)
    }

    // MARK: - RangeReplaceableCollection

    // #documentation(SDGCornerstone.RangeReplaceableCollection.init())
    /// Creates a new, empty collection.
    @inlinable public init() {
        self.init(unsafeString: String())
    }

    // #documentation(SDGCornerstone.RangeReplaceableCollection.init(_:))
    /// Creates a new instance of a collection containing the elements of a sequence.
    @inlinable public init<S : Sequence>(_ elements: S) where S.Element == Element {
        self = StrictString.normalize(elements)
    }

    @inlinable internal static func concatenateStrictStrings(_ first: StrictString, _ second: StrictString) -> StrictString {

        if first.isEmpty {
            return second
        } else if second.isEmpty {
            return first
        } else {

            var firstString = first.string
            let previousCluster = firstString.clusters.removeLast()

            var secondString = second.string
            let nextCluster = secondString.clusters.removeFirst()

            // Allow combining characters to re‐order accross the boundary.
            let nearbyClusters = normalizeAsString(String(previousCluster) + String(nextCluster))

            var result = firstString
            result.append(nearbyClusters)
            result.append(secondString)

            return StrictString(unsafeString: result)
        }
    }

    // #documentation(SDGCornerstone.RangeReplaceableCollection.append(contentsOf:))
    /// Appends the contents of the sequence to the end of the collection.
    ///
    /// - Parameters:
    ///     - newElements: The new elements to append.
    @inlinable public mutating func append<S : Sequence>(contentsOf newElements: S) where S.Element == UnicodeScalar {
        self = StrictString.concatenateStrictStrings(self, StrictString.normalize(newElements))
    }

    // #documentation(SDGCornerstone.RangeReplaceableCollection.insert(contentsOf:at:))
    /// Inserts the contents of the sequence to the specified index.
    ///
    /// - Parameters:
    ///     - newElements: The new elements to insert into the collection.
    ///     - i: The position at which to insert the new elements.
    @inlinable public mutating func insert<S : Sequence>(contentsOf newElements: S, at i: String.ScalarView.Index) where S.Element == UnicodeScalar {
        replaceSubrange(i ..< i, with: newElements)
    }

    // #documentation(SDGCornerstone.RangeReplaceableCollection.replaceSubrange(_:with:))
    /// Replaces the specified subrange of elements with the given collection.
    ///
    /// - Parameters:
    ///     - subrange: The subrange of the collection to replace.
    ///     - newElements: The new elements to add to the collection.
    @inlinable public mutating func replaceSubrange<S : Sequence>(_ subrange: Range<String.ScalarView.Index>, with newElements: S) where S.Element == UnicodeScalar {

        let preceding = StrictString(unsafeString: String(string.scalars[..<subrange.lowerBound]))
        let succeeding = StrictString(unsafeString: String(string.scalars[subrange.upperBound...]))
        let replacement = StrictString.normalize(newElements)

        let throughNew = StrictString.concatenateStrictStrings(preceding, replacement)
        self = StrictString.concatenateStrictStrings(throughNew, succeeding)
    }

    // MARK: - StringFamily

    // #documentation(SDGCornerstone.StringFamily.scalars)
    /// A view of a string’s contents as a collection of Unicode scalars.
    @inlinable public var scalars: StrictString {
        get {
            return self
        }
        set {
            self = newValue
        }
    }

    // #documentation(SDGCornerstone.StringFamily.clusters)
    /// A view of a string’s contents as a collection of extended grapheme clusters.
    @inlinable public var clusters: ClusterView {
        get {
            return ClusterView(self)
        }
        set {
            self = newValue.string
        }
    }

    // MARK: - TextOutputStream

    // #documentation(SDGCornerstone.TextOutputStream.write(_:))
    /// Appends the given string to the stream.
    @inlinable public mutating func write(_ string: String) {
        self.append(contentsOf: string.scalars)
    }

    // MARK: - TextOutputStreamable

    // #documentation(SDGCornerstone.TextOutputStreamable.write(to:))
    /// Writes a textual representation of this instance into the given output stream.
    @inlinable public func write<Target>(to target: inout Target) where Target : TextOutputStream {
        target.write(string)
    }
}

/*
 StrictString.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A string that maintains Unicode normalization form NFKD.
public struct StrictString : Addable, BidirectionalCollection, Collection, Comparable, Equatable, ExpressibleByStringLiteral, Hashable, RangeReplaceableCollection, StringFamily, UnicodeScalarView, TextOutputStream, TextOutputStreamable, TextualPlaygroundDisplay {

    // MARK: - Initialization

    @_inlineable @_versioned internal init(unsafeString: String) {
        self.string = unsafeString
    }

    /// Creates a string from a scalar.
    @_inlineable public init(_ scalar: Unicode.Scalar) {
        self.init(String(scalar))
    }

    /// Creates a string from an extended grapheme cluster.
    @_inlineable public init(_ cluster: ExtendedGraphemeCluster) {
        self.init(String(cluster))
    }

    /// Creates a string from a `String`.
    @_inlineable public init(_ string: String) {
        self.string = StrictString.normalizeAsString(string)
    }

    /// Creates a string from a `StaticString`.
    @_inlineable public init(_ string: StaticString) {
        self.init("\(string)")
    }

    /// Creates a string from a `StrictString`.
    @_inlineable public init(_ string: StrictString) {
        self = string
    }

    // #documentation(SDGCornerstone.StringFamily.init(clusters:))
    /// Creates a string from a collection of clusters.
    @_inlineable public init(_ clusters: ClusterView) {
        self = clusters.string
    }

    // MARK: - Properties

    @_versioned internal var string: String

    // MARK: - Normalization

    @_inlineable @_versioned internal static func normalizeAsString(_ string: String) -> String {
        return string.decomposedStringWithCompatibilityMapping
    }

    @_inlineable @_versioned internal static func normalize(_ string: String) -> StrictString {
        return StrictString(unsafeString: normalizeAsString(string))
    }

    @_inlineable @_versioned internal static func normalize(_ scalars: String.ScalarView) -> StrictString {
        return normalize(String(scalars))
    }

    @_inlineable @_versioned internal static func normalize<S : Sequence>(_ sequence: S) -> StrictString where S.Element == UnicodeScalar {
        switch sequence {

        // Already normalized.
        case let strict as StrictString :
            return strict
        case let strictSlice as Slice<StrictString> :
            return StrictString(unsafeString: String(strictSlice.base.string.scalars[strictSlice.bounds]))

        // Need normalization.
        case let nonStrictScalars as String.ScalarView :
            return normalize(nonStrictScalars)
        default:
            return normalize(String.ScalarView(sequence))
        }
    }

    // MARK: - Addable

    // #documentation(SDGCornerstone.Addable.+=)
    /// Adds or concatenates the following value to the preceding value, or performs a similar operation implied by the “+” symbol. Exact behaviour depends on the type.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to add.
    @_inlineable public static func += (precedingValue: inout StrictString, followingValue: StrictString) {
        precedingValue.append(contentsOf: followingValue)
    }

    // MARK: - BidirectionalCollection

    // #documentation(SDGCornerstone.BidirectionalCollection.index(before:))
    /// Returns the index immediately before the specified index.
    ///
    /// - Parameters:
    ///     - i: The following index.
    @_inlineable public func index(before i: String.ScalarView.Index) -> String.ScalarView.Index {
        return string.scalars.index(before: i)
    }

    // MARK: - Codable

    // #documentation(SDGCornerstone.Encodable.encode(to:))
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    @_inlineable public func encode(to encoder: Encoder) throws {
        try encode(to: encoder, via: description)
    }

    // #documentation(SDGCornerstone.Decodable.init(from:))
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    @_inlineable public init(from decoder: Decoder) throws {
        try self.init(from: decoder, via: String.self, convert: { StrictString($0) })
    }

    // MARK: - Collection

    // #documentation(SDGCornerstone.Collection.startIndex)
    /// The position of the first element in a non‐empty collection.
    @_inlineable public var startIndex: String.ScalarView.Index {
        return string.scalars.startIndex
    }

    // #documentation(SDGCornerstone.Collection.endIndex)
    /// The position following the last valid index.
    @_inlineable public var endIndex: String.ScalarView.Index {
        return string.scalars.endIndex
    }

    // #documentation(SDGCornerstone.Collection.index(after:))
    /// Returns the index immediately after the specified index.
    ///
    /// - Parameters:
    ///     - i: The preceding index.
    @_inlineable public func index(after i: String.ScalarView.Index) -> String.ScalarView.Index {
        return string.scalars.index(after: i)
    }

    // #documentation(SDGCornerstone.Collection.subscript(position:))
    /// Accesses the element at the specified position.
    @_inlineable public subscript(position: String.ScalarView.Index) -> UnicodeScalar {
        return string.scalars[position]
    }

    // MARK: - Comparable

    // #documentation(SDGCornerstone.Comparable.<)
    /// Returns `true` if the preceding value is less than the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    @_inlineable public static func < (precedingValue: StrictString, followingValue: StrictString) -> Bool {
        return precedingValue.string < followingValue.string
    }

    // MARK: - CustomStringConvertible

    // #documentation(SDGCornerstone.CustomStringConvertible.description)
    /// A textual representation of the instance.
    @_inlineable public var description: String {
        return string
    }

    // MARK: - Equatable

    // #documentation(SDGCornerstone.Equatable.==)
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    @_inlineable public static func == (precedingValue: StrictString, followingValue: StrictString) -> Bool {
        return precedingValue.string.scalars.elementsEqual(followingValue.string.scalars)
    }

    // MARK: - ExpressibleByStringLiteral

    // #documentation(SDGCornerstone.ExpressibleByStringLiteral.init(stringLiteral:))
    /// Creates an instance from a string literal.
    ///
    /// - Parameters:
    ///     - stringLiteral: The string literal.
    @_inlineable public init(stringLiteral: String) {
        self.init(stringLiteral)
    }

    // MARK: - Hashable

    // #documentation(SDGCornerstone.Hashable.hashValue)
    /// The hash value.
    public var hashValue: Int {
        return string.hashValue
    }

    // MARK: - RangeReplaceableCollection

    // #documentation(SDGCornerstone.RangeReplaceableCollection.init())
    /// Creates a new, empty collection.
    @_inlineable public init() {
        self.init(unsafeString: String())
    }

    // #documentation(SDGCornerstone.RangeReplaceableCollection.init(_:))
    /// Creates a new instance of a collection containing the elements of a sequence.
    @_inlineable public init<S : Sequence>(_ elements: S) where S.Element == Element {
        self = StrictString.normalize(elements)
    }

    @_inlineable @_versioned internal static func concatenateStrictStrings(_ first: StrictString, _ second: StrictString) -> StrictString {

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
    @_inlineable public mutating func append<S : Sequence>(contentsOf newElements: S) where S.Element == UnicodeScalar {
        self = StrictString.concatenateStrictStrings(self, StrictString.normalize(newElements))
    }

    // #documentation(SDGCornerstone.RangeReplaceableCollection.insert(contentsOf:at:))
    /// Inserts the contents of the sequence to the specified index.
    @_inlineable public mutating func insert<S : Sequence>(contentsOf newElements: S, at i: String.ScalarView.Index) where S.Element == UnicodeScalar {
        replaceSubrange(i ..< i, with: newElements)
    }

    // #documentation(SDGCornerstone.RangeReplaceableCollection.replaceSubrange(_:with:))
    /// Replaces the specified subrange of elements with the given collection.
    @_inlineable public mutating func replaceSubrange<S : Sequence>(_ subrange: Range<String.ScalarView.Index>, with newElements: S) where S.Element == UnicodeScalar {

        let preceding = StrictString(unsafeString: String(string.scalars[string.scalars.startIndex ..< subrange.lowerBound]))
        let succeeding = StrictString(unsafeString: String(string.scalars[subrange.upperBound...]))
        let replacement = StrictString.normalize(newElements)

        let throughNew = StrictString.concatenateStrictStrings(preceding, replacement)
        self = StrictString.concatenateStrictStrings(throughNew, succeeding)
    }

    // MARK: - StringFamily

    // #documentation(SDGCornerstone.StringFamily.scalars)
    /// A view of a string’s contents as a collection of Unicode scalars.
    @_inlineable public var scalars: StrictString {
        get {
            return self
        }
        set {
            self = newValue
        }
    }

    // #documentation(SDGCornerstone.StringFamily.clusters)
    /// A view of a string’s contents as a collection of extended grapheme clusters.
    @_inlineable public var clusters: ClusterView {
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
    @_inlineable public mutating func write(_ string: String) {
        self.append(contentsOf: string.scalars)
    }

    // MARK: - TextOutputStreamable

    // #documentation(SDGCornerstone.TextOutputStreamable.write(to:))
    /// Writes a textual representation of this instance into the given output stream.
    @_inlineable public func write<Target>(to target: inout Target) where Target : TextOutputStream {
        target.write(string)
    }
}

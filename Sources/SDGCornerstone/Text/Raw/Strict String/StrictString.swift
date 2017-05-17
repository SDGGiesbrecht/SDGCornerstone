/*
 StrictString.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

/// A string that maintains Unicode normalization form NFKD.
public struct StrictString : BidirectionalCollection, Collection, Equatable, ExpressibleByStringLiteral, ExpressibleByTextLiterals, Hashable, RangeReplaceableCollection, StringFamily, UnicodeScalarView, TextOutputStream, TextOutputStreamable {

    // MARK: - Initialization

    internal init(unsafeString: String) {
        self.string = unsafeString
    }

    /// Creates a string from a scalar.
    public init(_ scalar: UnicodeScalar) {
        self.init(String(scalar))
    }

    /// Creates a string from an extended grapheme cluster.
    public init(_ cluster: Character) {
        self.init(String(cluster))
    }

    /// Creates a string from a `String`.
    public init(_ string: String) {
        self.string = StrictString.normalizeAsString(string)
    }

    /// Creates a string from a `StrictString`.
    public init(_ string: StrictString) {
        self = string
    }

    // [_Inherit Documentation: SDGCornerstone.StringFamily.init(clusters:)_]
    /// Creates a string from a collection of clusters.
    public init(_ clusters: ClusterView) {
        self = clusters.string
    }

    // MARK: - Properties

    internal var string: String

    // MARK: - Normalization

    private static func normalizeAsString(_ string: String) -> String {
        return string.decomposedStringWithCompatibilityMapping
    }

    private static func normalize(_ string: String) -> StrictString {
        return StrictString(unsafeString: normalizeAsString(string))
    }

    private static func normalize(_ scalars: String.UnicodeScalarView) -> StrictString {
        return normalize(String(scalars))
    }

    private static func normalize<S : Sequence>(_ sequence: S) -> StrictString where S.Iterator.Element == UnicodeScalar {
        switch sequence {

        // Already normalized.
        case let strict as StrictString :
            return strict
        case let strictSlice as Slice<StrictString> :
            return StrictString(unsafeString: String(strictSlice.base.string.scalars[strictSlice.startIndex ..< strictSlice.endIndex]))

        // Need normalization.
        case let nonStrictScalars as String.UnicodeScalarView :
            return normalize(nonStrictScalars)
        default:
            return normalize(String.UnicodeScalarView(sequence))
        }
    }

    // MARK: - BidirectionalCollection

    // [_Inherit Documentation: SDGCornerstone.BidirectionalCollection.index(before:)_]
    /// Returns the index immediately before the specified index.
    ///
    /// - Parameters:
    ///     - i: The following index.
    public func index(before i: String.UnicodeScalarView.Index) -> String.UnicodeScalarView.Index {
        return string.scalars.index(before: i)
    }

    // MARK: - Collection

    // [_Inherit Documentation: SDGCornerstone.Collection.startIndex_]
    /// The position of the first element in a non‐empty collection.
    public var startIndex: String.UnicodeScalarView.Index {
        return string.scalars.startIndex
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.endIndex_]
    /// The position following the last valid index.
    public var endIndex: String.UnicodeScalarView.Index {
        return string.scalars.endIndex
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.index(after:)_]
    /// Returns the index immediately after the specified index.
    ///
    /// - Parameters:
    ///     - i: The preceding index.
    public func index(after i: String.UnicodeScalarView.Index) -> String.UnicodeScalarView.Index {
        return string.scalars.index(after: i)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.subscript(position:)_]
    /// Accesses the element at the specified position.
    public subscript(position: String.UnicodeScalarView.Index) -> UnicodeScalar {
        return string.scalars[position]
    }

    // MARK: - CustomStringConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomStringConvertible.description_]
    /// A textual representation of the instance.
    public var description: String {
        return string
    }

    // MARK: - Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - lhs: A value to compare.
    ///     - rhs: Another value to compare.
    public static func == (lhs: StrictString, rhs: StrictString) -> Bool {
        return lhs.string.scalars.elementsEqual(rhs.string.scalars)
    }

    // MARK: - ExpressibleByStringLiteral

    // [_Inherit Documentation: SDGCornerstone.ExpressibleByStringLiteral.init(stringLiteral:)_]
    /// Creates an instance from a string literal.
    public init(stringLiteral: String) {
        self.init(stringLiteral)
    }

    // MARK: - Hashable

    // [_Inherit Documentation: SDGCornerstone.Hashable.hashValue_]
    /// The hash value.
    public var hashValue: Int {
        return string.hashValue
    }

    // MARK: - RangeReplaceableCollection

    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.init()_]
    /// Creates a new, empty collection.
    public init() {
        self.init(unsafeString: String())
    }

    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.init(_:)_]
    /// Creates a new instance of a collection containing the elements of a sequence.
    public init<S : Sequence>(_ elements: S) where S.Iterator.Element == Iterator.Element {
        self = StrictString.normalize(elements)
    }

    private static func concatenateStrictStrings(_ first: StrictString, _ second: StrictString) -> StrictString {

        if first.isEmpty {
            return second
        } else if second.isEmpty {
            return first
        } else {

            var firstString = first.string
            let previousCharacter = firstString.clusters.removeLast()

            var secondString = second.string
            let nextCharacter = secondString.clusters.removeFirst()

            // Allow combining characters to re‐order accross the boundary.
            let nearbyCharacters = normalizeAsString(String(previousCharacter) + String(nextCharacter))

            var result = firstString
            result.append(nearbyCharacters)
            result.append(secondString)

            return StrictString(unsafeString: result)
        }
    }

    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.append(contentsOf:)_]
    /// Appends the contents of the sequence to the end of the collection.
    public mutating func append<S : Sequence>(contentsOf newElements: S) where S.Iterator.Element == UnicodeScalar {
        self = StrictString.concatenateStrictStrings(self, StrictString.normalize(newElements))
    }

    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.insert(contentsOf:at:)_]
    /// Inserts the contents of the sequence to the specified index.
    public mutating func insert<S : Sequence>(contentsOf newElements: S, at i: String.UnicodeScalarView.Index) where S.Iterator.Element == UnicodeScalar {
        replaceSubrange(i ..< i, with: newElements)
    }

    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.replaceSubrange(_:with:)_]
    /// Replaces the specified subrange of elements with the given collection.
    public mutating func replaceSubrange<S : Sequence>(_ subrange: Range<String.UnicodeScalarView.Index>, with newElements: S) where S.Iterator.Element == UnicodeScalar {

        let preceding = StrictString(unsafeString: String(string.scalars[string.scalars.startIndex ..< subrange.lowerBound]))
        let succeeding = StrictString(unsafeString: String(string.scalars[subrange.upperBound ..< string.scalars.endIndex]))
        let replacement = StrictString.normalize(newElements)

        let throughNew = StrictString.concatenateStrictStrings(preceding, replacement)
        self = StrictString.concatenateStrictStrings(throughNew, succeeding)
    }

    // MARK: - StringFamily

    // [_Inherit Documentation: SDGCornerstone.StringFamily.scalars_]
    /// A view of a string’s contents as a collection of Unicode scalars.
    public var scalars: StrictString {
        get {
            return self
        }
        set {
            self = newValue
        }
    }

    // [_Inherit Documentation: SDGCornerstone.StringFamily.clusters_]
    /// A view of a string’s contents as a collection of extended grapheme clusters.
    public var clusters: ClusterView {
        get {
            return ClusterView(self)
        }
        set {
            self = newValue.string
        }
    }

    // MARK: - TextOutputStream

    // [_Inherit Documentation: SDGCornerstone.TextOutputStream.write(_:)_]
    /// Appends the given string to the stream.
    public mutating func write(_ string: String) {
        self.append(contentsOf: string.scalars)
    }

    // MARK: - TextOutputStreamable

    // [_Inherit Documentation: SDGCornerstone.TextOutputStreamable.write(to:)_]
    /// Writes a textual representation of this instance into the given output stream.
    public func write<Target>(to target: inout Target) where Target : TextOutputStream {
        target.write(string)
    }
}

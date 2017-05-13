/*
 StrictString.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A string that maintains Unicode normalization form NFKD.
public struct StrictString : BidirectionalCollection, Collection, Equatable, ExpressibleByStringLiteral, ExpressibleByTextLiterals, Hashable, RangeReplaceableCollection, TextOutputStream, TextOutputStreamable {

    // MARK: - Initialization

    private init(unsafeString: String) {
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

    // MARK: - Properties

    private var string: String

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
            return StrictString(unsafeString: String(strictSlice.base.string.unicodeScalars[strictSlice.startIndex ..< strictSlice.endIndex]))

        // Need normalization.
        case let nonStrictScalars as String.UnicodeScalarView :
            return normalize(nonStrictScalars)
        default:
            return normalize(String.UnicodeScalarView(sequence))
        }
    }

    // MARK: - BidirectionalCollection

    // [_Inherit Documentation: SDGCornerstone.BidirectionalCollection.index(before:)_]
    public func index(before i: String.UnicodeScalarView.Index) -> String.UnicodeScalarView.Index {
        return string.unicodeScalars.index(before: i)
    }

    // MARK: - Collection

    // [_Inherit Documentation: SDGCornerstone.Collection.startIndex_]
    public var startIndex: String.UnicodeScalarView.Index {
        return string.unicodeScalars.startIndex
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.endIndex_]
    public var endIndex: String.UnicodeScalarView.Index {
        return string.unicodeScalars.endIndex
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.index(after:)_]
    public func index(after i: String.UnicodeScalarView.Index) -> String.UnicodeScalarView.Index {
        return string.unicodeScalars.index(after: i)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.subscript(position:)_]
    public subscript(position: String.UnicodeScalarView.Index) -> UnicodeScalar {
        return string.unicodeScalars[position]
    }

    // MARK: - Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
    public static func == (lhs: StrictString, rhs: StrictString) -> Bool {
        return lhs.string.unicodeScalars.elementsEqual(rhs.string.unicodeScalars)
    }

    // MARK: - ExpressibleByStringLiteral

    // [_Inherit Documentation: SDGCornerstone.ExpressibleByStringLiteral.init(stringLiteral:)_]
    public init(stringLiteral: String) {
        self.init(stringLiteral)
    }

    // MARK: - Hashable

    // [_Inherit Documentation: SDGCornerstone.Hashable.hashValue_]
    public var hashValue: Int {
        return string.hashValue
    }

    // MARK: - RangeReplaceableCollection

    // Interface

    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollectionType.init()_]
    public init() {
        self.init(unsafeString: String())
    }

    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollectionType.init(_:)_]
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
            let previousCharacter = firstString.characters.removeLast()

            var secondString = second.string
            let nextCharacter = secondString.characters.removeFirst()

            // Allow combining characters to re‐order accross the boundary.
            let nearbyCharacters = normalizeAsString(String(previousCharacter) + String(nextCharacter))

            var result = firstString
            result.append(nearbyCharacters)
            result.append(secondString)

            return StrictString(unsafeString: result)
        }
    }

    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollectionType.append(contentsOf:)_]
    public mutating func append<S : Sequence>(contentsOf newElements: S) where S.Iterator.Element == UnicodeScalar {
        self = StrictString.concatenateStrictStrings(self, StrictString.normalize(newElements))
    }

    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollectionType.insert(contentsOf:at:)_]
    public mutating func insert<S : Sequence>(contentsOf newElements: S, at i: String.UnicodeScalarView.Index) where S.Iterator.Element == UnicodeScalar {
        replaceSubrange(i ..< i, with: newElements)
    }

    // [_Inherit Documenation: SDGCornerstone.RangeReplaceableCollection.replaceSubrange(_:with:)_]
    public mutating func replaceSubrange<S : Sequence>(_ subrange: Range<String.UnicodeScalarView.Index>, with newElements: S) where S.Iterator.Element == UnicodeScalar {

        let preceding = StrictString(unsafeString: String(string.unicodeScalars[string.unicodeScalars.startIndex ..< subrange.lowerBound]))
        let succeeding = StrictString(unsafeString: String(string.unicodeScalars[subrange.lowerBound ..< string.unicodeScalars.endIndex]))
        let replacement = StrictString.normalize(newElements)

        let throughNew = StrictString.concatenateStrictStrings(preceding, replacement)
        self = StrictString.concatenateStrictStrings(throughNew, succeeding)
    }

    // MARK: - TextOutputStream

    // [_Inherit Documentation: SDGCornerstone.TextOutputStream.write(_:)_]
    public mutating func write(_ string: String) {
        self.append(contentsOf: string.unicodeScalars)
    }

    // MARK: - TextOutputStreamable

    // [_Inherit Documentation: SDGCornerstone.TextOutputStreamable.write(to:)_]
    public func write<Target>(to target: inout Target) where Target : TextOutputStream {
        target.write(string)
    }
}

/*
 SemanticMarkup.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

// MARK: - Encoding

// [_Define Example: Markup Encoding_]
private let reservedRange: ClosedRange<UnicodeScalar> = "\u{107000}" ... "\u{1070FF}"

private let beginSuperscript: UnicodeScalar = "\u{107000}"
private let endSuperscript: UnicodeScalar = "\u{107001}"
private let beginSubscript: UnicodeScalar = "\u{107002}"
private let endSubscript: UnicodeScalar = "\u{107003}"
// [_End_]

// [_Example 1: Markup Encoding_]
/// Text with additional semantic markup.
///
/// Semantic markup assigns control functions to several private use scalars.
///
/// ```swift
/// private let reservedRange: ClosedRange<UnicodeScalar> = "\u{107000}" ... "\u{1070FF}"
///
/// private let beginSuperscript: UnicodeScalar = "\u{107000}"
/// private let endSuperscript: UnicodeScalar = "\u{107001}"
/// private let beginSubscript: UnicodeScalar = "\u{107002}"
/// private let endSubscript: UnicodeScalar = "\u{107003}"
/// ```
public struct SemanticMarkup : Addable, BidirectionalCollection, Collection, Equatable, ExpressibleByStringLiteral, Hashable, RangeReplaceableCollection {

    // MARK: - Initialization

    /// Creates semantic markup from raw text.
    public init(_ rawText: StrictString) {
        source = rawText
    }

    // MARK: - Properties

    /// The markup source.
    public var source: StrictString

    /// A view of the source as a collection of Unicode scalars.
    public var scalars: StrictString.ScalarView {
        get {
            return source.scalars
        }
        set {
            source.scalars = newValue
        }
    }

    /// A view of the source as a collection of extended grapheme clusters.
    public var clusters: StrictString.ClusterView {
        get {
            return source.clusters
        }
        set {
            source.clusters = newValue
        }
    }

    /// A view of the source as a collection of lines.
    public var lines: LineView<StrictString> {
        get {
            return source.lines
        }
        set {
            source.lines = newValue
        }
    }

    // MARK: - Mutation

    /// Superscripts the string.
    public mutating func superscript() {
        source.prepend(beginSuperscript)
        source.append(endSuperscript)
    }

    /// Returns a string formed by superscripting the instance.
    public func superscripted() -> SemanticMarkup {
        return nonmutatingVariant(of: SemanticMarkup.superscript, on: self)
    }

    /// Subscripts the string.
    public mutating func `subscript`() {
        source.prepend(beginSubscript)
        source.append(endSubscript)
    }

    /// Returns a string formed by subscripting the instance.
    public func subscripted() -> SemanticMarkup {
        return nonmutatingVariant(of: SemanticMarkup.subscript, on: self)
    }

    // MARK: - Output

    /// Returns a raw text approximation by removing all markup.
    ///
    /// - Warning: The removal of markup may break the intended meaning of a string. For example, “32 = 9” no longer means “three squared equals nine”.
    public func rawTextApproximation() -> StrictString {
        return source.replacingMatches(for: ConditionalPattern({ $0 ∈ reservedRange }), with: [])
    }

    // MARK: - Addable

    // [_Inherit Documentation: SDGCornerstone.Addable.+=_]
    /// Adds or concatenates the following value to the preceding value, or performs a similar operation implied by the “+” symbol. Exact behaviour depends on the type.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to add.
    public static func += (precedingValue: inout SemanticMarkup, followingValue: SemanticMarkup) {
        precedingValue.source += followingValue.source
    }

    // MARK: - BidirectionalCollection

    // [_Inherit Documentation: SDGCornerstone.BidirectionalCollection.index(before:)_]
    /// Returns the index immediately before the specified index.
    ///
    /// - Parameters:
    ///     - i: The following index.
    public func index(before i: String.ScalarView.Index) -> String.ScalarView.Index {
        return source.index(before: i)
    }

    // MARK: - Collection

    // [_Inherit Documentation: SDGCornerstone.Collection.startIndex_]
    /// The position of the first element in a non‐empty collection.
    public var startIndex: String.ScalarView.Index {
        return source.startIndex
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.endIndex_]
    /// The position following the last valid index.
    public var endIndex: String.ScalarView.Index {
        return source.endIndex
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.index(after:)_]
    /// Returns the index immediately after the specified index.
    ///
    /// - Parameters:
    ///     - i: The preceding index.
    public func index(after i: String.ScalarView.Index) -> String.ScalarView.Index {
        return source.index(after: i)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.subscript(position:)_]
    /// Accesses the element at the specified position.
    public subscript(position: String.ScalarView.Index) -> UnicodeScalar {
        return source[position]
    }

    // MARK: - Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    public static func == (precedingValue: SemanticMarkup, followingValue: SemanticMarkup) -> Bool {
        return precedingValue.source == followingValue.source
    }

    // MARK: - ExpressibleByStringLiteral

    // [_Inherit Documentation: SDGCornerstone.ExpressibleByStringLiteral.init(stringLiteral:)_]
    /// Creates an instance from a string literal.
    ///
    /// - Parameters:
    ///     - stringLiteral: The string literal.
    public init(stringLiteral: String) {
        self.init(StrictString(stringLiteral))
    }

    // MARK: - Hashable

    // [_Inherit Documentation: SDGCornerstone.Hashable.hashValue_]
    /// The hash value.
    public var hashValue: Int {
        return source.hashValue
    }

    // MARK: - RangeReplaceableCollection

    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.init()_]
    /// Creates a new, empty collection.
    public init() {
        source = ""
    }

    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.init(_:)_]
    /// Creates a new instance of a collection containing the elements of a sequence.
    @_inlineable public init<S : Sequence>(_ elements: S) where S.Element == Element {
        source = StrictString(elements)
    }

    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.append(contentsOf:)_]
    /// Appends the contents of the sequence to the end of the collection.
    @_inlineable public mutating func append<S : Sequence>(contentsOf newElements: S) where S.Element == UnicodeScalar {
        source.append(contentsOf: newElements)
    }

    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.insert(contentsOf:at:)_]
    /// Inserts the contents of the sequence to the specified index.
    @_inlineable public mutating func insert<S : Sequence>(contentsOf newElements: S, at i: String.ScalarView.Index) where S.Element == UnicodeScalar {
        source.insert(contentsOf: newElements, at: i)
    }

    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.replaceSubrange(_:with:)_]
    /// Replaces the specified subrange of elements with the given collection.
    @_inlineable public mutating func replaceSubrange<S : Sequence>(_ subrange: Range<String.ScalarView.Index>, with newElements: S) where S.Element == UnicodeScalar {
        source.replaceSubrange(subrange, with: newElements)
    }
}

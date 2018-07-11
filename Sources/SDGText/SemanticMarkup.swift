/*
 SemanticMarkup.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow

// MARK: - Encoding

// @example(Markup Encoding)
private let reservedRange: ClosedRange<UnicodeScalar> = "\u{107000}" ... "\u{1070FF}"

@_versioned internal let beginSuperscript: UnicodeScalar = "\u{107000}"
@_versioned internal let endSuperscript: UnicodeScalar = "\u{107001}"
@_versioned internal let beginSubscript: UnicodeScalar = "\u{107002}"
@_versioned internal let endSubscript: UnicodeScalar = "\u{107003}"
// @endExample

// #example(1, Markup Encoding)
/// Text with additional semantic markup.
///
/// Semantic markup assigns control functions to several private use scalars.
///
/// ```swift
/// private let reservedRange: ClosedRange<UnicodeScalar> = "\u{107000}" ... "\u{1070FF}"
///
/// @_versioned internal let beginSuperscript: UnicodeScalar = "\u{107000}"
/// @_versioned internal let endSuperscript: UnicodeScalar = "\u{107001}"
/// @_versioned internal let beginSubscript: UnicodeScalar = "\u{107002}"
/// @_versioned internal let endSubscript: UnicodeScalar = "\u{107003}"
/// ```
public struct SemanticMarkup : Addable, BidirectionalCollection, Codable, Collection, Equatable, ExpressibleByStringLiteral, Hashable, RangeReplaceableCollection, SearchableBidirectionalCollection, TextualPlaygroundDisplay {

    // MARK: - Initialization

    /// Creates semantic markup from raw text.
    @_inlineable public init(_ rawText: StrictString) {
        source = rawText
    }

    /// Creates semantic markup from raw text.
    @_inlineable public init(_ rawText: String) {
        source = StrictString(rawText)
    }

    // MARK: - Properties

    /// The markup source.
    public var source: StrictString

    /// A view of the source as a collection of Unicode scalars.
    @_inlineable public var scalars: StrictString.ScalarView {
        get {
            return source.scalars
        }
        set {
            source.scalars = newValue
        }
    }

    /// A view of the source as a collection of extended grapheme clusters.
    @_inlineable public var clusters: StrictString.ClusterView {
        get {
            return source.clusters
        }
        set {
            source.clusters = newValue
        }
    }

    /// A view of the source as a collection of lines.
    @_inlineable public var lines: LineView<StrictString> {
        get {
            return source.lines
        }
        set {
            source.lines = newValue
        }
    }

    // MARK: - Mutation

    /// Superscripts the string.
    @_inlineable public mutating func superscript() {
        source.prepend(beginSuperscript)
        source.append(endSuperscript)
    }

    /// Returns a string formed by superscripting the instance.
    @_inlineable public func superscripted() -> SemanticMarkup {
        return nonmutatingVariant(of: SemanticMarkup.superscript, on: self)
    }

    /// Subscripts the string.
    @_inlineable public mutating func `subscript`() {
        source.prepend(beginSubscript)
        source.append(endSubscript)
    }

    /// Returns a string formed by subscripting the instance.
    @_inlineable public func subscripted() -> SemanticMarkup {
        return nonmutatingVariant(of: SemanticMarkup.subscript, on: self)
    }

    // MARK: - Output

    /// Returns the HTML representation.
    public func html() -> StrictString {
        var html: String = ""
        for scalar in source {
            switch scalar {

            // Escape
            case "&":
                html += "&#x26;"
            case "<":
                html += "&#x3C;"
            case ">":
                html += "&#x3E;"

            // Markup
            case beginSuperscript:
                html += "<sup>"
            case endSuperscript:
                html += "</sup>"
            case beginSubscript:
                html += "<sub>"
            case endSubscript:
                html += "</sub>"

            default:
                html.scalars.append(scalar)
            }
        }
        return StrictString(html)
    }

    #if canImport(AppKit) || canImport(UIKit)
    // MARK: - #if canImport(AppKit) || canImport(UIKit)

    /// Returns the rich text representation.
    public func richText(font: Font) -> NSAttributedString {

        var modified = "<span style=\u{22}"

        modified += "font\u{2D}family: &#x22;" + font.fontName + "&#x22;;"
        modified += "font\u{2D}size: \(font.pointSize)pt;"

        modified += "\u{22}>"
        modified += String(html())
        modified += "</span>"

        let data = modified.data(using: .utf8)!
        do {
            return try NSAttributedString(data: data, options: [
                NSAttributedString.DocumentReadingOptionKey.characterEncoding: NSNumber(value: String.Encoding.utf8.rawValue),
            NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html
            ], documentAttributes: nil)
        } catch {
            preconditionFailure(error.localizedDescription)
        }
    }
    #endif

    /// Returns a raw text approximation by removing all markup.
    ///
    /// - Warning: The removal of markup may break the intended meaning of a string. For example, “32 = 9” no longer means “three squared equals nine”.
    public func rawTextApproximation() -> StrictString {
        return source.replacingMatches(for: ConditionalPattern({ $0 ∈ reservedRange }), with: [])
    }

    // MARK: - Addable

    // #documentation(SDGCornerstone.Addable.+=)
    /// Adds or concatenates the following value to the preceding value, or performs a similar operation implied by the “+” symbol. Exact behaviour depends on the type.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to add.
    @_inlineable public static func += (precedingValue: inout SemanticMarkup, followingValue: SemanticMarkup) {
        precedingValue.source += followingValue.source
    }

    // MARK: - BidirectionalCollection

    // #documentation(SDGCornerstone.BidirectionalCollection.index(before:))
    /// Returns the index immediately before the specified index.
    ///
    /// - Parameters:
    ///     - i: The following index.
    @_inlineable public func index(before i: String.ScalarView.Index) -> String.ScalarView.Index {
        return source.index(before: i)
    }

    // MARK: - Codable

    // #documentation(SDGCornerstone.Decodable.init(from:))
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    @_inlineable public init(from decoder: Decoder) throws {
        try self.init(from: decoder, via: StrictString.self, convert: { SemanticMarkup($0) })
    }

    // #documentation(SDGCornerstone.Encodable.encode(to:))
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    @_inlineable public func encode(to encoder: Encoder) throws {
        try encode(to: encoder, via: source)
    }

    // MARK: - Collection

    // #documentation(SDGCornerstone.Collection.startIndex)
    /// The position of the first element in a non‐empty collection.
    @_inlineable public var startIndex: String.ScalarView.Index {
        return source.startIndex
    }

    // #documentation(SDGCornerstone.Collection.endIndex)
    /// The position following the last valid index.
    @_inlineable public var endIndex: String.ScalarView.Index {
        return source.endIndex
    }

    // #documentation(SDGCornerstone.Collection.index(after:))
    /// Returns the index immediately after the specified index.
    ///
    /// - Parameters:
    ///     - i: The preceding index.
    @_inlineable public func index(after i: String.ScalarView.Index) -> String.ScalarView.Index {
        return source.index(after: i)
    }

    // #documentation(SDGCornerstone.Collection.subscript(position:))
    /// Accesses the element at the specified position.
    @_inlineable public subscript(position: String.ScalarView.Index) -> UnicodeScalar {
        return source[position]
    }

    // MARK: - CustomPlaygroundDisplayConvertible

    // #documentation(SDGCornerstone.CustomPlaygroundDisplayConvertible.playgroundDescription)
    /// Returns the custom playground description for this instance.
    @_inlineable public var playgroundDescription: Any {
        #if canImport(AppKit) || canImport(UIKit)
            return richText(font: Font.systemFont(ofSize: Font.systemSize))
        #else
            return rawTextApproximation()
        #endif
    }

    // MARK: - CustomStringConvertible

    // #documentation(SDGCornerstone.CustomStringConvertible.description)
    /// A textual representation of the instance.
    @_inlineable public var description: String {
        return String(rawTextApproximation())
    }

    // MARK: - Equatable

    // #documentation(SDGCornerstone.Equatable.==)
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    @_inlineable public static func == (precedingValue: SemanticMarkup, followingValue: SemanticMarkup) -> Bool {
        return precedingValue.source == followingValue.source
    }

    // MARK: - ExpressibleByStringLiteral

    // #documentation(SDGCornerstone.ExpressibleByStringLiteral.init(stringLiteral:))
    /// Creates an instance from a string literal.
    ///
    /// - Parameters:
    ///     - stringLiteral: The string literal.
    @_inlineable public init(stringLiteral: String) {
        self.init(StrictString(stringLiteral))
    }

    // MARK: - Hashable

    // #documentation(SDGCornerstone.Hashable.hashValue)
    /// The hash value.
    public var hashValue: Int {
        return source.hashValue
    }

    // MARK: - RangeReplaceableCollection

    // #documentation(SDGCornerstone.RangeReplaceableCollection.init())
    /// Creates a new, empty collection.
    @_inlineable public init() {
        source = ""
    }

    // #documentation(SDGCornerstone.RangeReplaceableCollection.init(_:))
    /// Creates a new instance of a collection containing the elements of a sequence.
    @_inlineable public init<S : Sequence>(_ elements: S) where S.Element == Element {
        source = StrictString(elements)
    }

    // #documentation(SDGCornerstone.RangeReplaceableCollection.append(contentsOf:))
    /// Appends the contents of the sequence to the end of the collection.
    @_inlineable public mutating func append<S : Sequence>(contentsOf newElements: S) where S.Element == UnicodeScalar {
        source.append(contentsOf: newElements)
    }

    // #documentation(SDGCornerstone.RangeReplaceableCollection.insert(contentsOf:at:))
    /// Inserts the contents of the sequence to the specified index.
    @_inlineable public mutating func insert<S : Sequence>(contentsOf newElements: S, at i: String.ScalarView.Index) where S.Element == UnicodeScalar {
        source.insert(contentsOf: newElements, at: i)
    }

    // #documentation(SDGCornerstone.RangeReplaceableCollection.replaceSubrange(_:with:))
    /// Replaces the specified subrange of elements with the given collection.
    @_inlineable public mutating func replaceSubrange<S : Sequence>(_ subrange: Range<String.ScalarView.Index>, with newElements: S) where S.Element == UnicodeScalar {
        source.replaceSubrange(subrange, with: newElements)
    }
}

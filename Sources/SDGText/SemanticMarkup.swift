/*
 SemanticMarkup.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow

// MARK: - Encoding

// @example(markupEncoding)
private let reservedRange: ClosedRange<UnicodeScalar> = "\u{107000}" ... "\u{1070FF}"

@usableFromInline internal let beginSuperscript: UnicodeScalar = "\u{107000}"
@usableFromInline internal let endSuperscript: UnicodeScalar = "\u{107001}"
@usableFromInline internal let beginSubscript: UnicodeScalar = "\u{107002}"
@usableFromInline internal let endSubscript: UnicodeScalar = "\u{107003}"
// @endExample

// #example(1, markupEncoding)
/// Text with additional semantic markup.
///
/// Semantic markup assigns control functions to several private use scalars.
///
/// ```swift
/// private let reservedRange: ClosedRange<UnicodeScalar> = "\u{107000}" ... "\u{1070FF}"
///
/// @usableFromInline internal let beginSuperscript: UnicodeScalar = "\u{107000}"
/// @usableFromInline internal let endSuperscript: UnicodeScalar = "\u{107001}"
/// @usableFromInline internal let beginSubscript: UnicodeScalar = "\u{107002}"
/// @usableFromInline internal let endSubscript: UnicodeScalar = "\u{107003}"
/// ```
public struct SemanticMarkup : Addable, BidirectionalCollection, Collection, Decodable, Encodable, Equatable, ExpressibleByStringInterpolation, ExpressibleByStringLiteral, Hashable, RangeReplaceableCollection, SearchableBidirectionalCollection, TextualPlaygroundDisplay {

    // MARK: - Initialization

    /// Creates semantic markup from raw text.
    @inlinable public init(_ rawText: StrictString) {
        source = rawText
    }

    /// Creates semantic markup from raw text.
    @inlinable public init(_ rawText: String) {
        source = StrictString(rawText)
    }

    // MARK: - Properties

    /// The markup source.
    public var source: StrictString

    /// A view of the source as a collection of Unicode scalars.
    @inlinable public var scalars: StrictString.ScalarView {
        get {
            return source.scalars
        }
        set {
            source.scalars = newValue
        }
    }

    /// A view of the source as a collection of extended grapheme clusters.
    @inlinable public var clusters: StrictString.ClusterView {
        get {
            return source.clusters
        }
        set {
            source.clusters = newValue
        }
    }

    /// A view of the source as a collection of lines.
    @inlinable public var lines: LineView<StrictString> {
        get {
            return source.lines
        }
        set {
            source.lines = newValue
        }
    }

    // MARK: - Mutation

    /// Superscripts the string.
    @inlinable public mutating func superscript() {
        source.prepend(beginSuperscript)
        source.append(endSuperscript)
    }

    /// Returns a string formed by superscripting the instance.
    @inlinable public func superscripted() -> SemanticMarkup {
        return nonmutatingVariant(of: { $0.superscript() }, on: self)
    }

    /// Subscripts the string.
    @inlinable public mutating func `subscript`() {
        source.prepend(beginSubscript)
        source.append(endSubscript)
    }

    /// Returns a string formed by subscripting the instance.
    @inlinable public func subscripted() -> SemanticMarkup {
        return nonmutatingVariant(of: { $0.subscript() }, on: self)
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

    // Exposed for use by SDGInterface.
    public static func _attributedString(from html: String, in font: Font) throws -> NSAttributedString {
        var modified = "<span style=\u{22}"

        modified += "font\u{2D}family: &#x22;" + font.fontName + "&#x22;;"
        modified += "font\u{2D}size: \(font.pointSize)pt;"

        modified += "\u{22}>"
        modified += html
        modified += "</span>"

        let data = modified.data(using: .utf8)!
        return try NSAttributedString(data: data, options: [
            .characterEncoding: NSNumber(value: String.Encoding.utf8.rawValue),
            .documentType: NSAttributedString.DocumentType.html
            ], documentAttributes: nil)
    }

    /// Returns the rich text representation.
    ///
    /// - Parameters:
    ///     - font: The font to use.
    public func richText(font: Font) -> NSAttributedString {
        do {
            return try SemanticMarkup._attributedString(from: String(html()), in: font)
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

    @inlinable public static func += (precedingValue: inout SemanticMarkup, followingValue: SemanticMarkup) {
        precedingValue.source += followingValue.source
    }

    // MARK: - BidirectionalCollection

    @inlinable public func index(before i: String.ScalarView.Index) -> String.ScalarView.Index {
        return source.index(before: i)
    }

    // MARK: - Codable

    @inlinable public init(from decoder: Decoder) throws {
        try self.init(from: decoder, via: StrictString.self, convert: { SemanticMarkup($0) })
    }

    @inlinable public func encode(to encoder: Encoder) throws {
        try encode(to: encoder, via: source)
    }

    // MARK: - Collection

    public typealias Element = Unicode.Scalar

    @inlinable public var startIndex: String.ScalarView.Index {
        return source.startIndex
    }

    @inlinable public var endIndex: String.ScalarView.Index {
        return source.endIndex
    }

    @inlinable public func index(after i: String.ScalarView.Index) -> String.ScalarView.Index {
        return source.index(after: i)
    }

    @inlinable public subscript(position: String.ScalarView.Index) -> Unicode.Scalar {
        return source[position]
    }

    // MARK: - CustomPlaygroundDisplayConvertible

    @inlinable public var playgroundDescription: Any {
        #if canImport(AppKit) || canImport(UIKit)
            return richText(font: Font.systemFont(ofSize: Font.systemSize))
        #else
            return rawTextApproximation()
        #endif
    }

    // MARK: - CustomStringConvertible

    @inlinable public var description: String {
        return String(rawTextApproximation())
    }

    // MARK: - ExpressibleByStringInterpolation

    @inlinable public init(stringInterpolation: StringInterpolation) {
        self = stringInterpolation.semanticMarkup
    }

    // MARK: - ExpressibleByStringLiteral

    @inlinable public init(stringLiteral: String) {
        self.init(StrictString(stringLiteral))
    }

    // MARK: - RangeReplaceableCollection

    @inlinable public init() {
        source = ""
    }

    @inlinable public init<S : Sequence>(_ elements: S) where S.Element == Unicode.Scalar {
        source = StrictString(elements)
    }

    @inlinable public mutating func append<S : Sequence>(contentsOf newElements: S) where S.Element == Unicode.Scalar {
        source.append(contentsOf: newElements)
    }

    @inlinable public mutating func insert<S : Sequence>(contentsOf newElements: S, at i: String.ScalarView.Index) where S.Element == Unicode.Scalar {
        source.insert(contentsOf: newElements, at: i)
    }

    @inlinable public mutating func replaceSubrange<S : Sequence>(_ subrange: Range<String.ScalarView.Index>, with newElements: S) where S.Element == Unicode.Scalar {
        source.replaceSubrange(subrange, with: newElements)
    }
}

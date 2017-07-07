/*
 SemanticMarkup.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

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
/// private let beginSuperscript: UnicodeScalar = "\u{107000}"
/// private let endSuperscript: UnicodeScalar   = "\u{107001}"
/// private let beginSubscript: UnicodeScalar = "\u{107002}"
/// private let endSubscript: UnicodeScalar   = "\u{107003}"
/// ```
public struct SemanticMarkup {

    // MARK: - Initialization

    /// Creates semantic markup from raw text.
    public init(_ rawText: StrictString) {
        source = rawText
    }

    // MARK: - Properties

    /// The markup source.
    public var source: StrictString

    // MARK: - Mutation

    /// Superscripts the string.
    public mutating func superscript() {
        source.prepend(beginSuperscript)
        source.append(endSuperscript)
    }

    /// Returns a string formed by superscripting the instance.
    public func superscripted() -> SemanticMarkup {
        var result = self
        result.superscript()
        return result
    }

    /// Subscripts the string.
    public mutating func `subscript`() {
        source.prepend(beginSubscript)
        source.append(endSubscript)
    }

    /// Returns a string formed by subscripting the instance.
    public func subscripted() -> SemanticMarkup {
        var result = self
        result.subscript()
        return result
    }

    // MARK: - Output

    /// Returns a raw text approximation by removing all markup.
    ///
    /// - Warning: The removal of markup may break the intended meaning of a string. For example, “32 = 9” no longer means “three squared equals nine”.
    public func rawTextApproximation() -> StrictString {
        return source.replacingMatches(for: ConditionalPattern(condition: { $0 ∈ reservedRange }), with: [])
    }
}

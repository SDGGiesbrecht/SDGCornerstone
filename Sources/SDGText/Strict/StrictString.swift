/*
 StrictString.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGMathematics

// @localization(🇩🇪DE) @crossReference(StrictString)
// #example(1, strengeInterpolation)
/// Eine Zeichenkette, die Unicode‐Normalisierungsform NFKD erhält.
///
/// Interpolation benötigt, das Werte in ausdrückliche Textformen umgewandelt sind.
///
/// ```swift
/// var streng: StrengeZeichenkette = ""
///
/// // Typen, die Zeichenketten ähneln können direkt interpoliert werden:
/// let zeichenkette: Zeichenkette = "Hallo, Welt!"
/// let zeichen: Unicode.Skalar = "?"
/// streng = "\(zeichenkette) ...\(zeichen)"
///
/// // Die meisten anderen Typen müssen ausdrücklich in einer bestimmten Textform umgewandelt werden:
/// let zahl = GZahl.zufällige(in: 0...1000)
/// streng =
///   "„\(zahl.inRömischerZahlschrift())“ bedeutet das selbe wie „\(zahl.inZahlzeichen())“."
///
/// // Die Beschreibungen des Swift‐Übersetzers können immer noch ausdrücklich verlangt werden:
/// let etwas: Any = fehlerHolen()
/// streng = "Fehler: \(willkürlicheBeschreibungVon: etwas)"
/// ```
public typealias StrengeZeichenkette = StrictString
// @localization(🇨🇦EN) @crossReference(StrictString)
// #example(1, strictInterpolation)
/// A string that maintains Unicode normalization form NFKD.
///
/// Interpolation requires values to be converted to explicit text representations.
///
/// ```swift
/// var strict: StrictString = ""
///
/// // String‐like types can be interpolated directly:
/// let string: String = "Hello, world!"
/// let character: Unicode.Scalar = "?"
/// strict = "\(string) ...\(character)"
///
/// // Most other types must be explicitly converted to some predictable text representation:
/// let number = Int.random(in: 0...1000)
/// strict = "“\(number.inRomanNumerals())” means the same as “\(number.inDigits())”."
///
/// // The Swift compiler’s own description of any value can still be requested explicitly:
/// let something: Any = getError()
/// strict = "Error: \(arbitraryDescriptionOf: something)"
/// ```
public struct StrictString: Addable, BidirectionalCollection, Collection, Comparable, Equatable,
  ExpressibleByStringInterpolation, ExpressibleByStringLiteral, Hashable,
  RangeReplaceableCollection, StringFamily, UnicodeScalarView, TextOutputStream,
  TextOutputStreamable, TextualPlaygroundDisplay
{

  // MARK: - Static Properties

  /// The algorithm used by `StrictString`’s conformance to `Comparable`.
  ///
  /// Change this property to modify the collation order of `StrictString` instances. It corresponds to the `<` operator.
  ///
  /// The default order is merely the fastest—simply to delegating the order to the `String` type and its `<` function. This is sufficient for many programming internals, but is unsatisfactory for sorted lists displayed to users.
  ///
  /// A unified international order intended for displayed human text is provided in `SDGCollation`. To use it globally, set this property to `{ CollationOrder.root.stringsAreOrderedAscending($0, $1) }`.
  ///
  /// - Important: Changing this invalidates any existing sorted data. Care should be taken if changes need to be made after an application has already done some work.
  ///
  /// - Parameters:
  ///     - precedingValue: The preceding string.
  /// 	- followingValue: The following string.
  public static var sortAlgorithm:
    (_ precedingValue: StrictString, _ followingValue: StrictString) -> Bool = {
      return $0.string < $1.string
    }

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

  /// Creates a string from a strict `ClusterView`.
  @inlinable public init(_ clusters: ClusterView) {
    self = clusters.string
  }

  // MARK: - Properties

  @usableFromInline internal var string: String

  // MARK: - Normalization

  @inlinable internal static func normalizeAsString(_ string: String) -> String {
    // #workaround(workspace version 0.32.0, Web doesn’t have Foundation yet.)
    #if os(WASI)
      return string
    #else
      return string.decomposedStringWithCompatibilityMapping
    #endif
  }

  @inlinable internal static func normalize(_ string: String) -> StrictString {
    return StrictString(unsafeString: normalizeAsString(string))
  }

  @inlinable internal static func normalize(_ scalars: String.ScalarView) -> StrictString {
    return normalize(String(scalars))
  }

  @inlinable internal static func normalize<S: Sequence>(_ sequence: S) -> StrictString
  where S.Element == UnicodeScalar {
    switch sequence {

    // Already normalized.
    case let strict as StrictString:
      return strict
    case let strictSlice as StrictString.SubSequence:
      return StrictString(unsafeString: String(strictSlice.base.string.scalars[strictSlice.bounds]))

    // Need normalization.
    case let nonStrictScalars as String.ScalarView:
      return normalize(nonStrictScalars)
    default:
      return normalize(String.ScalarView(sequence))
    }
  }

  // MARK: - Addable

  @inlinable public static func += (
    precedingValue: inout StrictString,
    followingValue: StrictString
  ) {
    precedingValue.append(contentsOf: followingValue)
  }

  // MARK: - BidirectionalCollection

  @inlinable public func index(before i: String.ScalarView.Index) -> String.ScalarView.Index {
    return string.scalars.index(before: i)
  }

  // MARK: - Codable

  public func encode(to encoder: Encoder) throws {
    try encode(to: encoder, via: description)
  }

  public init(from decoder: Decoder) throws {
    try self.init(from: decoder, via: String.self, convert: { StrictString($0) })
  }

  // MARK: - Collection

  @inlinable public var startIndex: String.ScalarView.Index {
    return string.scalars.startIndex
  }

  @inlinable public var endIndex: String.ScalarView.Index {
    return string.scalars.endIndex
  }

  @inlinable public func index(after i: String.ScalarView.Index) -> String.ScalarView.Index {
    return string.scalars.index(after: i)
  }

  @inlinable public subscript(position: String.ScalarView.Index) -> UnicodeScalar {
    return string.scalars[position]
  }

  // MARK: - Comparable

  @inlinable public static func < (precedingValue: StrictString, followingValue: StrictString)
    -> Bool
  {
    return StrictString.sortAlgorithm(precedingValue, followingValue)
  }

  // MARK: - CustomStringConvertible

  @inlinable public var description: String {
    return string
  }

  // MARK: - Equatable

  @inlinable public static func == (precedingValue: StrictString, followingValue: StrictString)
    -> Bool
  {
    return precedingValue.string.scalars.elementsEqual(followingValue.string.scalars)
  }

  // MARK: - ExpressibleByStringInterpolation

  @inlinable public init(stringInterpolation: StringInterpolation) {
    self = stringInterpolation.string
  }

  // MARK: - ExpressibleByStringLiteral

  @inlinable public init(stringLiteral: String) {
    self.init(stringLiteral)
  }

  // MARK: - Hashable

  @inlinable public func hash(into hasher: inout Hasher) {
    hasher.combine(string)
  }

  // MARK: - RangeReplaceableCollection

  @inlinable public init() {
    self.init(unsafeString: String())
  }

  @inlinable public init<S: Sequence>(_ elements: S) where S.Element == Element {
    self = StrictString.normalize(elements)
  }

  @inlinable internal static func concatenateStrictStrings(
    _ first: StrictString,
    _ second: StrictString
  ) -> StrictString {

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

  @inlinable public mutating func append<S: Sequence>(contentsOf newElements: S)
  where S.Element == UnicodeScalar {
    self = StrictString.concatenateStrictStrings(self, StrictString.normalize(newElements))
  }

  @inlinable public mutating func insert<S: Sequence>(
    contentsOf newElements: S,
    at i: String.ScalarView.Index
  ) where S.Element == UnicodeScalar {
    replaceSubrange(i..<i, with: newElements)
  }

  @inlinable public mutating func replaceSubrange<S: Sequence>(
    _ subrange: Range<String.ScalarView.Index>,
    with newElements: S
  ) where S.Element == UnicodeScalar {

    let preceding = StrictString(unsafeString: String(string.scalars[..<subrange.lowerBound]))
    let succeeding = StrictString(unsafeString: String(string.scalars[subrange.upperBound...]))
    let replacement = StrictString.normalize(newElements)

    let throughNew = StrictString.concatenateStrictStrings(preceding, replacement)
    self = StrictString.concatenateStrictStrings(throughNew, succeeding)
  }

  // MARK: - StringFamily

  @inlinable public var scalars: StrictString {
    get {
      return self
    }
    set {
      self = newValue
    }
  }

  @inlinable public var clusters: ClusterView {
    get {
      return ClusterView(self)
    }
    set {
      self = newValue.string
    }
  }

  // MARK: - TextOutputStream

  @inlinable public mutating func write(_ string: String) {
    self.append(contentsOf: string.scalars)
  }

  // MARK: - TextOutputStreamable

  @inlinable public func write<Target>(to target: inout Target) where Target: TextOutputStream {
    target.write(string)
  }
}

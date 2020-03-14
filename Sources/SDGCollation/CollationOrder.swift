/*
 CollationOrder.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
#if canImport(Foundation)
  import Foundation
#endif

import SDGControlFlow
import SDGLogic
import SDGMathematics
import SDGCollections
import SDGText
import SDGPersistence

/// A collation order for sorting strings.
public struct CollationOrder: Decodable, Encodable, FileConvertible {

  // MARK: - Static Properties

  /// The root collation order.
  public static let root: CollationOrder = {
    return try! CollationOrder(file: Resources.root, origin: nil)
  }()

  // MARK: - Initialization

  internal init(
    rules: [StrictString: [CollationElement]],
    beforeIndex: CollationIndex,
    endOfStringIndex: CollationIndex,
    placeholderIndex: CollationIndex,
    defaultAccent: CollationIndex,
    defaultCase: CollationIndex,
    unifiedIdeographs: CollationIndex,
    otherUnifiedIdeographs: CollationIndex,
    unassignedCodePoints: CollationIndex,
    afterIndex: CollationIndex
  ) {  // @exmpt(from: tests) Ureachable exept via @testable for resource generation.

    self.rules = rules
    self.beforeIndex = beforeIndex
    self.endOfStringIndex = endOfStringIndex
    self.placeholderIndex = placeholderIndex
    self.defaultAccent = defaultAccent
    self.defaultCase = defaultCase
    self.unifiedIdeographs = unifiedIdeographs
    self.otherUnifiedIdeographs = otherUnifiedIdeographs
    self.unassignedCodePoints = unassignedCodePoints
    self.afterIndex = afterIndex
  }

  // MARK: - Properties

  internal var rules: [StrictString: [CollationElement]] {
    didSet {
      cache = Cache()
    }
  }

  private class Cache {
    fileprivate init() {}
    fileprivate var contextualMapping: ContextualMapping<StrictString, [CollationElement]>?
  }
  private var cache = Cache()

  internal let beforeIndex: CollationIndex
  private let endOfStringIndex: CollationIndex
  private let placeholderIndex: CollationIndex
  private let defaultAccent: CollationIndex
  private let defaultCase: CollationIndex
  private let unifiedIdeographs: CollationIndex
  private let otherUnifiedIdeographs: CollationIndex
  private let unassignedCodePoints: CollationIndex
  internal let afterIndex: CollationIndex

  internal var contextualMapping: ContextualMapping<StrictString, [CollationElement]> {
    return cached(in: &cache.contextualMapping) {
      return ContextualMapping(
        mapping: rules,
        fallbackAlgorithm: fallbackAlgorithm(
          placeholderIndex: placeholderIndex,
          defaultAccent: defaultAccent,
          defaultCase: defaultCase,
          unifiedIdeographs: unifiedIdeographs,
          otherUnifiedIdeographs: otherUnifiedIdeographs,
          unassignedCodePoints: unassignedCodePoints
        )
      )
    }
  }

  // MARK: - Fallback

  // These must not depend on static constants. The original constants from when the instance was encoded must be used instead.

  private static func elements(
    for category: CollationIndex,
    codepoint: CollationIndex,
    constants: (
      placeholderIndex: CollationIndex,
      defaultAccent: CollationIndex,
      defaultCase: CollationIndex
    )
  ) -> [CollationElement] {

    return [
      CollationElement(rawIndices: [
        [category, codepoint],
        [constants.placeholderIndex],
        [constants.defaultAccent],
        [constants.defaultCase],
        [category, codepoint],
        [constants.placeholderIndex],
      ])
    ]
  }

  private func fallbackAlgorithm(
    placeholderIndex: CollationIndex,
    defaultAccent: CollationIndex,
    defaultCase: CollationIndex,
    unifiedIdeographs: CollationIndex,
    otherUnifiedIdeographs: CollationIndex,
    unassignedCodePoints: CollationIndex
  ) -> (StrictString.Element) -> [CollationElement] {

    return { character in

      let codepoint = CollationIndex(character.value)
      let constants = (
        placeholderIndex: placeholderIndex,
        defaultAccent: defaultAccent,
        defaultCase: defaultCase
      )

      // Ideographs, Compatibility
      if (0x4E00...0x9FFF).contains(codepoint) ∨ (0xF900...0xFAFF).contains(codepoint) {
        // Ideographs, Compatibility
        return CollationOrder.elements(
          for: unifiedIdeographs,
          codepoint: codepoint,
          constants: constants
        )
      } else if (0x3400...0x4DBF).contains(codepoint) ∨ (0x20000...0x2A6DF).contains(codepoint)
        ∨ (0x2A700...0x2B73F).contains(codepoint) ∨ (0x2B740...0x2B81F).contains(codepoint)
        ∨ (0x2B820...0x2CEAF).contains(codepoint)
      {
        // Extensions A, B, C, D, E
        return CollationOrder.elements(
          for: otherUnifiedIdeographs,
          codepoint: codepoint,
          constants: constants
        )
      } else {
        return CollationOrder.elements(
          for: unassignedCodePoints,
          codepoint: codepoint,
          constants: constants
        )
      }
    }
  }

  // MARK: - Usage

  @usableFromInline internal func collationIndices(for string: StrictString) -> [CollationIndex] {
    let elements = contextualMapping.map(string)

    var indices = [CollationIndex]()
    for level in CollationLevel.allCases {
      if level.isInReverse {
        for element in elements.reversed() {
          indices += element.indices(for: level).reversed()
        }
      } else {
        for element in elements {
          indices += element.indices(for: level)
        }
      }
      indices.append(endOfStringIndex)
    }

    return indices
  }

  @inlinable internal func indenticalIndices<S>(for string: S) -> [CollationIndex]
  where S: Collection, S.Element == Unicode.Scalar {
    var indices = [CollationIndex]()
    for character in string {
      indices.append(CollationIndex(character.value))
    }
    return indices
  }

  /// Returns the collation indices for a particular string.
  ///
  /// - Parameters:
  ///     - string: The string to convert to collation indices.
  @inlinable public func indices<S>(for string: S) -> [CollationIndex] where S: StringFamily {
    let strict: StrictString
    if let already = string as? StrictString {
      strict = already
    } else {
      strict = StrictString(string.scalars)
    }
    var indices = collationIndices(for: strict)
    indices.append(contentsOf: indenticalIndices(for: string.scalars))
    return indices
  }

  /// Returns whether or not the strings are sorted in ascending order.
  ///
  /// - Parameters:
  ///     - preceding: The preceding string.
  ///     - following: The following string
  @inlinable public func stringsAreOrderedAscending<S>(
    _ preceding: S,
    _ following: S
  ) -> Bool where S: StringFamily {
    return indices(for: preceding).lexicographicallyPrecedes(indices(for: following))
  }

  /// Returns whether or not the strings are sorted equal.
  ///
  /// - Parameters:
  ///     - preceding: The preceding string.
  ///     - following: The following string
  @inlinable public func stringsAreOrderedEqual<S>(
    _ preceding: S,
    _ following: S
  ) -> Bool where S: StringFamily {
    return indices(for: preceding).elementsEqual(indices(for: following))
  }

  /// Sorts a collection of strings.
  ///
  /// - Parameters:
  ///     - strings: The strings to sort.
  @inlinable public func collate<C, S>(_ strings: C) -> [S]
  where C: Sequence, S: StringFamily, C.Element == S {
    var cache: [CollationCacheEntry<S>] = strings.map { string in
      return CollationCacheEntry(string: string, indices: self.indices(for: string))
    }
    cache.sort { $0.indices.lexicographicallyPrecedes($1.indices) }
    return cache.map { $0.string }
  }

  // MARK: - Tailoring

  /// Returns a tailored order by appling the provided rules.
  ///
  /// - Warning: This method cannot be called within itself and cannot be called on multiple instances at once.
  ///
  /// - Parameters:
  ///     - tailoringRules: A closure which tailors the collation by listing rules defined using the operators in this module. (This is the only place where the operators can be used.)
  public func tailored(accordingTo tailoringRules: () -> Void) -> CollationOrder {
    inTheProcessOfTailoring = true
    defer { inTheProcessOfTailoring = false }

    tailoringRoot = self
    defer { tailoringRoot = nil }

    tailoringRules()

    return tailoringRoot!
  }

  // MARK: - Decodable

  public init(from decoder: Decoder) throws {
    var container = try decoder.unkeyedContainer()
    beforeIndex = try container.decode(CollationIndex.self)
    endOfStringIndex = try container.decode(CollationIndex.self)
    placeholderIndex = try container.decode(CollationIndex.self)
    defaultAccent = try container.decode(CollationIndex.self)
    defaultCase = try container.decode(CollationIndex.self)
    unifiedIdeographs = try container.decode(CollationIndex.self)
    otherUnifiedIdeographs = try container.decode(CollationIndex.self)
    unassignedCodePoints = try container.decode(CollationIndex.self)
    afterIndex = try container.decode(CollationIndex.self)

    var rules = try container.decode([StrictString: [CollationElement]].self)
    /// JSON mishandles some control codes, possibly resulting in meaningless empty rules.
    rules[""] = nil
    self.rules = rules
  }

  // MARK: - Encodable

  public func encode(to encoder: Encoder) throws {
    var container = encoder.unkeyedContainer()
    try container.encode(beforeIndex)
    try container.encode(endOfStringIndex)
    try container.encode(placeholderIndex)
    try container.encode(defaultAccent)
    try container.encode(defaultCase)
    try container.encode(unifiedIdeographs)
    try container.encode(otherUnifiedIdeographs)
    try container.encode(unassignedCodePoints)
    try container.encode(afterIndex)
    try container.encode(rules)
  }

  // MARK: - FileConvertible

  public init(file: Data, origin: URL?) throws {
    let decoder = JSONDecoder()
    self = try decoder.decode(CollationOrder.self, from: file)
  }

  public var file: Data {
    let encoder = JSONEncoder()
    return try! encoder.encode(self)
  }
}

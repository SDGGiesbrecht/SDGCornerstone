/*
 CollationElement.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

internal typealias CollationElement = _CollationElement
public struct _CollationElement: Decodable, Encodable, Equatable, Sendable {

  // MARK: - Constructors

  internal static func relative(index: CollationIndex, at targetLevel: CollationLevel) -> (
    prefix: CollationElement, suffix: CollationElement
  ) {

    var circumfix: (prefix: [[CollationIndex]], suffix: [[CollationIndex]]) = ([], [])
    for level in CollationLevel.allCases {
      if level < targetLevel {
        circumfix.prefix.append([])
        circumfix.suffix.append([])
      } else {
        if level.isInReverse {
          circumfix.prefix.append([index])
          circumfix.suffix.append([])
        } else {
          circumfix.prefix.append([])
          circumfix.suffix.append([index])
        }
      }
    }
    return (
      CollationElement(rawIndices: circumfix.prefix), CollationElement(rawIndices: circumfix.suffix)
    )
  }

  // MARK: - Initialization

  public init(_rawIndices rawIndices: [[CollationIndex]]) {
    self.init(rawIndices: rawIndices)
  }
  internal init(rawIndices: [[CollationIndex]]) {
    self.indices = rawIndices
  }

  // MARK: - Properties

  private var indices: [[CollationIndex]]

  // MARK: - Usage

  internal func indices(for level: CollationLevel) -> [CollationIndex] {
    return indices[level.rawValue]
  }

  // MARK: - Encodable

  public func encode(to encoder: Encoder) throws {
    try encode(to: encoder, via: indices)
  }

  // MARK: - Decodable

  public init(from decoder: Decoder) throws {
    try self.init(from: decoder, via: [[CollationIndex]].self) { CollationElement(rawIndices: $0) }
  }
}

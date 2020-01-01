/*
 BijectiveMapping.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A reversible one‐to‐one mapping.
public struct BijectiveMapping<X: Hashable, Y: Hashable>: Collection,
  ExpressibleByDictionaryLiteral, TransparentWrapper
{

  // MARK: - Properties

  @usableFromInline internal let xToY: [X: Y]
  @usableFromInline internal let yToX: [Y: X]

  // MARK: - Initialization

  /// Creates a bijective mapping from the mapping in one direction.
  ///
  /// - Parameters:
  ///     - mapping: The mapping.
  @inlinable public init(_ mapping: [X: Y]) {

    xToY = mapping

    var reverse = [Y: X]()
    for (x, y) in mapping {
      _assert(
        reverse[y] == nil,
        { (localization: _APILocalization) -> String in  // @exempt(from: tests)
          switch localization {  // @exempt(from: tests)
          case .englishCanada:
            return
              "This mapping is not bijective; it is multivalued. (\(y) ⇄ {\(reverse[y]!), \(x)})"
          }
        }
      )
      reverse[y] = x
    }
    yToX = reverse
  }

  // MARK: - Look‐Up

  /// Returns the corresponding `Y` for a particular `X`.
  ///
  /// - Parameters:
  ///     - x: The `X` value.
  @inlinable public func y(for x: X) -> Y? {
    return xToY[x]
  }
  /// Returns the corresponding `X` for a particular `Y`.
  ///
  /// - Parameters:
  ///     - y: The `Y` value.
  @inlinable public func x(for y: Y) -> X? {
    return yToX[y]
  }

  /// Accesses the corresponding `Y` for a particular `X`.
  ///
  /// - Parameters:
  ///     - x: The `X` value.
  @inlinable public subscript(x: X) -> Y? {
    return xToY[x]
  }

  /// Accesses the corresponding `X` for a particular `Y`.
  ///
  /// - Parameters:
  ///     - y: The `Y` value.
  @inlinable public subscript(y: Y) -> X? {
    return yToX[y]
  }

  // MARK: - Collection

  @inlinable public var startIndex: Dictionary<X, Y>.Index {
    return xToY.startIndex
  }

  @inlinable public var endIndex: Dictionary<X, Y>.Index {
    return xToY.endIndex
  }

  @inlinable public func index(after i: Dictionary<X, Y>.Index) -> Dictionary<X, Y>.Index {
    return xToY.index(after: i)
  }

  @inlinable public subscript(position: Dictionary<X, Y>.Index) -> (X, Y) {
    return xToY[position]
  }

  // MARK: - ExpressibleByDictionaryLiteral

  @inlinable public init(dictionaryLiteral elements: (X, Y)...) {
    self.init(Dictionary(uniqueKeysWithValues: elements))
  }

  // MARK: - TransparentWrapper

  public var wrappedInstance: Any {
    return xToY
  }
}

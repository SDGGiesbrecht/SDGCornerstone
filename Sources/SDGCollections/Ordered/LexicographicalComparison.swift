/*
 LexicographicalComparison.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A wrapper that enables lexicographical comparison of any ordered collection.
///
/// This wrapper conforms to `Comparable` and `Equatable` using `lexicographicallyPrecedes(_)` and `elementsEqual(_:)`, so that these methods can be used with APIs requiring `Comparable` conformance.
public struct LexicographicalComparison<C>: Comparable, TransparentWrapper
where C: Collection, C.Element: Comparable {

  // MARK: - Initialization

  /// Wraps a collection.
  ///
  /// - Parameters:
  ///   - collection: The collection.
  public init(_ collection: C) {
    self.collection = collection
  }

  // MARK: - Properties

  private var collection: C

  // MARK: - Comparable

  public static func < (
    precedingValue: LexicographicalComparison<C>,
    followingValue: LexicographicalComparison<C>
  ) -> Bool {
    return precedingValue.collection.lexicographicallyPrecedes(followingValue.collection)
  }

  // MARK: - Equatable

  public static func == (
    precedingValue: LexicographicalComparison<C>,
    followingValue: LexicographicalComparison<C>
  ) -> Bool {
    return precedingValue.collection.elementsEqual(followingValue.collection)
  }

  // MARK: - TransparentWrapper

  public var wrappedInstance: Any {
    return collection
  }
}

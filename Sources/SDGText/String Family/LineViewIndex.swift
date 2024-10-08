/*
 LineViewIndex.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2024 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGCollections

/// A line view index.
public struct LineViewIndex: Comparable, Equatable, Sendable {

  // MARK: - Initialization

  @usableFromInline internal init(
    start: String.ScalarView.Index,
    newline: Range<String.ScalarView.Index>? = nil
  ) {
    self.start = start
    cache.contents = newline
  }

  private init() {
    start = nil
  }
  @usableFromInline internal static func endIndex() -> LineViewIndex {
    return LineViewIndex()
  }

  // MARK: - Properties

  @usableFromInline internal var cache: SendableValueCache<Range<String.ScalarView.Index>?> =
    SendableValueCache(contents: nil)

  @usableFromInline internal let start: String.ScalarView.Index?  // nil indicates the end index

  @inlinable internal func newline<S: UnicodeScalarView>(
    in scalars: S
  ) -> Range<String.ScalarView.Index>? {
    guard let startIndex = start else {
      return nil
    }
    return cached(in: &cache.contents) {
      let newlinePattern = Newline.pattern(for: S.SubSequence.self)
      return scalars[startIndex...].firstMatch(for: newlinePattern)?.range
        ?? scalars.endIndex..<scalars.endIndex
    }
  }

  // MARK: - Conversions

  /// Returns the position in the given view of scalars that corresponds exactly to this index.
  ///
  /// - Parameters:
  ///   - scalars: The scalar view.
  @inlinable public func samePosition(in scalars: StrictString) -> StrictString.Index {
    return start ?? scalars.endIndex
  }

  /// Returns the position in the given view of scalars that corresponds exactly to this index.
  ///
  /// - Parameters:
  ///   - scalars: The scalar view.
  @inlinable public func samePosition(in scalars: String.ScalarView) -> String.ScalarView.Index {
    return start ?? scalars.endIndex
  }

  /// Returns the position in the given view of clusters that corresponds exactly to this index.
  ///
  /// - Parameters:
  ///   - clusters: The cluster view.
  @inlinable public func samePosition(
    in clusters: StrictString.ClusterView
  ) -> StrictString.ClusterView.Index {
    return samePosition(in: String(StrictString(clusters)).clusters)
  }

  /// Returns the position in the given view of clusters that corresponds exactly to this index.
  ///
  /// - Parameters:
  ///   - clusters: The cluster view.
  @inlinable public func samePosition(in clusters: String.ClusterView) -> String.ClusterView.Index {
    let string = String(clusters)
    return samePosition(in: string.scalars).cluster(in: string.clusters)
  }

  // MARK: - Comparable

  @inlinable public static func < (
    precedingValue: LineViewIndex,
    followingValue: LineViewIndex
  ) -> Bool {
    if let precedingValueStart = precedingValue.start {
      if let followingValueStart = followingValue.start {
        return precedingValueStart < followingValueStart
      } else {
        // precedingValue is valid, but followingValue is the end index.
        return true
      }
    } else {
      // precedingValue is the end index.
      return false
    }
  }

  // MARK: - Equatable

  @inlinable public static func == (
    precedingValue: LineViewIndex,
    followingValue: LineViewIndex
  ) -> Bool {
    return precedingValue.start == followingValue.start
  }
}

/*
 StringIndex.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension String.Index {

  // MARK: - Conversions

  // #warning(Temporary)
  #if false
  /// Returns the position in the given view of scalars that corresponds exactly to this index.
  ///
  /// - Parameters:
  ///     - scalars: The scalar view of the string the range refers to.
  @inlinable public func samePosition(in scalars: StrictString.ScalarView) -> StrictString.Index? {
    return samePosition(in: String(StrictString(scalars)).scalars)
  }
  #endif

  // @documentation(String.Index.scalar(in:))
  /// Returns the position of the scalar that contains this index.
  ///
  /// - Parameters:
  ///     - scalars: The scalar view of the string the range refers to.
  @inlinable public func scalar(in scalars: String.ScalarView) -> String.Index {
    let string = String(scalars)
    var cursor = self
    var position = samePosition(in: scalars)
    while position == nil {
      if cursor.samePosition(in: string.utf8) ≠ nil {
        cursor = string.utf8.index(before: cursor)
      } else /* UTF‐16 */ {
        cursor = string.utf16.index(before: cursor)
      }
      position = cursor.samePosition(in: string.scalars)
    }
    return position!
  }

  // #warning(Temporary)
  #if false
  // #documentation(String.Index.scalar(in:))
  /// Returns the position of the scalar that contains this index.
  ///
  /// - Parameters:
  ///     - scalars: The scalar view of the string the range refers to.
  @inlinable public func scalar(in scalars: StrictString.ScalarView) -> StrictString.Index {
    return scalar(in: String(StrictString(scalars)).scalars)
  }

  /// Returns the position in the given view of clusters that corresponds exactly to this index.
  ///
  /// - Parameters:
  ///     - clusters: The cluster view of the string the range refers to.
  @inlinable public func samePosition(in clusters: StrictString.ClusterView) -> StrictString.Index?
  {
    return samePosition(in: String(StrictString(clusters)))
  }
  #endif

  // @documentation(String.Index.cluster(in:))
  /// Returns the position of the cluster that contains this index.
  ///
  /// - Parameters:
  ///     - clusters: The cluster view of the string the range refers to.
  @inlinable public func cluster(in clusters: String.ClusterView) -> String.Index {
    let string = String(clusters)
    let startScalar = scalar(in: string.scalars)
    var cursor = self
    var position = startScalar.samePosition(in: string.clusters)
    while position == nil {
      cursor = string.unicodeScalars.index(before: cursor)
      position = cursor.samePosition(in: string.clusters)
    }
    return position!
  }

  // #warning(Temporary)
  #if false
  // #documentation(String.Index.cluster(in:))
  /// Returns the position of the cluster that contains this index.
  ///
  /// - Parameters:
  ///     - clusters: The cluster view of the string the range refers to.
  @inlinable public func cluster(in clusters: StrictString.ClusterView) -> StrictString.Index {
    return cluster(in: String(StrictString(clusters)))
  }
  #endif

  /// Returns the position in the given view of lines that corresponds exactly to this index.
  ///
  /// - Parameters:
  ///     - lines: The line view of the string the range refers to.
  @inlinable public func samePosition<S>(in lines: LineView<S>) -> LineView<S>.Index? {
    let line = self.line(in: lines)
    guard let start = line.start else {
      // End index
      return line
    }
    guard start == self else {
      // In the middle.
      return nil
    }
    return line
  }

  /// Returns the position of the line that contains this index.
  ///
  /// - Parameters:
  ///     - lines: The line view of the string the range refers to.
  @inlinable public func line<S>(in lines: LineView<S>) -> LineView<S>.Index {
    return lines.line(for: self)
  }
}

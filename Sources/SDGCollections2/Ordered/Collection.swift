/*
 Collection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Collection {

  // MARK: - Indices

  /// Returns the range for all of `self`.
  @inlinable public var bounds: Range<Index> {
    return startIndex..<endIndex
  }

  /// Returns an array of ranges representing the complement of those provided.
  ///
  /// - SeeAlso: `components(separatedBy:)`
  ///
  /// - Precondition: The provided ranges must be sorted and not overlap.
  ///
  /// - Parameters:
  ///     - separators: The ranges of the separators.
  @inlinable public func ranges(separatedBy separators: [Range<Index>]) -> [Range<Index>] {
    let startIndices = [startIndex] + separators.map({ $0.upperBound })
    let endIndices = separators.map({ $0.lowerBound }) + [endIndex]
    return zip(startIndices, endIndices).map({ $0..<$1 })
  }
}

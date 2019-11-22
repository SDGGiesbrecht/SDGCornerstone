/*
 ShimmedCollectionDifference.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A shimmed version of `CollectionDifference` with no availability constraints.
public struct ShimmedCollectionDifference<ChangeElement> {

  // MARK: - Initialization

  /// Wraps an instance of a standard `CollectionDifference`.
  @available(macOS 10.15, *)
  @inlinable public init(_ standard: CollectionDifference<ChangeElement>) {
    #warning("Not implemented yet.")
  }
}

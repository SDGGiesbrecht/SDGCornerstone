/*
 CollectionDifference.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics

@available(macOS 10.15, *)
extension CollectionDifference {

  // MARK: - Initialization

  /// Unwraps an instance of a shimmed `CollectionDifference`.
  ///
  /// - Parameters:
  ///   - shimmed: The shimmed instance.
  @inlinable public init(_ shimmed: ShimmedCollectionDifference<ChangeElement>) {
    self.init(shimmed.map({ Change($0) }))!
  }
}

/// A shimmed version of `CollectionDifference` with no availability constraints.
public struct ShimmedCollectionDifference<ChangeElement>: BidirectionalCollection, Collection,
  RandomAccessCollection
{

  // MARK: - Initialization

  /// Wraps an instance of a standard `CollectionDifference`.
  @available(macOS 10.15, *)
  @inlinable public init(_ standard: CollectionDifference<ChangeElement>) {
    removals = standard.removals.map { Change($0) }
    insertions = standard.insertions.map { Change($0) }
  }

  /// A shimmed version of `CollectionDifference.init?(_:)` with no availability constraints.
  ///
  /// - Parameters:
  ///   - changes: The changes.
  @inlinable public init?<Changes>(_ changes: Changes)
  where Changes: Collection, Changes.Element == Change {
    if changes.isEmpty {
      return nil
    }

    var insertionAssociations: [Int: Int] = [:]
    var removalAssociations: [Int: Int] = [:]
    var insertions: Set<Int> = []
    var removals: Set<Int> = []

    for change in changes {
      if change.offset < 0 {
        return nil
      }
      if let associated = change.associatedOffset,
        associated < 0
      {
        return nil
      }

      switch change {
      case .remove(let offset, _, let associatedOffset):

        if offset ∈ removals {
          return nil
        }
        removals.insert(offset)

        if let associated = associatedOffset {
          if removalAssociations[offset] ≠ nil {
            return nil
          }
          removalAssociations[offset] = associated
        }

      case .insert(let offset, _, let associatedOffset):

        if offset ∈ insertions {
          return nil
        }
        insertions.insert(offset)

        if let associated = associatedOffset {
          if insertionAssociations[offset] ≠ nil {
            return nil
          }
          insertionAssociations[offset] = associated
        }
      }
    }
    if removalAssociations ≠ insertionAssociations {
      return nil
    }

    self.init(unsafeChanges: changes)
  }

  @inlinable internal init<Changes>(unsafeChanges changes: Changes)
  where Changes: Collection, Changes.Element == Change {
    var removals: [Change] = []
    var insertions: [Change] = []
    for change in changes {
      switch change {
      case .remove:
        removals.append(change)
      case .insert:
        insertions.append(change)
      }
    }
    self.removals = removals.sorted(by: { $0.offset < $1.offset })
    self.insertions = insertions.sorted(by: { $0.offset < $1.offset })
  }

  // MARK: - Properties

  /// A shimmed version of `CollectionDifference.removals` with no availability constraints.
  public let removals: [Change]

  /// A shimmed version of `CollectionDifference.insertions` with no availability constraints.
  public let insertions: [Change]

  // MARK: - BidirectionalCollection

  @inlinable public func index(before i: Int) -> Int {
    return i − 1
  }

  // MARK: - Reversal

  @inlinable public func inverse() -> Self {
    let reversedChanges: [Change] = map { change in
      switch change {
      case .remove(let offset, let element, let associatedOffset):
        return .insert(offset: offset, element: element, associatedWith: associatedOffset)
      case .insert(let offset, let element, let associatedOffset):
        return .remove(offset: offset, element: element, associatedWith: associatedOffset)
      }
    }
    return ShimmedCollectionDifference(unsafeChanges: reversedChanges)
  }

  // MARK: - Collection

  @inlinable public var startIndex: Int {
    return 0
  }

  @inlinable public var endIndex: Int {
    return removals.count + insertions.count
  }

  @inlinable public func index(after i: Int) -> Int {
    return i + 1
  }

  @inlinable public subscript(position: Int) -> Change {
    if position < removals.count {
      return removals[removals.count − (position + 1)]
    }
    return insertions[position − removals.count]
  }

  // MARK: - RandomAccessCollection

  @inlinable public func index(_ i: Int, offsetBy distance: Int) -> Int {
    return i + distance
  }

  @inlinable public func distance(from start: Int, to end: Int) -> Int {
    return end − start
  }
}

extension ShimmedCollectionDifference: Decodable where ChangeElement: Decodable {}
extension ShimmedCollectionDifference: Encodable where ChangeElement: Encodable {}

extension ShimmedCollectionDifference: Equatable where ChangeElement: Equatable {}

extension ShimmedCollectionDifference: Hashable where ChangeElement: Hashable {

  /// A shimmed version of `CollectionDifference.inferringMoves()` with no availability constraints.
  public func inferringMoves() -> ShimmedCollectionDifference<ChangeElement> {
    var groupedRemovals = [ChangeElement: [Int]]()
    for removal in removals {
      groupedRemovals[removal.element, default: []].append(removal.offset)
    }
    var groupedInsertions = [ChangeElement: [Int]]()
    for insertion in insertions {
      groupedInsertions[insertion.element, default: []].append(insertion.offset)
    }

    var pairedChanges: [Change] = []
    pairedChanges.reserveCapacity(count)
    for (element, removalOffsets) in groupedRemovals {
      for removalOffset in removalOffsets.reversed() {
        if let insertionOffset = groupedInsertions[element]?.last {
          // Found a pair.
          pairedChanges.append(
            .remove(offset: removalOffset, element: element, associatedWith: insertionOffset)
          )
          // Handle the insert too and remove it from the list.
          pairedChanges.append(
            .insert(offset: insertionOffset, element: element, associatedWith: removalOffset)
          )
          groupedInsertions[element]?.removeLast()
        } else {
          pairedChanges.append(
            .remove(offset: removalOffset, element: element, associatedWith: nil)
          )
        }
      }
    }
    for (element, insertionOffsets) in groupedInsertions {
      for insertionOffset in insertionOffsets {
        pairedChanges.append(
          .insert(offset: insertionOffset, element: element, associatedWith: nil)
        )
      }
    }
    return ShimmedCollectionDifference(unsafeChanges: pairedChanges)
  }
}

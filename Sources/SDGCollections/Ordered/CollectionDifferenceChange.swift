/*
 CollectionDifferenceChange.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@available(macOS 10.15, *)
extension CollectionDifference.Change {

  // MARK: - Initialization

  /// Unwraps an instance of a shimmed `Change`.
  ///
  /// - Parameters:
  ///   - shimmed: The shimmed instance.
  @inlinable public init(_ shimmed: ShimmedCollectionDifference<ChangeElement>.Change) {
    switch shimmed {
    case .remove(let offset, let element, let associatedOffset):
      self = .remove(offset: offset, element: element, associatedWith: associatedOffset)
    case .insert(let offset, let element, let associatedOffset):
      self = .insert(offset: offset, element: element, associatedWith: associatedOffset)
    }
  }
}

extension ShimmedCollectionDifference {

  /// A shimmed version of `CollectionDifference.Change` with no availability constraints.
  public enum Change {

    // MARK: - Cases

    /// A removal.
    case remove(offset: Int, element: ChangeElement, associatedWith: Int?)

    /// An insertion.
    case insert(offset: Int, element: ChangeElement, associatedWith: Int?)
  }
}

// MARK: - Codable

fileprivate enum CodingKeys: CodingKey {
  case isRemove
  case offset
  case element
  case associatedOffset
}

#warning("Complete")
/*
extension ShimmedCollectionDifference.Change: Decodable where ChangeElement: Decodable {

  // MARK: - Decodable

  public init(from decoder: Decoder) throws {

  }
}*/

extension ShimmedCollectionDifference.Change: Encodable where ChangeElement: Encodable {

  // MARK: - Encodable

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    switch self {
    case .remove:
      try container.encode(true, forKey: .isRemove)
    case .insert:
      try container.encode(false, forKey: .isRemove)
    }
    switch self {
    case .remove(let offset, let element, let associatedOffset),
      .insert(let offset, let element, let associatedOffset):
      try container.encode(offset, forKey: .offset)
      try container.encode(element, forKey: .element)
      try container.encode(associatedOffset, forKey: .associatedOffset)
    }
  }
}
#warning("Complete")
/*
extension ShimmedCollectionDifference.Change: Equatable where ChangeElement: Equatable {}
extension ShimmedCollectionDifference.Change: Hashable where ChangeElement: Hashable {}*/

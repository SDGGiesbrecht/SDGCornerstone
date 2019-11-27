/*
 CollectionDifferenceChange.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
extension Swift.CollectionDifference.Change {

  // MARK: - Initialization

  /// Unwraps an instance of a shimmed `SDGCollections.CollectionDifference.Change`.
  ///
  /// - Parameters:
  ///   - shimmed: The shimmed instance.
  @inlinable public init(_ shimmed: SDGCollections.CollectionDifference<ChangeElement>.Change) {
    switch shimmed {  // @exempt(from: tests)
    // #workaround(workspace version 0.27.0, CI is not on 10.15 yet.)
    case .remove(let offset, let element, let associatedOffset):
      self = .remove(offset: offset, element: element, associatedWith: associatedOffset)
    case .insert(let offset, let element, let associatedOffset):
      self = .insert(offset: offset, element: element, associatedWith: associatedOffset)
    }
  }
}

extension CollectionDifference {

  /// A shimmed version of `Swift.CollectionDifference.Change` with no availability constraints.
  public enum Change {

    // MARK: - Cases

    /// A shimmed version of `Swift.CollectionDifference.Change.remove(offset:element:associatedWith:)` with no availability constraints.
    case remove(offset: Int, element: ChangeElement, associatedWith: Int?)

    /// A shimmed version of `Swift.CollectionDifference.Change.insert(offset:element:associatedWith:)` with no availability constraints.
    case insert(offset: Int, element: ChangeElement, associatedWith: Int?)

    // MARK: - Initialization

    /// Wraps an instance of a standard `Swift.CollectionDifference.Change`.
    ///
    /// - Parameters:
    ///   - standard: The shimmed instance.
    @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
    @inlinable public init(_ standard: Swift.CollectionDifference<ChangeElement>.Change) {
      switch standard {  // @exempt(from: tests)
      // #workaround(workspace version 0.27.0, CI is not on 10.15 yet.)
      case .remove(let offset, let element, let associatedOffset):
        self = .remove(offset: offset, element: element, associatedWith: associatedOffset)
      case .insert(let offset, let element, let associatedOffset):
        self = .insert(offset: offset, element: element, associatedWith: associatedOffset)
      }
    }

    // MARK: - Properties

    /// The offset.
    @inlinable public var offset: Int {
      get {
        switch self {
        case .remove(let offset, _, _),
          .insert(let offset, _, _):
          return offset
        }
      }
      set {
        switch self {
        case .remove:
          self = .remove(offset: newValue, element: element, associatedWith: associatedOffset)
        case .insert:
          self = .insert(offset: newValue, element: element, associatedWith: associatedOffset)
        }
      }
    }

    /// The element.
    @inlinable public var element: ChangeElement {
      get {
        switch self {
        case .remove(_, let element, _),
          .insert(_, let element, _):
          return element
        }
      }
      set {
        switch self {
        case .remove:
          self = .remove(offset: offset, element: newValue, associatedWith: associatedOffset)
        case .insert:
          self = .insert(offset: offset, element: newValue, associatedWith: associatedOffset)
        }
      }
    }

    /// The associated offset.
    @inlinable public var associatedOffset: Int? {
      get {
        switch self {
        case .remove(_, _, let associatedOffset),
          .insert(_, _, let associatedOffset):
          return associatedOffset
        }
      }
      set {
        switch self {
        case .remove:
          self = .remove(offset: offset, element: element, associatedWith: newValue)
        case .insert:
          self = .insert(offset: offset, element: element, associatedWith: newValue)
        }
      }
    }
  }
}

// MARK: - Codable

fileprivate enum CodingKeys: CodingKey {
  case isRemove
  case offset
  case element
  case associatedOffset
}

extension CollectionDifference.Change: Decodable where ChangeElement: Decodable {

  // MARK: - Decodable

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let offset = try container.decode(Int.self, forKey: .offset)
    let element = try container.decode(ChangeElement.self, forKey: .element)
    let associatedOffset = try container.decode(Int?.self, forKey: .associatedOffset)
    if try container.decode(Bool.self, forKey: .isRemove) {
      self = .remove(offset: offset, element: element, associatedWith: associatedOffset)
    } else {
      self = .insert(offset: offset, element: element, associatedWith: associatedOffset)
    }
  }
}

extension CollectionDifference.Change: Encodable where ChangeElement: Encodable {

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

extension CollectionDifference.Change: Equatable where ChangeElement: Equatable {}
extension CollectionDifference.Change: Hashable where ChangeElement: Hashable {}

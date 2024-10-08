/*
 Intersection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2024 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic

/// An intersection of two sets.
public struct Intersection<Base1: SetDefinition, Base2: SetDefinition>: CustomStringConvertible,
  SetDefinition, TextualPlaygroundDisplay
where Base1.Element == Base2.Element {

  // MARK: - Initialization

  /// Creates an intersection from two sets.
  ///
  /// - Parameters:
  ///   - a: A set.
  ///   - b: Another set.
  @inlinable public init(_ a: Base1, _ b: Base2) {
    self.a = a
    self.b = b
  }

  // MARK: - Properties

  @usableFromInline internal let a: Base1
  @usableFromInline internal let b: Base2

  // MARK: - CustomStringConvertible

  public var description: String {
    return "(" + String(describing: a) + ") ∩ (" + String(describing: b) + ")"
  }

  // MARK: - SetDefinition

  public typealias Element = Base1.Element

  @inlinable public static func ∋ (
    precedingValue: Intersection,
    followingValue: Base1.Element
  ) -> Bool {
    return precedingValue.a ∋ followingValue ∧ precedingValue.b ∋ followingValue
  }
}

extension Intersection: Sendable where Base1: Sendable, Base2: Sendable {}

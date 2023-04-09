/*
 IntensionalSet.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A set with an intensional definion.
public struct IntensionalSet<Member>: Sendable, SetDefinition {

  // MARK: - Initialization

  /// Creates a set with a condition.
  ///
  /// - Parameters:
  ///   - condition: The defining condition.
  @inlinable public init(where condition: @escaping @Sendable (_ possibleMember: Element) -> Bool) {
    self.condition = condition
  }

  // MARK: - Properties

  @usableFromInline internal let condition: @Sendable (Element) -> Bool

  // MARK: - SetDefinition

  public typealias Element = Member

  @inlinable public static func ∋ (
    precedingValue: IntensionalSet,
    followingValue: Element
  ) -> Bool {
    return precedingValue.condition(followingValue)
  }
}

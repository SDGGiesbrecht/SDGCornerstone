/*
 SetDefinition.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics

/// A type that defines a set.
public protocol SetDefinition {

  /// The element type.
  associatedtype Element

  // MARK: - Membership

  /// Returns `true` if `precedingValue` is an element of `followingValue`.
  ///
  /// - Parameters:
  ///     - precedingValue: The element to test.
  ///     - followingValue: The set.
  static func ∈ (precedingValue: Element, followingValue: Self) -> Bool

  /// Returns `true` if `precedingValue` is not an element of `followingValue`.
  ///
  /// - Parameters:
  ///     - precedingValue: The element to test.
  ///     - followingValue: The set.
  static func ∉ (precedingValue: Element, followingValue: Self) -> Bool

  /// Returns `true` if `precedingValue` contains `followingValue`.
  ///
  /// - Parameters:
  ///     - precedingValue: The set.
  ///     - followingValue: The element to test.
  static func ∋ (precedingValue: Self, followingValue: Element) -> Bool

  /// Returns `true` if `precedingValue` does not contain `followingValue`.
  ///
  /// - Parameters:
  ///     - precedingValue: The set.
  ///     - followingValue: The element to test.
  static func ∌ (precedingValue: Self, followingValue: Element) -> Bool
}

extension SetDefinition {

  @inlinable public static func ∈ (precedingValue: Element, followingValue: Self) -> Bool {
    return followingValue ∋ precedingValue
  }

  @inlinable public static func ∉ (precedingValue: Element, followingValue: Self) -> Bool {
    return ¬(precedingValue ∈ followingValue)
  }

  @inlinable public static func ∌ (precedingValue: Self, followingValue: Element) -> Bool {
    return ¬(precedingValue ∋ followingValue)
  }

  // @documentation(SDGCornerstone.SetDefinition.∩)
  /// Returns the intersection of the two sets.
  ///
  /// - Parameters:
  ///     - precedingValue: A set.
  ///     - followingValue: Another set.
  @inlinable public static func ∩ <S: SetDefinition>(precedingValue: Self, followingValue: S)
    -> Intersection<Self, S>
  {
    return Intersection(precedingValue, followingValue)
  }

  // @documentation(SDGCornerstone.SetDefinition.∪)
  /// Returns the union of the two sets.
  ///
  /// - Parameters:
  ///     - precedingValue: A set.
  ///     - followingValue: Another set.
  @inlinable public static func ∪ <S: SetDefinition>(precedingValue: Self, followingValue: S)
    -> Union<Self, S>
  {
    return Union(precedingValue, followingValue)
  }

  // @documentation(SDGCornerstone.SetDefinition.∖)
  /// Returns the relative complement of `followingValue` in `precedingValue`.
  ///
  /// - Parameters:
  ///     - precedingValue: The set to subtract from.
  ///     - followingValue: The set to subtract.
  @inlinable public static func ∖ <S: SetDefinition>(precedingValue: Self, followingValue: S)
    -> Intersection<Self, AbsoluteComplement<S>>
  {
    return precedingValue ∩ followingValue′
  }

  // @documentation(SDGCornerstone.SetDefinition.′)
  /// Returns the absolute complement of the set.
  ///
  /// - Parameters:
  ///     - operand: The set.
  @inlinable public static postfix func ′ (operand: Self) -> AbsoluteComplement<Self> {
    return AbsoluteComplement(operand)
  }

  // @documentation(SDGCornerstone.SetDefinition.∆)
  /// Returns the symmetric difference of `followingValue` in `precedingValue`.
  ///
  /// - Parameters:
  ///     - precedingValue: A set.
  ///     - followingValue: Another set.
  @inlinable public static func ∆ <S: SetDefinition>(precedingValue: Self, followingValue: S)
    -> Union<Intersection<Self, AbsoluteComplement<S>>, Intersection<S, AbsoluteComplement<Self>>>
  {
    return (precedingValue ∖ followingValue) ∪ (followingValue ∖ precedingValue)
  }

  // MARK: - Switch Expression Pattern

  // @documentation(SDGCornerstone.ExpressionPattern.~=)
  // #example(1, setSwitch)
  /// Enables use of any set definition in switch cases.
  ///
  /// ```swift
  /// switch 5 {
  /// case IntensionalSet(where: { $0.isEven }):
  ///     XCTFail("This case does not match.")
  /// case (2 ... 4 ∪ 7 ... 9)′:
  ///     print("This case does match.")
  /// default:
  ///     XCTFail("This case is never reached.")
  /// }
  /// ```
  ///
  /// - Parameters:
  ///     - pattern: The pattern to check against.
  ///     - value: The value to check.
  @inlinable public static func ~= (pattern: Self, value: Element) -> Bool {
    return value ∈ pattern
  }
}

extension SetDefinition where Self: SetAlgebra {

  /// Returns `true` if `self` contains `member`.
  ///
  /// - Parameters:
  ///     - member: The element to test.
  @inlinable public func contains(_ member: Self.Element) -> Bool {
    return self ∋ member
  }
}

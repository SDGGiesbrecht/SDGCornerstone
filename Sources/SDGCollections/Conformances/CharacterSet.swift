/*
 CharacterSet.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(workspace version 0.32.0, Web doesn’t have foundation yet.)
#if !os(WASI)
  import Foundation

  import SDGLogic
  import SDGMathematics

  extension CharacterSet: ComparableSet, MutableSet, SetInRepresentableUniverse, SetDefinition {

    // MARK: - ComparableSet

    @inlinable public static func ⊆ (precedingValue: CharacterSet, followingValue: CharacterSet)
      -> Bool
    {
      return precedingValue.isSubset(of: followingValue)
    }

    @inlinable public static func ⊇ (precedingValue: CharacterSet, followingValue: CharacterSet)
      -> Bool
    {
      return precedingValue.isSuperset(of: followingValue)
    }

    @inlinable public static func ⊊ (precedingValue: CharacterSet, followingValue: CharacterSet)
      -> Bool
    {
      return precedingValue.isStrictSubset(of: followingValue)
    }

    @inlinable public static func ⊋ (precedingValue: CharacterSet, followingValue: CharacterSet)
      -> Bool
    {
      return precedingValue.isStrictSuperset(of: followingValue)
    }

    @inlinable public func overlaps(_ other: CharacterSet) -> Bool {
      return ¬isDisjointAsSetAlgebra(with: other)
    }

    // MARK: - MutableSet

    @inlinable public static func ∩ (precedingValue: CharacterSet, followingValue: CharacterSet)
      -> CharacterSet
    {
      return precedingValue.intersection(followingValue)
    }

    @inlinable public static func ∩= (
      precedingValue: inout CharacterSet,
      followingValue: CharacterSet
    ) {
      precedingValue.formIntersection(followingValue)
    }

    @inlinable public static func ∪ (precedingValue: CharacterSet, followingValue: CharacterSet)
      -> CharacterSet
    {
      return precedingValue.union(followingValue)
    }

    @inlinable public static func ∪= (
      precedingValue: inout CharacterSet,
      followingValue: CharacterSet
    ) {
      return precedingValue.formUnion(followingValue)
    }

    @inlinable public static func ∖ (precedingValue: CharacterSet, followingValue: CharacterSet)
      -> CharacterSet
    {
      return precedingValue.subtracting(followingValue)
    }

    @inlinable public static func ∖= (
      precedingValue: inout CharacterSet,
      followingValue: CharacterSet
    ) {
      precedingValue.subtract(followingValue)
    }

    @inlinable public static func ∆ (precedingValue: CharacterSet, followingValue: CharacterSet)
      -> CharacterSet
    {
      return precedingValue.symmetricDifference(followingValue)
    }

    @inlinable public static func ∆= (
      precedingValue: inout CharacterSet,
      followingValue: CharacterSet
    ) {
      return precedingValue.formSymmetricDifference(followingValue)
    }

    // MARK: - SetDefinition

    @inlinable public static func ∋ (precedingValue: CharacterSet, followingValue: Element) -> Bool
    {
      return precedingValue.contains(followingValue)
    }

    // MARK: - SetInRepresentableUniverse

    public static let universe: CharacterSet = CharacterSet().inverted

    @inlinable public static postfix func ′ (operand: CharacterSet) -> CharacterSet {
      return operand.inverted
    }

    @inlinable public static postfix func ′= (operand: inout CharacterSet) {
      operand.invert()
    }
  }

  extension SetAlgebra {

    @inlinable internal func isDisjointAsSetAlgebra(with other: Self) -> Bool {
      return isDisjoint(with: other)
    }
  }
#endif

/*
 Range.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics

/// A member of the `Range` family: `Range`, `ClosedRange`, `CountableRange` or `CountableClosedRange`.
public protocol RangeFamily: ComparableSet, CustomDebugStringConvertible, CustomReflectable,
  CustomStringConvertible, RangeExpression
{

  /// The lower bound.
  var lowerBound: Bound { get }

  /// The upper bound.
  var upperBound: Bound { get }

  /// `true` if the type has a closed upper bound.
  static var hasClosedUpperBound: Bool { get }
}

extension RangeFamily {

  // MARK: - ComparableSet

  @inlinable public static func ⊆ (precedingValue: Self, followingValue: Self) -> Bool {
    return precedingValue.lowerBound ≥ followingValue.lowerBound ∧ precedingValue.upperBound
      ≤ followingValue.upperBound
  }

  // MARK: - SetDefinition

  @inlinable public static func ∋ (precedingValue: Self, followingValue: Bound) -> Bool {
    return precedingValue.contains(followingValue)
  }
}

extension Range: RangeFamily {

  /// Maps the range to another bound type.
  ///
  /// - Precondition: The conversion must generate valid bounds—the upper bound must not precede the lower bound.
  ///
  /// - Parameters:
  ///   - convert: A closure which converts a single bound.
  @inlinable public func map<B>(_ convert: (_ bound: Bound) -> B) -> Range<B> {
    return convert(lowerBound)..<convert(upperBound)
  }

  /// Maps the range to another bound type.
  ///
  /// The result will be `nil` if either bound conversion fails, or if the upper bound ends up preceding the lower bound.
  ///
  /// - Parameters:
  ///   - convert: A closure which converts a single bound.
  @inlinable public func map<B>(_ convert: (_ bound: Bound) -> B?) -> Range<B>? {
    guard let lower = convert(lowerBound),
      let upper = convert(upperBound),
      lower ≤ upper
    else {
      return nil
    }
    return lower..<upper
  }

  // MARK: - RangeFamily

  @inlinable public static var hasClosedUpperBound: Bool {
    return false
  }

  // MARK: - SetDefinition

  public typealias Element = Bound
}

extension ClosedRange: RangeFamily {

  /// Maps the range to another bound type.
  ///
  /// - Precondition: The conversion must generate valid bounds—the upper bound must not precede the lower bound.
  ///
  /// - Parameters:
  ///   - convert: A closure which converts a single bound.
  @inlinable public func map<B>(_ convert: (_ bound: Bound) -> B) -> ClosedRange<B> {
    return convert(lowerBound)...convert(upperBound)
  }

  /// Maps the range to another bound type.
  ///
  /// The result will be `nil` if either bound conversion fails, or if the upper bound ends up preceding the lower bound.
  ///
  /// - Parameters:
  ///   - convert: A closure which converts a single bound.
  @inlinable public func map<B>(_ convert: (_ bound: Bound) -> B?) -> ClosedRange<B>? {
    guard let lower = convert(lowerBound),
      let upper = convert(upperBound),
      lower ≤ upper
    else {
      return nil
    }
    return lower...upper
  }

  // MARK: - RangeFamily

  /// `true` if the type has a closed upper bound.
  @inlinable public static var hasClosedUpperBound: Bool {
    return true
  }

  // MARK: - SetDefinition

  public typealias Element = Bound
}

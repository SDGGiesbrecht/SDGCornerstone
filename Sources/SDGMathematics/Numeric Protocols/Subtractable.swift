/*
 Subtractable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A type that can do scalar subtraction.
///
/// - Note: `Subtractable` is distinct from `Negatable` to allow whole number types to perform subtraction.
///
/// - Note: Unlike `Numeric`, `Subtractable` types do not need to conform to `Comparable`, allowing conformance by two‐dimensional vectors, etc.
public protocol Subtractable: Addable {

  /// Returns the difference of the preceding value minus the following value.
  ///
  /// - Parameters:
  ///     - precedingValue: The starting value.
  ///     - followingValue: The value to subtract.
  static func − (precedingValue: Self, followingValue: Self) -> Self

  /// Subtracts the following value from the preceding value.
  ///
  /// - Parameters:
  ///     - precedingValue: The value to modify.
  ///     - followingValue: The value to subtract.
  static func −= (precedingValue: inout Self, followingValue: Self)

  /// Returns a tuple containing the sum and difference of `precedingValue` and `followingValue`.
  ///
  /// - Parameters:
  ///     - precedingValue: The augend/minuend.
  ///     - followingValue: The addend/subtrahend.
  static func ± (precedingValue: Self, followingValue: Self) -> (sum: Self, difference: Self)
}

extension Subtractable {

  #warning("Debugging...")
  public func verifySubtractable() {
    verifyAddable()
    _ = self − self
    print(#function, Self.self)
  }

  @inlinable public static func − (precedingValue: Self, followingValue: Self) -> Self {
    return nonmutatingVariant(of: −=, on: precedingValue, with: followingValue)
  }

  @inlinable public static func ± (
    precedingValue: Self,
    followingValue: Self
  ) -> (sum: Self, difference: Self) {
    return (precedingValue + followingValue, precedingValue − followingValue)
  }
}

/*extension Subtractable where Self: Numeric {

  // @documentation(SDGCornerstone.Subtractable.ASCII.−(_:_:))
  /// Subtracts one value from another and produces their difference.
  ///
  /// - Parameters:
  ///     - precedingValue: The minuend.
  ///     - followingValue: The subtrahend.
  @inlinable public static func - (  // @exempt(from: unicode)
    precedingValue: Self,
    followingValue: Self
  ) -> Self {
    return precedingValue − followingValue
  }

  // @documentation(SDGCornerstone.Subtractable.ASCII.−=(_:_:))
  /// Subtracts the second value from the first and stores the difference in the left‐hand‐side variable.
  ///
  /// - Parameters:
  ///     - precedingValue: The minuend.
  ///     - followingValue: The subtrahend.
  @inlinable public static func -= (  // @exempt(from: unicode)
    precedingValue: inout Self,
    followingValue: Self
  ) {
    precedingValue −= followingValue
  }
}

extension Subtractable where Self: Strideable, Self.Stride == Self {

  // #documentation(SDGCornerstone.Subtractable.ASCII.−(_:_:))
  /// Subtracts one value from another and produces their difference.
  ///
  /// - Parameters:
  ///     - precedingValue: The minuend.
  ///     - followingValue: The subtrahend.
  @inlinable public static func - (  // @exempt(from: unicode)
    precedingValue: Self,
    followingValue: Self
  ) -> Self {
    return precedingValue − followingValue
  }

  // #documentation(SDGCornerstone.Subtractable.ASCII.−=(_:_:))
  /// Subtracts the second value from the first and stores the difference in the left‐hand‐side variable.
  ///
  /// - Parameters:
  ///     - precedingValue: The minuend.
  ///     - followingValue: The subtrahend.
  @inlinable public static func -= (  // @exempt(from: unicode)
    precedingValue: inout Self,
    followingValue: Self
  ) {
    precedingValue −= followingValue
  }
}*/

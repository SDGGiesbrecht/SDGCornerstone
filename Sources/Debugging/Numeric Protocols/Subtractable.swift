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
  public func verifySubtractable() {
    _ = self − self
    print(#function)
  }
}

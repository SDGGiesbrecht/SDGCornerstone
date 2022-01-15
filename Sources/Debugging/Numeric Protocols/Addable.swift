/// A type that can be used with `+(_:_:)`.
///
/// The precise behaviour of `+` depends on the conforming type. It may be arithmetic addition, string concatenation, etc.
public protocol Addable {

  // @documentation(Addable.+)
  /// Returns the sum, concatenation, or the result of a similar operation on two values implied by the “+” symbol.
  ///
  /// Exact behaviour depends on the type.
  ///
  /// - Parameters:
  ///     - precedingValue: The starting value.
  ///     - followingValue: The value to add.
  static func + (precedingValue: Self, followingValue: Self) -> Self

  /// Adds or concatenates the following value to the preceding value, or performs a similar operation implied by the “+” symbol.
  ///
  /// Exact behaviour depends on the type.
  ///
  /// - Parameters:
  ///     - precedingValue: The value to modify.
  ///     - followingValue: The value to add.
  static func += (precedingValue: inout Self, followingValue: Self)
}

extension Addable {
  public func verifyAddable() {
    _ = self + self
    print(#function)
  }
}

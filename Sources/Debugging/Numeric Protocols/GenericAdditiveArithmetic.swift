/// A value that can be added and subtracted.
///
/// `GenericAdditiveArithmetic` types do not need to conform to `Comparable`, allowing conformance by two‐dimensional vectors, etc. For additional behaviour specific to one‐dimensional types, see `NumericAdditiveArithmetic`.
public protocol GenericAdditiveArithmetic: AdditiveArithmetic, Decodable, Encodable, Hashable,
  Subtractable
{}

extension GenericAdditiveArithmetic {
  public func verifyGenericAdditiveArithmetic() {
    verifyAdditiveArithmetic()
    verifyDecodable()
    verifyHashable()
    verifySubtractable()
    print(#function)
  }
}

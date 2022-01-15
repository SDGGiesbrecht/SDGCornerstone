/// A value that can be added and subtracted.
///
/// `GenericAdditiveArithmetic` types do not need to conform to `Comparable`, allowing conformance by two‐dimensional vectors, etc. For additional behaviour specific to one‐dimensional types, see `NumericAdditiveArithmetic`.
public protocol GenericAdditiveArithmetic: AdditiveArithmetic, Decodable, Encodable, Hashable
{}

extension GenericAdditiveArithmetic {
  public func verifyGenericAdditiveArithmetic() {
    var hasher = Hasher()
    hash(into: &hasher)
    print(#function)
  }
}

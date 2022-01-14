extension Hashable {

  public func verifyHashable() {
    verifyEquatable()
    var hasher = Hasher()
    hash(into: &hasher)
    print(#function)
  }
}

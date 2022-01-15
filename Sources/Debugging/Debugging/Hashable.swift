extension Hashable {

  public func verifyHashable() {
    var hasher = Hasher()
    hash(into: &hasher)
  }
}

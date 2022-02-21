import SDGMathematics

extension _Hashable {

  func exerciseHashableHashing() {
    #warning("Debugging...")
    #if false
    _ = self == self
    #endif

    var hasher = Hasher()
    hash(into: &hasher)

    var dictionary: [_HashableWrapper<Self>: Bool] = [:]
    dictionary[_HashableWrapper(self)] = true
  }
}

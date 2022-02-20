import SDGMathematics

extension _Hashable {

  func exerciseHashableHashing() {
    var hasher = Hasher()
    hash(into: &hasher)

    var dictionary: [_HashableWrapper<Self>: Bool] = [:]
    dictionary[_HashableWrapper(self)] = true
  }
}

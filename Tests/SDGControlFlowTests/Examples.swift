/*
 Examples.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

// @example(nonmutatingVariant)
extension Array where Element: Comparable {

  func sorted() -> Array {
    return nonmutatingVariant(of: { $0.sort() }, on: self)
  }
  func appending(_ appendix: Array) -> Array {
    return nonmutatingVariant(of: { $0.append(contentsOf: $1) }, on: self, with: appendix)
  }
  static func + (a: Array, b: Array) -> Array {
    return nonmutatingVariant(of: +=, on: a, with: b)
  }
}
// @endExample

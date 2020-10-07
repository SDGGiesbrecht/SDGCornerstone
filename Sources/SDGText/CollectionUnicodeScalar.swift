/*
 CollectionUnicodeScalar.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3, Web doesn’t have Foundation yet.)
#if !os(WASI)
  import Foundation
#endif

import SDGCollections

extension Collection where Element == Unicode.Scalar {

  /// Whether or not the string‐like collection contains multiple lines.
  @inlinable public var isMultiline: Bool {
    return contains(where: { $0 ∈ NewlinePattern.newlineCharacters })
  }
}

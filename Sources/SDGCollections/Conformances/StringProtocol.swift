/*
 StringProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension StringProtocol {

  @inlinable internal func hasSuffixAsStringProtocol<Suffix>(
    _ suffix: Suffix
  ) -> Bool where Suffix: StringProtocol {
    hasSuffix(suffix)
  }
}

extension StringProtocol where Self: SearchableBidirectionalCollection {

  // Disambiguate between StringProtocol and SearchableBidirectionalCollection.
  @inlinable public func hasSuffix<Suffix>(
    _ suffix: Suffix
  ) -> Bool where Suffix: StringProtocol {
    hasSuffixAsStringProtocol(suffix)
  }
}

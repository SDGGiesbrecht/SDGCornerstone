/*
 NewlinePattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
#if canImport(Foundation)
  import struct Foundation.CharacterSet
#endif

import SDGLogic
import SDGCollections

/// A pattern representing any newline variant.
public struct NewlinePattern: Pattern {

  // MARK: - Static Properties

  private static let carriageReturn: Unicode.Scalar = "\u{D}"
  private static let lineFeed: Unicode.Scalar = "\u{A}"
  // #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
  #if !canImport(Foundation)
    @usableFromInline internal static let newlineCharacters: Set<Unicode.Scalar> = [
      "\u{A}",
      "\u{B}",
      "\u{C}",
      "\u{D}",
      "\u{85}",
      "\u{2028}",
      "\u{2029}"
    ]
  #else
    @usableFromInline internal static let newlineCharacters = CharacterSet.newlines
  #endif
  @usableFromInline internal static let newline = NewlinePattern(
    carriageReturnLineFeed: (carriageReturn, lineFeed)
  )

  // MARK: - Initialization

  @usableFromInline internal init(carriageReturnLineFeed: (Unicode.Scalar, Unicode.Scalar)) {
    carriageReturn = carriageReturnLineFeed.0
    lineFeed = carriageReturnLineFeed.1
  }

  // MARK: - Properties

  @usableFromInline internal let carriageReturn: Unicode.Scalar
  @usableFromInline internal let lineFeed: Unicode.Scalar

  // MARK: - Pattern

  public typealias Element = Unicode.Scalar

  @inlinable public func matches<C: SearchableCollection>(in collection: C, at location: C.Index)
    -> [Range<C.Index>] where C.Element == Unicode.Scalar
  {

    let scalar = collection[location]
    guard scalar ∈ NewlinePattern.newlineCharacters else {
      return []
    }
    var result = [(location...location).relative(to: collection)]

    if scalar == carriageReturn {
      let nextIndex = collection.index(after: location)
      if nextIndex ≠ collection.endIndex,
        collection[nextIndex] == lineFeed
      {
        result.prepend(location..<collection.index(location, offsetBy: 2))
      }
    }
    return result
  }

  @inlinable public func primaryMatch<C: SearchableCollection>(
    in collection: C,
    at location: C.Index
  ) -> Range<C.Index>? where C.Element == Unicode.Scalar {

    let scalar = collection[location]
    guard scalar ∈ NewlinePattern.newlineCharacters else {
      return nil
    }

    if scalar == carriageReturn {
      let nextIndex = collection.index(after: location)
      if nextIndex ≠ collection.endIndex,
        collection[nextIndex] == lineFeed
      {
        return location..<collection.index(location, offsetBy: 2)
      }
    }
    return (location...location).relative(to: collection)
  }

  @inlinable public func reversed() -> NewlinePattern {
    return NewlinePattern(carriageReturnLineFeed: (lineFeed, carriageReturn))
  }
}

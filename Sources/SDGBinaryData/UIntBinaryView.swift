/*
 UIntBinaryView.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGMathematics
import SDGCollections

/// A view of the contents of a fixed‐length unsigned integer as a collection of bits.
public struct BinaryView<UIntValue: UIntFamily>: BidirectionalCollection, Collection,
  CustomStringConvertible, MutableCollection, RandomAccessCollection, TextualPlaygroundDisplay
{

  // MARK: - Initialization

  @inlinable internal init(_ uInt: UIntValue) {
    self.uInt = uInt
  }

  // MARK: - Static Properties

  /// The position of the first element in any instance.
  @inlinable public static var startIndex: Index {
    return 0
  }

  /// The position following the last valid index in any instance.
  @inlinable public static var endIndex: Index {
    return Index(count)
  }

  /// The number of elements in any instance.
  @inlinable public static var count: Int {
    let bytes = MemoryLayout<UIntValue>.size
    return bytes × 8
  }

  // MARK: - Properties

  @usableFromInline internal var uInt: UIntValue

  // MARK: - BidirectionalCollection

  @inlinable public func index(before i: Index) -> Index {
    return i − (1 as Index)
  }

  // MARK: - Collection

  public typealias Element = Bool
  public typealias Index = UIntValue
  public typealias Indices = DefaultIndices<BinaryView>

  @inlinable public var startIndex: Index {
    return BinaryView.startIndex
  }
  @inlinable public var endIndex: Index {
    return BinaryView.endIndex
  }

  @inlinable public func index(after i: Index) -> Index {
    return i + (1 as Index)
  }

  @inlinable internal func assertIndexExists(_ index: Index) {
    _assert(
      index ∈ bounds,
      { (localization: _APILocalization) in  // @exempt(from: tests)
        switch localization {  // @exempt(from: tests)
        case .englishCanada:
          return "Index out of bounds."
        }
      }
    )
  }

  @inlinable public subscript(position: Index) -> Element {
    get {
      #if false
      assertIndexExists(position)
      #endif
      return uInt.bitwiseAnd(with: 1 << position) >> position == 1
    }
    set {
      assertIndexExists(position)
      let oldErased = uInt.bitwiseAnd(with: ((1 as Index) << position).bitwiseNot())
      uInt = oldErased.bitwiseOr(with: (newValue ? 1 : 0) << position)
    }
  }

  // MARK: - CustomStringConvertible

  public var description: String {
    let bits = self.map { bit in
      return bit ? "1" : "0"
    }
    return bits.joined()
  }
}

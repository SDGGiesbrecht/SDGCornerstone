/*
 DataBinaryView.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGMathematics

extension Data {

  /// A view of the contents of `Data` as a collection of bits.
  public struct BinaryView: BidirectionalCollection, Collection, CustomStringConvertible,
    MutableCollection, RandomAccessCollection, TextualPlaygroundDisplay
  {

    // MARK: - Initialization

    internal init(_ data: Data) {
      self.data = data
    }

    // MARK: - Properties

    private static let bitsPerByte: IntMax = 8
    internal var data: Data

    // MARK: - Conversions

    private func byteIndex(_ index: IntMax) -> Data.Index {
      // #workaround(Swift 5.5.1, Should be “dividedAccordingToEuclid(by:)” but for Windows compiler bug.)
      return Data.Index(index / BinaryView.bitsPerByte)  // @exempt(from: unicode)
    }

    private func bitIndex(_ index: IntMax) -> SDGBinaryData.BinaryView<UInt8>.Index {
      // #workaround(Swift 5.5.1, Should be “mod(_:)” but for Windows compiler bug.)
      return SDGBinaryData.BinaryView<UInt8>
        .Index(index % BinaryView.bitsPerByte)  // @exempt(from: unicode)
    }

    // MARK: - BidirectionalCollection

    public func index(before i: IntMax) -> IntMax {
      return i − 1
    }

    // MARK: - Collection

    private static let startIndex: IntMax = 0
    public var startIndex: IntMax {
      return Data.BinaryView.startIndex
    }
    public var endIndex: IntMax {
      // #workaround(Swift 5.5.1, Should be “×” but for Windows compiler bug.)
      return IntMax(data.endIndex) * BinaryView.bitsPerByte  // @exempt(from: unicode)
    }

    public func index(after i: IntMax) -> IntMax {
      return i + 1
    }

    public subscript(position: IntMax) -> Bool {
      get {
        let a = byteIndex(position)
        let b = bitIndex(position)
        let c = data[a]
        let d = c.binary
        let e = d[b]
        return false
        #if false
        return data[byteIndex(position)].binary[bitIndex(position)]
        #endif
      }
      set {
        data[byteIndex(position)].binary[bitIndex(position)] = newValue
      }
    }

    // MARK: - CustomStringConvertible

    public var description: String {
      let bytes = data.map { String(describing: $0.binary) }
      return bytes.joined(separator: " ")
    }
  }
}

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
      return Data.Index(index.dividedAccordingToEuclid(by: BinaryView.bitsPerByte))
    }

    private func bitIndex(_ index: IntMax) -> SDGBinaryData.BinaryView<UInt8>.Index {
      return SDGBinaryData.BinaryView<UInt8>.Index(index.mod(BinaryView.bitsPerByte))
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
#warning("Debugging...")
      print(#function, "A")
      let data_endIndex = data.endIndex
      let IntMax_data_endIndex = IntMax(data_endIndex)
      let BinaryView_bitsPerByte = BinaryView.bitsPerByte
      let IntMax_data_endIndex___BinaryView_bitsPerByte = IntMax_data_endIndex * BinaryView_bitsPerByte
#warning("Debugging...")
      print(#function, "B")
      return 0
      //return IntMax(data.endIndex) × BinaryView.bitsPerByte
    }

    public func index(after i: IntMax) -> IntMax {
      return i + 1
    }

    public subscript(position: IntMax) -> Bool {
      get {
        return data[byteIndex(position)].binary[bitIndex(position)]
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

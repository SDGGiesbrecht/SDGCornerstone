/*
 DataStream.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

/// A data stream.
///
/// Data streams are used to combine several distinct units of data into a single stream and separate the stream back into distinct units later, such as after transfering the stream over a network connection.
public struct DataStream {

    // MARK: - Initialization

    /// Creates a data stream.
    public init() {}

    // MARK: - Properties

    /// The portion of the data stream currently in the buffer.
    public var buffer = Data()

    // MARK: - Units

    private static let endMarker: Data.Element = 0x17 // C0 End of Transmission Block
    private static let endData = Data([endMarker])

    private static let escapeMarker: Data.Element = 0x10 // C0 Data Link Escape
    private static let escapeData = Data([escapeMarker])

    /// Appends a unit of data.
    public mutating func append(unit: Data) {
        var unit = unit

        func escape(_ element: Data, in data: inout Data) {
            data.replaceMatches(for: element, with: DataStream.escapeData + element)
        }

        escape(DataStream.escapeData, in: &unit)
        escape(DataStream.endData, in: &unit)
        unit.append(DataStream.endMarker)

        buffer.append(contentsOf: unit)
    }

    /// Extracts an array of all complete units and returns them.
    ///
    /// If the final unit is incomplete, it will not be extracted and will remain in the buffer.
    public mutating func extractCompleteUnits() -> [Data] {
        let endMarkerRanges = buffer.matches(for: DataStream.endData).filter() { (match: PatternMatch<Data>) -> Bool in

            // Count escapes.
            var escapes = 0
            for byte in buffer.prefix(upTo: match.range.lowerBound).reversed() {
                if byte == DataStream.escapeMarker {
                    escapes += 1
                } else {
                    break
                }
            }

            // An odd number of escapes means the last one affects the marker.
            return ¬escapes.isOdd
        }

        let unitRanges = buffer.ranges(separatedBy: endMarkerRanges.map({ $0.range }))

        var unitsAndRemainder = unitRanges.map() { Data(buffer[$0]) }

        buffer = unitsAndRemainder.removeLast()

        return unitsAndRemainder.map() { (unit: Data) -> Data in
            var unit = unit

            func unescape(_ element: Data, in data: inout Data) {
                data.replaceMatches(for: DataStream.escapeData + element, with: element)
            }

            unescape(DataStream.endData, in: &unit)
            unescape(DataStream.escapeData, in: &unit)

            return unit
        }
    }
}

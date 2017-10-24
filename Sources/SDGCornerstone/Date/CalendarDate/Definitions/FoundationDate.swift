/*
 FoundationDate.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

internal struct FoundationDate : DateDefinition {

    // MARK: - Initialization

    internal init(_ date: Date) {
        self.date = date
        self.intervalSinceReferenceDate = FloatMax(date.timeIntervalSinceReferenceDate).seconds
    }

    // MARK: - Properties

    internal let date: Date

    // MARK: - DateDefinition

    internal static let identifier: StrictString = "Foundation"
    internal static let referenceDate = CalendarDate(gregorian: .january, 1, 2001)
    internal var intervalSinceReferenceDate: CalendarInterval<FloatMax>

    internal init(intervalSinceReferenceDate: CalendarInterval<FloatMax>) {
        self.intervalSinceReferenceDate = intervalSinceReferenceDate
        self.date = Date(timeIntervalSinceReferenceDate: TimeInterval(intervalSinceReferenceDate.inSeconds))
    }

    // MARK: - Decodable

    // [_Inherit Documentation: SDGCornerstone.Decodable.init(from:)_]
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws {
        try self.init(from: decoder, via: Date.self, convert: { FoundationDate($0) }, debugErrorDescription: { _ in unreachable() })
    }

    // MARK: - Encodable

    // [_Inherit Documentation: SDGCornerstone.Encodable.encode(to:)_]
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws {
        try encode(to: encoder, via: [date])
    }
}

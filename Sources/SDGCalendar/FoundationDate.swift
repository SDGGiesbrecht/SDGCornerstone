/*
 FoundationDate.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGCornerstoneLocalizations

internal struct FoundationDate : DateDefinition, TransparentWrapper {

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

    // #documentation(SDGCornerstone.Decodable.init(from:))
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    internal init(from decoder: Decoder) throws {
        try self.init(from: decoder, via: Date.self, convert: { FoundationDate($0) })
    }

    // MARK: - Encodable

    // #documentation(SDGCornerstone.Encodable.encode(to:))
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    internal func encode(to encoder: Encoder) throws {
        try encode(to: encoder, via: date)
    }

    // MARK: - TransparentWrapper

    // #documentation(SDGCornerstone.TransparentWrapper.wrapped)
    /// The wrapped instance.
    public var wrappedInstance: Any {
        return date
    }
}

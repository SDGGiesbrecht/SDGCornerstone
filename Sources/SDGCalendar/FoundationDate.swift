/*
 FoundationDate.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

    internal init(from decoder: Decoder) throws {
        try self.init(from: decoder, via: Date.self, convert: { FoundationDate($0) })
    }

    // MARK: - Encodable

    internal func encode(to encoder: Encoder) throws {
        try encode(to: encoder, via: date)
    }

    // MARK: - TransparentWrapper

    public var wrappedInstance: Any {
        return date
    }
}

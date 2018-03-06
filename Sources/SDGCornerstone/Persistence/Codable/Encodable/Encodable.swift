/*
 Encodable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Encodable where Self : ConsistentlyOrderedCalendarComponent, Self : EnumerationCalendarComponent {
    // MARK: - where Self : ConsistentlyOrderedCalendarComponent, Self : EnumerationCalendarComponent

    internal func encodeUsingOrdinal(to encoder: Encoder) throws {
        // For GregorianMonth, GregorianWeekday & HebrewWeekday
        try encode(to: encoder, via: ordinal)
    }
}

extension Encodable where Self : EncodableViaCustomStringConvertible {
    // MARK: - where Self : EncodableViaCustomStringConvertible

    // [_Inherit Documentation: SDGCornerstone.Encodable.encode(to:)_]
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws {
        try encode(to: encoder, via: description)
    }
}

extension Encodable where Self : EncodableViaIntegerProtocol {
    // MARK: - where Self : EncodableViaIntegerProtocol

    // [_Inherit Documentation: SDGCornerstone.Encodable.encode(to:)_]
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws {
        try encode(to: encoder, via: inDigits())
    }
}

extension Encodable where Self : EncodableViaRawRepresentableCalendarComponent {
    // MARK: - where Self : EncodableViaRawRepresentableCalendarComponent

    // [_Inherit Documentation: SDGCornerstone.Encodable.encode(to:)_]
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws {
        try encode(to: encoder, via: rawValue)
    }
}

extension Encodable where Self : EncodableViaWholeNumberProtocol {
    // MARK: - where Self : EncodableViaWholeNumberProtocol

    // [_Inherit Documentation: SDGCornerstone.Encodable.encode(to:)_]
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws {
        try encode(to: encoder, via: inDigits())
    }
}

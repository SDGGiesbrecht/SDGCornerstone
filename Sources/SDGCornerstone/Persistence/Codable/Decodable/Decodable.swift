/*
 Decodable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Decodable {

    // [_Define Documentation: SDGCornerstone.Decodable.init(from:)_]
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.

    /// Creates a new instance by decoding a proxy type from the given decoder.
    public init<Other>(from decoder: Decoder, via type: Other.Type, convert: (_ other: Other) throws -> Self?, debugErrorDescription: (Other) -> StrictString) throws where Other : Decodable {
        let container = try decoder.singleValueContainer()
        let other = try container.decode(Other.self)

        func generateError(underlyingError: Error?, description: StrictString) -> DecodingError {
            let context = DecodingError.Context(codingPath: container.codingPath, debugDescription: String(description), underlyingError: underlyingError)
            return DecodingError.typeMismatch(Self.self, context)
        }

        do {
            guard let decoded = try convert(other) else {
                throw generateError(underlyingError: nil, description: debugErrorDescription(other))
            }
            self = decoded
        } catch let error {
            throw generateError(underlyingError: error, description: debugErrorDescription(other))
        }
    }

    /// Creates a new instance by decoding a proxy string from the given decoder.
    public init<Other>(from decoder: Decoder, via type: Other.Type, convert: (_ other: Other) throws -> Self?) throws where Other : StringFamily {
        try self.init(from: decoder, via: type, convert: convert, debugErrorDescription: { (invalidString: Other) -> StrictString in
            let description = UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
                switch localization {
                case .englishCanada:
                    return StrictString("Invalid string representation: \(invalidString)")
                }
            })
            return description.resolved()
        })
    }
}

extension Decodable where Self : ConsistentlyOrderedCalendarComponent, Self : EnumerationCalendarComponent, Self.RawValue == Self.Vector {
    // MARK: - where Self : ConsistentlyOrderedCalendarComponent, Self : EnumerationCalendarComponent, Self.RawValue == Self.Vector

    internal init(usingOrdinalFrom decoder: Decoder) throws {
        // For GregorianMonth, GregorianWeekday & HebrewWeekday
        try self.init(from: decoder, via: Vector.self, convert: { Self(rawValue: $0 − (1 as Vector)) }, debugErrorDescription: { (invalidRawValue: Vector) -> StrictString in
            return RawRepresentableError.invalidRawValue(invalidRawValue, Self.self).debugDescription.resolved()
        })
    }
}

extension Decodable where Self : DecodableViaLosslessStringConvertible {
    // MARK: - where Self : DecodableViaLosslessStringConvertible

    // [_Inherit Documentation: SDGCornerstone.Decodable.init(from:)_]
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws {
        try self.init(from: decoder, via: String.self, convert: { Self($0) })
    }
}

extension Decodable where Self : DecodableViaMeasurement {
    // MARK: - where Self : DecodableViaMeasurement

    // [_Inherit Documentation: SDGCornerstone.Decodable.init(from:)_]
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws {
        try self.init(from: decoder, via: Scalar.self, convert: { Self(rawValue: $0) }, debugErrorDescription: { _ in
            unreachable()
        })
    }
}

extension Decodable where Self : DecodableViaRawRepresentableCalendarComponent {
    // MARK: - where Self : DecodableViaRawRepresentableCalendarComponent

    // [_Inherit Documentation: SDGCornerstone.Decodable.init(from:)_]
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws {
        try self.init(from: decoder, via: RawValue.self, convert: { try Self(possibleRawValue: $0) }, debugErrorDescription: { (invalidRawValue: RawValue) -> StrictString in
            return RawRepresentableError.invalidRawValue(invalidRawValue, Self.self).debugDescription.resolved()
        })
    }
}

extension Decodable where Self : DecodableViaWholeArithmetic {
    // MARK: - where Self : DecodableViaWholeArithmetic

    // [_Inherit Documentation: SDGCornerstone.Decodable.init(from:)_]
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws {
        try self.init(from: decoder, via: StrictString.self, convert: { try Self(possibleDecimal: $0) })
    }
}

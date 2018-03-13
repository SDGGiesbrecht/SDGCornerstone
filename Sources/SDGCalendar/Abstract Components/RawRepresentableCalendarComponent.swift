/*
 RawRepresentableCalendarComponent.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstoneLocalizations

/// A calendar component defined by a raw value.
public protocol RawRepresentableCalendarComponent : ConsistentlyOrderedCalendarComponent, ExpressibleByIntegerLiteral
where Vector : IntegralArithmetic {

    // MARK: - Associated Type

    // [_Define Documentation: SDGCornerstone.RawRepresentableCalendarComponent.RawValue_]
    /// The raw value type.
    typealias  RawValue = Vector

    // [_Define Documentation: SDGCornerstone.RawRepresentableCalendarComponent.init(unsafeRawValue:)_]
    /// Creates an instance with an unchecked raw value.
    ///
    /// - Note: Do not call this initializer directly. Call `init(_:)` instead, because it validates the raw value before passing it to this initializer.
    init(unsafeRawValue: RawValue)

    // [_Define Documentation: SDGCornerstone.RawRepresentableCalendarComponent.validRange_]
    /// The valid range for raw values.
    static var validRange: Range<RawValue>? { get }

    // [_Define Documentation: SDGCornerstone.RawRepresentableCalendarComponent.rawValue_]
    /// The raw value.
    var rawValue: RawValue { get }
}

extension RawRepresentableCalendarComponent {

    // MARK: - Initialization

    /// Creates an instance from a raw value.
    @_inlineable public init(_ value: RawValue) {
        guard let result = Self(possibleRawValue: value) else {
            preconditionFailure(UserFacingText({ (localization: APILocalization) in
                switch localization {
                case .englishCanada:
                    return StrictString("Raw value invalid for “\(Self.self)”: \(value)")
                }
            }))
        }
        self = result
    }

    /// Creates an instance from a raw value.
    @_inlineable public init?(possibleRawValue value: RawValue) {
        if let range = Self.validRange,
            value ∉ range {
            return nil
        }
        self.init(unsafeRawValue: value)
    }

    // MARK: - ExpressibleByIntegerLiteral

    // [_Inherit Documentation: SDGCornerstone.ExpressibleByIntegerLiteral.init(integerLiteral:)_]
    /// Creates an instance from an integer literal.
    ///
    /// - Parameters:
    ///     - integerLiteral: The integer literal.
    @_inlineable public init(integerLiteral: UIntMax) {
        self.init(RawValue(integerLiteral))
    }
}

/// A type that conforms to `Codable` through its `RawRepresentableCalendarComponent` interface.
///
/// Conformance Requirements:
///     - `RawRepresentableCalendarComponent`
public protocol CodableViaRawRepresentableCalendarComponent : RawRepresentableCalendarComponent {

}

extension CodableViaRawRepresentableCalendarComponent {

    // [_Inherit Documentation: SDGCornerstone.Encodable.encode(to:)_]
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    @_inlineable public func encode(to encoder: Encoder) throws {
        try encode(to: encoder, via: rawValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Decodable.init(from:)_]
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    @_inlineable public init(from decoder: Decoder) throws {
        try self.init(from: decoder, via: RawValue.self, convert: { Self(possibleRawValue: $0) })
    }
}

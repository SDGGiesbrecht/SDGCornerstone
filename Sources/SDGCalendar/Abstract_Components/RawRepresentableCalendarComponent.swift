/*
 RawRepresentableCalendarComponent.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections
import SDGCornerstoneLocalizations

/// A calendar component defined by a raw value.
public protocol RawRepresentableCalendarComponent : ConsistentlyOrderedCalendarComponent, ExpressibleByIntegerLiteral
where Vector : IntegralArithmetic {

    // MARK: - Associated Type

    // @documentation(SDGCornerstone.RawRepresentableCalendarComponent.RawValue)
    /// The raw value type.
    typealias  RawValue = Vector

    // @documentation(SDGCornerstone.RawRepresentableCalendarComponent.init(unsafeRawValue:))
    /// Creates an instance with an unchecked raw value.
    ///
    /// - Note: Do not call this initializer directly. Call `init(_:)` instead, because it validates the raw value before passing it to this initializer.
    init(unsafeRawValue: RawValue)

    // @documentation(SDGCornerstone.RawRepresentableCalendarComponent.validRange)
    /// The valid range for raw values.
    static var validRange: Range<RawValue>? { get }

    // @documentation(SDGCornerstone.RawRepresentableCalendarComponent.rawValue)
    /// The raw value.
    var rawValue: RawValue { get }
}

extension RawRepresentableCalendarComponent {

    // MARK: - Initialization

    /// Creates an instance from a raw value.
    @inlinable public init(_ value: RawValue) {
        guard let result = Self(possibleRawValue: value) else {
            preconditionFailure(UserFacing<StrictString, APILocalization>({ localization in
                switch localization {
                case .englishCanada: // @exempt(from: tests)
                    return StrictString("Raw value invalid for “\(Self.self)”: \(value)")
                }
            }))
        }
        self = result
    }

    /// Creates an instance from a raw value.
    @inlinable public init?(possibleRawValue value: RawValue) {
        if let range = Self.validRange,
            value ∉ range {
            return nil
        }
        self.init(unsafeRawValue: value)
    }

    // MARK: - ExpressibleByIntegerLiteral

    // #documentation(SDGCornerstone.ExpressibleByIntegerLiteral.init(integerLiteral:))
    /// Creates an instance from an integer literal.
    ///
    /// - Parameters:
    ///     - integerLiteral: The integer literal.
    @inlinable public init(integerLiteral: UIntMax) {
        self.init(RawValue(integerLiteral))
    }
}

/// A type that conforms to `Codable` through its `RawRepresentableCalendarComponent` interface.
///
/// Conformance Requirements:
///
/// - `RawRepresentableCalendarComponent`
public protocol CodableViaRawRepresentableCalendarComponent : RawRepresentableCalendarComponent {

}

extension CodableViaRawRepresentableCalendarComponent {

    // #documentation(SDGCornerstone.Encodable.encode(to:))
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    @inlinable public func encode(to encoder: Encoder) throws {
        try encode(to: encoder, via: rawValue)
    }

    // #documentation(SDGCornerstone.Decodable.init(from:))
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    @inlinable public init(from decoder: Decoder) throws {
        try self.init(from: decoder, via: RawValue.self, convert: { Self(possibleRawValue: $0) })
    }
}

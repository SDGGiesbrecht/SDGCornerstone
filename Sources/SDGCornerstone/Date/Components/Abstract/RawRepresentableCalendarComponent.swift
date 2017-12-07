/*
 RawRepresentableCalendarComponent.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

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
    public init(_ value: RawValue) {
        do {
            self = try Self(possibleRawValue: value)
        } catch let error as RawRepresentableError<RawValue> {
            preconditionFailure(error.debugDescription)
        } catch {
            unreachable()
        }
    }

    /// Creates an instance from a raw value.
    public init(possibleRawValue value: RawValue) throws {
        if let range = Self.validRange,
            value ∉ range {
            throw RawRepresentableError.invalidRawValue(value, Self.self)
        }
        self.init(unsafeRawValue: value)
    }
}

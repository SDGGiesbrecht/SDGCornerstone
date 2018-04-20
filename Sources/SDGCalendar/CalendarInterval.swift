/*
 CalendarInterval.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGCornerstoneLocalizations

// MARK: - Definition

private let hebrewPartsPerDay = HebrewHour.hoursPerDay × HebrewPart.partsPerHour
private let secondsPerDay = GregorianHour.hoursPerDay × GregorianMinute.minutesPerHour × GregorianSecond.secondsPerMinute

@_versioned internal let integralUnitsPerDay = lcm(hebrewPartsPerDay, secondsPerDay)

/// A time interval.
///
/// The units are all defined as fractions or multiples of days. This makes them convenient for calendaring, but not for physics. (Seconds are not SI seconds and leap seconds do not exist.)
public struct CalendarInterval<Scalar : RationalArithmetic> : Codable, SDGMathematics.Measurement, TextualPlaygroundDisplay {

    // MARK: - Initialization

    /// Creates an interval from a number of Gregorian leap year cycles.
    @_inlineable public init(gregorianLeapYearCycles: Scalar) {
        self.inGregorianLeapYearCycles = gregorianLeapYearCycles
    }

    /// Creates an interval from a number of Hebrew moons.
    @_inlineable public init(hebrewMoons: Scalar) {
        self.inHebrewMoons = hebrewMoons
    }

    /// Creates an interval from a number of weeks.
    @_inlineable public init(weeks: Scalar) {
        self.inWeeks = weeks
    }

    /// Creates an interval from a number of days.
    @_inlineable public init(days: Scalar) {
        self.inDays = days
    }

    /// Creates an interval from a number of hours.
    @_inlineable public init(hours: Scalar) {
        self.inHours = hours
    }

    /// Creates an interval from a number of minutes.
    @_inlineable public init(minutes: Scalar) {
        self.inMinutes = minutes
    }

    /// Creates an interval from a number of Hebrew parts.
    @_inlineable public init(hebrewParts: Scalar) {
        self.inHebrewParts = hebrewParts
    }

    /// Creates an interval from a number of seconds.
    @_inlineable public init(seconds: Scalar) {
        self.inSeconds = seconds
    }

    // MARK: - Properties

    @_versioned internal var inUnits: Scalar = Scalar.additiveIdentity

    @_inlineable @_versioned internal var unitsPerGregorianLeapYearCycle: Scalar {
        return unitsPerDay × Scalar(GregorianYear.daysPerLeapYearCycle)
    }
    /// The numeric value in Gregorian leap year cycles.
    @_inlineable public var inGregorianLeapYearCycles: Scalar {
        get {
            return inUnits ÷ unitsPerGregorianLeapYearCycle
        }
        set {
            inUnits = newValue × unitsPerGregorianLeapYearCycle
        }
    }

    @_inlineable @_versioned internal var unitsPerHebrewMoon: Scalar {
        return Scalar(HebrewMonth.lengthOfMoon.inUnits)
    }
    /// The numeric value in Hebrew moons.
    @_inlineable public var inHebrewMoons: Scalar {
        get {
            return inUnits ÷ unitsPerHebrewMoon
        }
        set {
            inUnits = newValue × unitsPerHebrewMoon
        }
    }

    @_inlineable @_versioned internal var unitsPerWeek: Scalar {
        return unitsPerDay × Scalar(HebrewWeekday.daysPerWeek)
    }
    /// The numeric value in weeks.
    @_inlineable public var inWeeks: Scalar {
        get {
            return inUnits ÷ unitsPerWeek
        }
        set {
            inUnits = newValue × unitsPerWeek
        }
    }

    @_inlineable @_versioned internal var unitsPerDay: Scalar {
        return Scalar(integralUnitsPerDay)
    }
    /// The numeric value in days.
    @_inlineable public var inDays: Scalar {
        get {
            return inUnits ÷ unitsPerDay
        }
        set {
            inUnits = newValue × unitsPerDay
        }
    }

    @_inlineable @_versioned internal var unitsPerHour: Scalar {
        return unitsPerDay ÷ Scalar(HebrewHour.hoursPerDay)
    }
    /// The numeric value in hours.
    @_inlineable public var inHours: Scalar {
        get {
            return inUnits ÷ unitsPerHour
        }
        set {
            inUnits = newValue × unitsPerHour
        }
    }

    @_inlineable @_versioned internal var unitsPerMinute: Scalar {
        return unitsPerHour ÷ Scalar(GregorianMinute.minutesPerHour)
    }
    /// The numeric value in minutes.
    @_inlineable public var inMinutes: Scalar {
        get {
            return inUnits ÷ unitsPerMinute
        }
        set {
            inUnits = newValue × unitsPerMinute
        }
    }

    @_inlineable @_versioned internal var unitsPerHebrewPart: Scalar {
        return unitsPerHour ÷ Scalar(HebrewPart.partsPerHour)
    }
    /// The numeric value in Hebrew parts.
    @_inlineable public var inHebrewParts: Scalar {
        get {
            return inUnits ÷ unitsPerHebrewPart
        }
        set {
            inUnits = newValue × unitsPerHebrewPart
        }
    }

    @_inlineable @_versioned internal var unitsPerSecond: Scalar {
        return unitsPerMinute ÷ Scalar(GregorianSecond.secondsPerMinute)
    }
    /// The numeric value in seconds.
    @_inlineable public var inSeconds: Scalar {
        get {
            return inUnits ÷ unitsPerSecond
        }
        set {
            inUnits = newValue × unitsPerSecond
        }
    }

    // MARK: - CustomStringConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomStringConvertible.description_]
    /// A textual representation of the instance.
    public var description: String {
        return String(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                let number = self.inDays.inDigits(maximumDecimalPlaces: integralUnitsPerDay.inDigits().count + 1, radixCharacter: ".")
                if self == (1 as Scalar).days {
                    return number + " day"
                } else {
                    return number + " days"
                }
            }
        }).resolved())
    }

    // MARK: - Decodable

    // [_Inherit Documentation: SDGCornerstone.Decodable.init(from:)_]
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    @_inlineable public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let units = try container.decode(Scalar.self)
        let unitsPerDay = try container.decode(Int.self)
        self = CalendarInterval(days: units ÷ Scalar(unitsPerDay))
    }

    // MARK: - Encodable

    // [_Inherit Documentation: SDGCornerstone.Encodable.encode(to:)_]
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    @_inlineable public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(inUnits)
        try container.encode(integralUnitsPerDay)
    }

    // MARK: - Measurement

    // [_Inherit Documentation: SDGCornerstone.Measurement.init(rawValue:)_]
    /// Creates a measurement from a raw value in undefined but consistent units.
    ///
    /// Used by `Measurement`’s default implementation of methods where various units make no difference (such as multiplication by a scalar).
    @_inlineable public init(rawValue: Scalar) {
        inUnits = rawValue
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.rawValue_]
    /// A raw value in undefined but consistent units.
    ///
    /// Used by `Measurement`’s default implementation of methods where various units make no difference (such as multiplication by a scalar).
    @_inlineable public var rawValue: Scalar {
        get {
            return inUnits
        }
        set {
            inUnits = newValue
        }
    }
}

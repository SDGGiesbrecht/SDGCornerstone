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

// #workaround(workspace version 0.12.0, SwiftSyntax drops this section otherwise.)
private func helpSwiftSyntax() {} // @exempt(from: tests)

/// A time interval.
///
/// The units are all defined as fractions or multiples of days. This makes them convenient for calendaring, but not for physics. (Seconds are not SI seconds and leap seconds do not exist.)
public struct CalendarInterval<Scalar : RationalArithmetic> : Codable, SDGMathematics.Measurement, TextualPlaygroundDisplay {

    // MARK: - Initialization

    /// Creates an interval from a number of Gregorian leap year cycles.
    @inlinable public init(gregorianLeapYearCycles: Scalar) {
        self.inGregorianLeapYearCycles = gregorianLeapYearCycles
    }

    /// Creates an interval from a number of Hebrew moons.
    @inlinable public init(hebrewMoons: Scalar) {
        self.inHebrewMoons = hebrewMoons
    }

    /// Creates an interval from a number of weeks.
    @inlinable public init(weeks: Scalar) {
        self.inWeeks = weeks
    }

    /// Creates an interval from a number of days.
    @inlinable public init(days: Scalar) {
        self.inDays = days
    }

    /// Creates an interval from a number of hours.
    @inlinable public init(hours: Scalar) {
        self.inHours = hours
    }

    /// Creates an interval from a number of minutes.
    @inlinable public init(minutes: Scalar) {
        self.inMinutes = minutes
    }

    /// Creates an interval from a number of Hebrew parts.
    @inlinable public init(hebrewParts: Scalar) {
        self.inHebrewParts = hebrewParts
    }

    /// Creates an interval from a number of seconds.
    @inlinable public init(seconds: Scalar) {
        self.inSeconds = seconds
    }

    // MARK: - Properties

    @_versioned internal var inUnits: Scalar = Scalar.additiveIdentity

    @inlinable @_versioned internal var unitsPerGregorianLeapYearCycle: Scalar {
        return unitsPerDay × Scalar(GregorianYear.daysPerLeapYearCycle)
    }
    /// The numeric value in Gregorian leap year cycles.
    @inlinable public var inGregorianLeapYearCycles: Scalar {
        get {
            return inUnits ÷ unitsPerGregorianLeapYearCycle
        }
        set {
            inUnits = newValue × unitsPerGregorianLeapYearCycle
        }
    }

    @inlinable @_versioned internal var unitsPerHebrewMoon: Scalar {
        return Scalar(HebrewMonth.lengthOfMoon.inUnits)
    }
    /// The numeric value in Hebrew moons.
    @inlinable public var inHebrewMoons: Scalar {
        get {
            return inUnits ÷ unitsPerHebrewMoon
        }
        set {
            inUnits = newValue × unitsPerHebrewMoon
        }
    }

    @inlinable @_versioned internal var unitsPerWeek: Scalar {
        return unitsPerDay × Scalar(HebrewWeekday.daysPerWeek)
    }
    /// The numeric value in weeks.
    @inlinable public var inWeeks: Scalar {
        get {
            return inUnits ÷ unitsPerWeek
        }
        set {
            inUnits = newValue × unitsPerWeek
        }
    }

    @inlinable @_versioned internal var unitsPerDay: Scalar {
        return Scalar(integralUnitsPerDay)
    }
    /// The numeric value in days.
    @inlinable public var inDays: Scalar {
        get {
            return inUnits ÷ unitsPerDay
        }
        set {
            inUnits = newValue × unitsPerDay
        }
    }

    @inlinable @_versioned internal var unitsPerHour: Scalar {
        return unitsPerDay ÷ Scalar(HebrewHour.hoursPerDay)
    }
    /// The numeric value in hours.
    @inlinable public var inHours: Scalar {
        get {
            return inUnits ÷ unitsPerHour
        }
        set {
            inUnits = newValue × unitsPerHour
        }
    }

    @inlinable @_versioned internal var unitsPerMinute: Scalar {
        return unitsPerHour ÷ Scalar(GregorianMinute.minutesPerHour)
    }
    /// The numeric value in minutes.
    @inlinable public var inMinutes: Scalar {
        get {
            return inUnits ÷ unitsPerMinute
        }
        set {
            inUnits = newValue × unitsPerMinute
        }
    }

    @inlinable @_versioned internal var unitsPerHebrewPart: Scalar {
        return unitsPerHour ÷ Scalar(HebrewPart.partsPerHour)
    }
    /// The numeric value in Hebrew parts.
    @inlinable public var inHebrewParts: Scalar {
        get {
            return inUnits ÷ unitsPerHebrewPart
        }
        set {
            inUnits = newValue × unitsPerHebrewPart
        }
    }

    @inlinable @_versioned internal var unitsPerSecond: Scalar {
        return unitsPerMinute ÷ Scalar(GregorianSecond.secondsPerMinute)
    }
    /// The numeric value in seconds.
    @inlinable public var inSeconds: Scalar {
        get {
            return inUnits ÷ unitsPerSecond
        }
        set {
            inUnits = newValue × unitsPerSecond
        }
    }

    // MARK: - CustomStringConvertible

    // #documentation(SDGCornerstone.CustomStringConvertible.description)
    /// A textual representation of the instance.
    public var description: String {
        return String(UserFacing<StrictString, FormatLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                let number = self.inDays.inDigits(maximumDecimalPlaces: integralUnitsPerDay.inDigits().count + 1, radixCharacter: ".")
                if self == (1 as Scalar).days {
                    return number + " day"
                } else {
                    return number + " days"
                }
            case .deutschDeutschland:
                let number = self.inDays.inDigits(maximumDecimalPlaces: integralUnitsPerDay.inDigits().count + 1, radixCharacter: ",")
                if self == (1 as Scalar).days {
                    return number + " Tag"
                } else {
                    return number + " Tage"
                }
            case .françaisFrance:
                let number = self.inDays.inDigits(maximumDecimalPlaces: integralUnitsPerDay.inDigits().count + 1, radixCharacter: ",")
                if self == (1 as Scalar).days {
                    return number + " jour"
                } else {
                    return number + " jours"
                }
            case .ελληνικάΕλλάδα:
                let number = self.inDays.inDigits(maximumDecimalPlaces: integralUnitsPerDay.inDigits().count + 1, radixCharacter: ",")
                if self == (1 as Scalar).days {
                    return number + " ημέρα"
                } else {
                    return number + " ημέρες"
                }
            case .עברית־ישראל:
                let number = self.inDays.inDigits(maximumDecimalPlaces: integralUnitsPerDay.inDigits().count + 1, radixCharacter: ",")
                if self == (1 as Scalar).days {
                    return "יום אחד"
                } else if self == (2 as Scalar).days {
                    return "יומיים"
                } else {
                    return number + " יומים"
                }
            }
        }).resolved())
    }

    // MARK: - Decodable

    // #documentation(SDGCornerstone.Decodable.init(from:))
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    @inlinable public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let units = try container.decode(Scalar.self)
        let unitsPerDay = try container.decode(Int.self)
        self = CalendarInterval(days: units ÷ Scalar(unitsPerDay))
    }

    // MARK: - Encodable

    // #documentation(SDGCornerstone.Encodable.encode(to:))
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    @inlinable public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(inUnits)
        try container.encode(integralUnitsPerDay)
    }

    // MARK: - Measurement

    // #documentation(SDGCornerstone.Measurement.init(rawValue:))
    /// Creates a measurement from a raw value in undefined but consistent units.
    ///
    /// Used by `Measurement`’s default implementation of methods where various units make no difference (such as multiplication by a scalar).
    @inlinable public init(rawValue: Scalar) {
        inUnits = rawValue
    }

    // #documentation(SDGCornerstone.Measurement.rawValue)
    /// A raw value in undefined but consistent units.
    ///
    /// Used by `Measurement`’s default implementation of methods where various units make no difference (such as multiplication by a scalar).
    @inlinable public var rawValue: Scalar {
        get {
            return inUnits
        }
        set {
            inUnits = newValue
        }
    }
}

/*
 CalendarInterval.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGCornerstoneLocalizations

// MARK: - Definition

private let hebrewPartsPerDay = HebrewHour.hoursPerDay × HebrewPart.partsPerHour
private let secondsPerDay = GregorianHour.hoursPerDay × GregorianMinute.minutesPerHour × GregorianSecond.secondsPerMinute

@usableFromInline internal let integralUnitsPerDay = lcm(hebrewPartsPerDay, secondsPerDay)

/// A time interval.
///
/// The units are all defined as fractions or multiples of days. This makes them convenient for calendaring, but not for physics. (Seconds are not SI seconds and leap seconds do not exist.)
public struct CalendarInterval<Scalar : RationalArithmetic> : Decodable, Encodable, SDGMathematics.Measurement, TextualPlaygroundDisplay {

    // MARK: - Initialization

    /// Creates an interval from a number of Gregorian leap year cycles.
    ///
    /// - Parameters:
    ///     - gregorianLeapYearCycles: The number of leap year cycles.
    @inlinable public init(gregorianLeapYearCycles: Scalar) {
        self.inGregorianLeapYearCycles = gregorianLeapYearCycles
    }

    /// Creates an interval from a number of Hebrew moons.
    ///
    /// - Parameters:
    ///     - hebrewMoons: The number of moons.
    @inlinable public init(hebrewMoons: Scalar) {
        self.inHebrewMoons = hebrewMoons
    }

    /// Creates an interval from a number of weeks.
    ///
    /// - Parameters:
    ///     - weeks: The number of weeks.
    @inlinable public init(weeks: Scalar) {
        self.inWeeks = weeks
    }

    /// Creates an interval from a number of days.
    ///
    /// - Parameters:
    ///     - days: The number of days.
    @inlinable public init(days: Scalar) {
        self.inDays = days
    }

    /// Creates an interval from a number of hours.
    ///
    /// - Parameters:
    ///     - hours: The number of hours.
    @inlinable public init(hours: Scalar) {
        self.inHours = hours
    }

    /// Creates an interval from a number of minutes.
    ///
    /// - Parameters:
    ///     - minutes: The number of minutes.
    @inlinable public init(minutes: Scalar) {
        self.inMinutes = minutes
    }

    /// Creates an interval from a number of Hebrew parts.
    ///
    /// - Parameters:
    ///     - hebrewParts: The number of parts.
    @inlinable public init(hebrewParts: Scalar) {
        self.inHebrewParts = hebrewParts
    }

    /// Creates an interval from a number of seconds.
    ///
    /// - Parameters:
    ///     - seconds: The number of seconds.
    @inlinable public init(seconds: Scalar) {
        self.inSeconds = seconds
    }

    // MARK: - Properties

    @usableFromInline internal var inUnits: Scalar = Scalar.additiveIdentity

    @inlinable internal var unitsPerGregorianLeapYearCycle: Scalar {
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

    @inlinable internal var unitsPerHebrewMoon: Scalar {
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

    @inlinable internal var unitsPerWeek: Scalar {
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

    @inlinable internal var unitsPerDay: Scalar {
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

    @inlinable internal var unitsPerHour: Scalar {
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

    @inlinable internal var unitsPerMinute: Scalar {
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

    @inlinable internal var unitsPerHebrewPart: Scalar {
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

    @inlinable internal var unitsPerSecond: Scalar {
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
    ///
    /// - Parameters:
    ///     - rawValue: The raw value.
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

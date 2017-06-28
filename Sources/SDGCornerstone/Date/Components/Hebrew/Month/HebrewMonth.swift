/*
 HebrewMonth.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A month of the Hebrew year.
public enum HebrewMonth : Int, EnumerationCalendarComponent {

    // MARK: - Cases

    /// Tishrei
    case tishrei
    /// Cheshvan
    case cheshvan
    /// Kislev.
    case kislev
    /// Tevet.
    case tevet
    /// Shevat.
    case shevat

    /// The month of Adar I in a leap year.
    case adarI
    /// The month of Adar in a normal year.
    case adar
    /// The month of Adar II in a leap year.
    case adarII

    /// Nisan.
    case nisan
    /// Iyar.
    case iyar
    /// Sivan.
    case sivan
    /// Tammuz.
    case tammuz
    /// Av.
    case av
    /// Elul.
    case elul

    // MARK: - Static Properties

    /// The length of a Hebrew moon.
    public static let lengthOfMoon: CalendarInterval<FloatMax> = (29 as FloatMax).days + (12 as FloatMax).hours + (793 as FloatMax).hebrewParts

    /// The maximum number of days in any month.
    public static let maximumNumberOfDays: Int = {
        var max = 0
        for month in HebrewMonth.cases {
            max.increase(to: month.maximumNumberOfDays)
        }
        return max
    }()
    /// The minimum number of days in any month.
    public static let minimumNumberOfDays: Int = {
        var min = maximumNumberOfDays
        for month in HebrewMonth.cases {
            min.decrease(to: month.minimumNumberOfDays)
        }
        return min
    }()

    // MARK: - Properties

    /// Returns the number of days in the month for a year with given properties.
    public func numberOfDays(yearLength: HebrewYear.Length, leapYear: Bool) -> Int {

        switch self {

        case .tishrei, .shevat, .nisan, .sivan, .av:
            return 30

        case .tevet, .iyar, .tammuz, .elul:
            return 29

        case .cheshvan:
            switch yearLength {
            case .deficient, .normal:
                return 29
            case .whole:
                return 30
            }

        case .kislev:
            switch yearLength {
            case .normal, .whole:
                return 30
            case .deficient:
                return 29
            }

        case .adar:
            if ¬leapYear {
                return 29
            } else {
                return 0
            }

        case .adarI:
            if ¬leapYear {
                return 0
            } else {
                return 30
            }

        case .adarII:
            if ¬leapYear {
                return 0
            } else {
                return 29
            }
        }
    }

    private static var maximumNumberOfDaysCache: [HebrewMonth: Int] = [:]
    /// The maximum number of days in the month.
    public var maximumNumberOfDays: Int {
        return cached(in: &HebrewMonth.maximumNumberOfDaysCache[self]) {
            var max = 0
            for length in HebrewYear.Length.cases {
                max.increase(to: numberOfDays(yearLength: length, leapYear: false))
                max.increase(to: numberOfDays(yearLength: length, leapYear: true))
            }
            return max
        }
    }
    private static var minimumNumberOfDaysCache: [HebrewMonth: Int] = [:]
    /// The minimum number of days in the month.
    public var minimumNumberOfDays: Int {
        return cached(in: &HebrewMonth.minimumNumberOfDaysCache[self]) {
            var min = maximumNumberOfDays
            for length in HebrewYear.Length.cases {
                min.decrease(to: numberOfDays(yearLength: length, leapYear: false))
                min.decrease(to: numberOfDays(yearLength: length, leapYear: true))
            }
            return min
        }
    }

    // MARK: - Order

    /// Returns the next month.
    public func successor(leapYear: Bool) -> HebrewMonth {

        switch self {
        case .shevat:
            if ¬leapYear {
                // Normal Year
                return .adar
            } else {
                // Leap Year
                return .adarI
            }
        case .adarI:
            return .adarII
        case .adar, .adarII:
            return .nisan
        default:
            var result = self
            result.increment()
            return result
        }
    }

    /// Increments the month.
    public mutating func increment(leapYear: Bool) {
        self = successor(leapYear: leapYear)
    }

    /// Returns the previous month.
    public func predecessor(leapYear: Bool) -> HebrewMonth {

        switch self {
        case .nisan:
            if ¬leapYear {
                // Normal Year
                return .adar
            } else {
                // Leap Year
                return .adarII
            }
        case .adarII:
            return .adarI
        case .adar, .adarI:
            return .shevat
        default:
            var result = self
            result.decrement()
            return result
        }
    }

    /// Decrements the month.
    public mutating func decrement(leapYear: Bool) {
        self = predecessor(leapYear: leapYear)
    }

    /// Returns the next month, wrapping if necessary. If wrapping occurs, `wrap` will be executed.
    public func cyclicSuccessor(leapYear: Bool, _ wrap: () -> Void) -> HebrewMonth {
        if self == .elul {
            wrap()
            return .tishrei
        } else {
            return successor(leapYear: leapYear)
        }
    }

    /// Increments the month, wrapping if necessary. If wrapping occurs, `wrap` will be executed.
    public mutating func incrementCyclically(leapYear: Bool, _ wrap: () -> Void) {
        self = cyclicSuccessor(leapYear: leapYear, wrap)
    }

    /// Returns the previous month, wrapping if necessary. If wrapping occurs, `warp` will be executed.
    public func cyclicPredecessor(leapYear: Bool, _ wrap: () -> Void) -> HebrewMonth {
        if self == .tishrei {
            wrap()
            return .elul
        } else {
            return predecessor(leapYear: leapYear)
        }
    }

    /// Decrements the month, wrapping if necessary. If wrapping occurs, `wrap` will be executed.
    public mutating func decrementCyclically(leapYear: Bool, _ wrap: () -> Void) {
        self = cyclicPredecessor(leapYear: leapYear, wrap)
    }

    // MARK: - Recurrence

    /// Corrects the month for a normal or leap year. (For leap years: Adar → Adar II. For normal years: Adar I/Adar II → Adar)
    public mutating func correctForYear(leapYear: Bool) {
        if leapYear {
            if self == .adar {
                self = .adarII
            }
        } else {
            if self == .adarI ∨ self == .adarII {
                self = .adar
            }
        }
    }

    // MARK: - CalendarComponent

    // [_Inherit Documentation: SDGCornerstone.CalendarComponent.meanDuration_]
    /// The mean duration.
    public static var meanDuration: CalendarInterval<FloatMax> {
        return lengthOfMoon
    }

    // [_Inherit Documentation: SDGCornerstone.CalendarComponent.minimumDuration_]
    /// The minimum duration.
    public static var minimumDuration: CalendarInterval<FloatMax> {
        return FloatMax(HebrewMonth.minimumNumberOfDays).days
    }

    // [_Inherit Documentation: SDGCornerstone.CalendarComponent.maximumDuration_]
    /// The maximum duration.
    public static var maximumDuration: CalendarInterval<FloatMax> {
        return FloatMax(HebrewMonth.maximumNumberOfDays).days
    }

    // MARK: - Parallel to ConsistentlyOrderedCalendarComponent

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.init(numberAlreadyElapsed:)_]
    /// Creates a component from the number of complete components already elapsed.
    ///
    /// - Precondition: The number must be valid for the particular compenent.
    ///
    /// - Parameters:
    ///     - numberAlreadyElapsed: The number of complete compenents already elapsed.
    public init(numberAlreadyElapsed: Int, leapYear: Bool) {
        self.init(ordinal: numberAlreadyElapsed + 1, leapYear: leapYear)
    }

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.init(numberAlreadyElapsed:)_]
    /// Creates a component from the number of complete components already elapsed.
    ///
    /// - Precondition: The number must be valid for the particular compenent.
    ///
    /// - Parameters:
    ///     - numberAlreadyElapsed: The number of complete compenents already elapsed.
    public init(ordinal: Int, leapYear: Bool) {
        var offset = −1
        if ordinal + offset ≤ HebrewMonth.shevat.rawValue {
            /* Tishrei–Shevat */
            guard let result = HebrewMonth(rawValue: ordinal + offset) else {
                unreachable()
            }
            self = result
        } else {
            if ¬leapYear {
                switch ordinal {
                case 6:
                    self = .adar
                    return
                default:
                    /* Nisan–Elul */
                    offset += 2
                }
            } else {
                switch ordinal {
                case 6:
                    self = .adarI
                    return
                case 7:
                    self = .adarII
                    return
                default:
                    /* Nisan–Elul */
                    offset += 1
                }
            }
            guard let result = HebrewMonth(rawValue: ordinal + offset) else {
                preconditionFailure(UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
                    switch localization {
                    case .englishCanada:
                        return StrictString("Invalid month ordinal: \(ordinal.inDigits())")
                    }
                }))
            }
            self = result
        }
    }

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.numberAlreadyElapsed_]
    /// The number of complete components already elapsed.
    public func numberAlreadyElapsed(leapYear: Bool) -> Int? {
        guard let theOrdinal = ordinal(leapYear: leapYear) else {
            return nil
        }
        return theOrdinal − 1
    }

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.numberAlreadyElapsed_]
    /// The number of complete components already elapsed.
    public func ordinal(leapYear: Bool) -> Int? {
        var offset = 1
        if self ≤ HebrewMonth.shevat {
            /* Tishrei–Shevat */
            return rawValue + offset
        } else {
            if ¬leapYear {
                switch self {
                case .adar:
                    return 6
                case .adarI, .adarII:
                    return nil
                default:
                    /* Nisan–Elul */
                    offset −= 2
                }
            } else {
                switch self {
                case .adarI:
                    return 6
                case .adarII:
                    return 7
                case .adar:
                    return nil
                default:
                    /* Nisan–Elul */
                    offset −= 1
                }
            }
            return rawValue + offset
        }
    }

    // MARK: - RawRepresentable

    // [_Inherit Documentation: SDGCornerstone.RawRepresentable.RawValue_]
    /// The raw value type.
    public typealias RawValue = Int
}

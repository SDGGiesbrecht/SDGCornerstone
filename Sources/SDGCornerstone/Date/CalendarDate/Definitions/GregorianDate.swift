/*
 GregorianDate.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

internal struct GregorianDate : DateDefinition {

    // MARK: - Reference Year

    private static let referenceYear: GregorianYear = 2001
    internal static let referenceMoment = CalendarDate(hebrewYear: 5761, month: .tevet, day: 6, hour: 6, part: 0)

    // MARK: - Root Calendar Functions

    private static func intervalFromReferenceDate(toStartOf targetYear: GregorianYear) -> CalendarInterval<FloatMax> {

        let yearsElapsed = targetYear − GregorianDate.referenceYear

        let cycles = (yearsElapsed.dividedAccordingToEuclid(by:  GregorianYear.yearsPerLeapYearCycle))
        var interval = FloatMax(cycles).gregorianLeapYearCycles
        let yearsAccountedFor = cycles × GregorianYear.yearsPerLeapYearCycle
        let firstRemainingYear = GregorianDate.referenceYear + yearsAccountedFor

        for countingYear in firstRemainingYear ..< targetYear {
            interval += FloatMax(countingYear.numberOfDays).days
        }

        return interval
    }

    private static func intervalFromStartOfYear(toStartOf month: GregorianMonth, leapYear: Bool) -> CalendarInterval<FloatMax> {
        guard let previousMonth = month.predecessor() else {
            // January
            return (0 as FloatMax).days
        }
        return GregorianDate.intervalFromStartOfYear(toStartOf: previousMonth, leapYear: leapYear) + FloatMax(previousMonth.numberOfDays(leapYear: leapYear)).days
    }

    // MARK: - Initialization

    internal init(year: GregorianYear, month: GregorianMonth, day: GregorianDay, hour: GregorianHour, minute: GregorianMinute, second: GregorianSecond) {
        var month = month
        var day = day

        day.correct(forMonth: &month, year: year)

        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.minute = minute
        self.second = second

        var interval = GregorianDate.intervalFromReferenceDate(toStartOf: year)

        interval += GregorianDate.intervalFromStartOfYear(toStartOf: month, leapYear: year.isLeapYear)

        interval += FloatMax(day.numberAlreadyElapsed).days

        interval += FloatMax(hour.numberAlreadyElapsed).hours

        interval += FloatMax(minute.numberAlreadyElapsed).minutes

        interval += second.numberAlreadyElapsed.seconds

        self.intervalSinceReferenceDate = interval
    }

    // MARK: - Properties

    internal let year: GregorianYear
    internal let month: GregorianMonth
    internal let day: GregorianDay
    internal let hour: GregorianHour
    internal let minute: GregorianMinute
    internal let second: GregorianSecond

    // MARK: - DateDefinition

    internal static let uniqueTypeIdentifier = "SDGCornerstone.GregorianDate"

    internal static let referenceDate: CalendarDate = referenceMoment

    internal var intervalSinceReferenceDate: CalendarInterval<FloatMax>

    internal init(intervalSinceReferenceDate: CalendarInterval<FloatMax>) {
        self.intervalSinceReferenceDate = intervalSinceReferenceDate

        let approxYears = Int(intervalSinceReferenceDate ÷ GregorianYear.meanDuration)
        let guessYear = GregorianDate.referenceYear + approxYears
        let year = findLocalMinimum(near: guessYear) { (year: GregorianYear) -> CalendarInterval<FloatMax> in
            let interval = intervalSinceReferenceDate − GregorianDate.intervalFromReferenceDate(toStartOf: year)
            if interval.isNonNegative {
                return interval
            } else {
                return |interval| + GregorianYear.maximumDuration
            }
        }
        var remainder: CalendarInterval<FloatMax> = intervalSinceReferenceDate − GregorianDate.intervalFromReferenceDate(toStartOf: year)

        var approxMonthsElapsed = Int(remainder ÷ GregorianMonth.meanDuration)
        approxMonthsElapsed.decrease(to: GregorianYear.monthsPerYear − 1)
        let guessMonth = GregorianMonth(numberAlreadyElapsed: approxMonthsElapsed)
        let month = findLocalMinimum(near: guessMonth, within: GregorianMonth.first...GregorianMonth.last) { (month: GregorianMonth) -> CalendarInterval<FloatMax> in
            let interval = remainder − GregorianDate.intervalFromStartOfYear(toStartOf: month, leapYear: year.isLeapYear)

            if interval.isNonNegative {
                return interval
            } else {
                return |interval| + GregorianYear.maximumDuration
            }
        }
        remainder −= GregorianDate.intervalFromStartOfYear(toStartOf: month, leapYear: year.isLeapYear)

        func initialize<C : ConsistentlyOrderedCalendarComponent>(_ type: C.Type, numberAlreadyElapsed: C.Vector) -> C {
            // [_Workaround: The compiler cannot find this initializer in the following lines without this function. (Swift 3.1.0)_]
            return C(numberAlreadyElapsed: numberAlreadyElapsed)
        }

        let day = initialize(GregorianDay.self, numberAlreadyElapsed: Int(remainder.inDays.rounded(.down)))
        remainder = remainder.mod((1 as FloatMax).days)

        let hour = initialize(GregorianHour.self, numberAlreadyElapsed: Int(remainder.inHours.rounded(.down)))
        remainder = remainder.mod((1 as FloatMax).hours)

        let minute = initialize(GregorianMinute.self, numberAlreadyElapsed: Int(remainder.inMinutes.rounded(.down)))
        remainder = remainder.mod((1 as FloatMax).minutes)

        let second = GregorianSecond(numberAlreadyElapsed: remainder.inSeconds)

        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.minute = minute
        self.second = second
    }
}

/*
 RationalArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics

extension RationalArithmetic {

    /// Returns the number in digits.
    ///
    /// - Parameters:
    ///     - maximumDecimalPlaces: The maximum number of decimal places.
    ///     - radixCharacter: The character to use to represent the radix.
    ///     - thousandsSeparator: The thousands separator. (Space by default.)
    @inlinable public func inDigits(maximumDecimalPlaces: Int, radixCharacter: UnicodeScalar, thousandsSeparator: UnicodeScalar = " ") -> StrictString {
        let digitSet = egyptianDigits

        let radix = self.radix(for: digitSet)
        let digitMapping = mapping(for: digitSet)

        var result = integralDigits(thousandsSeparator: thousandsSeparator)

        var remainder = (|self|).mod(1)
        if remainder == 0 {
            return result
        } else {
            var decimalDigits: [Self] = []
            var positionValue: Self = 1
            while remainder ≠ 0 ∧ decimalDigits.count ≤ maximumDecimalPlaces {
                positionValue ÷= radix
                decimalDigits.append(remainder.dividedAccordingToEuclid(by: positionValue))
                remainder = remainder.mod(positionValue)
            }

            if decimalDigits.count > maximumDecimalPlaces {
                let next = decimalDigits.removeLast()
                if next.rounded(.toNearestOrAwayFromZero, toMultipleOf: radix) ≠ 0 {
                    for index in decimalDigits.indices.reversed() {
                        var digit = decimalDigits[index]
                        defer { decimalDigits[index] = digit }
                        digit += 1 as Self

                        if digit == radix {
                            digit = 0
                            if index == 0 {
                                result = (self + (1 as Self)).integralDigits(thousandsSeparator: thousandsSeparator)
                            }
                        } else {
                            break
                        }
                    }
                }
            }

            result.append(radixCharacter)
            for index in decimalDigits.indices {
                if index.mod(3) == 0 ∧ index ≠ 0 {
                    result.append(thousandsSeparator)
                }
                guard let digit = digitMapping[decimalDigits[index]] else {
                    unreachable()
                }
                result.append(digit)
            }

            return result
        }
    }
}

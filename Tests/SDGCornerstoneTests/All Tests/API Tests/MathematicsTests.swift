/*
 MathematicsTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
import XCTest

import SDGCornerstone

class MathematicsTests : TestCase {

    func testAddable() {
        func runTests<T : Addable>(addend: T, augend: T, sum: T) where T : Equatable {
            XCTAssertEqual(addend + augend, sum)
        }

        runTests(addend: 1, augend: 2, sum: 3)
        runTests(addend: 1 as WholeNumber, augend: 2, sum: 3)
        runTests(addend: 1 as Integer, augend: 2, sum: 3)
        runTests(addend: 1 as RationalNumber, augend: 2, sum: 3)
        runTests(addend: AddableExample(1), augend: AddableExample(2), sum: AddableExample(3))
        runTests(addend: AddableExampleWhereStrideableAndStrideIsSelf(1), augend: AddableExampleWhereStrideableAndStrideIsSelf(2), sum: AddableExampleWhereStrideableAndStrideIsSelf(3))
    }

    func testAngle() {
        func runTests<N : RealArithmetic>(_ type: N.Type) {
            let _1: N = 1
            var variable: Angle<N> = _1.rad

            XCTAssertEqual((_1 × τ()).rad, _1.rotations)
            XCTAssertEqual((_1 × τ()).rad.inRotations, _1)

            let πValue: N = πLiteral()
            XCTAssert((_1 × 180)°.rawValue ≈ πValue.rad.rawValue)
            XCTAssert((_1 × 6)°.inDegrees ≈ _1 × 6)
            XCTAssertEqual((_1 × 60)′, _1°)
            XCTAssert((_1 × 6)′.inMinutes ≈ _1 × 6)
            XCTAssertEqual((_1 × 60)′′, _1′)
            XCTAssert((_1 × 6)′′.inSeconds ≈ _1 × 6)

            XCTAssert((_1 × 200).gradians.rawValue ≈ πValue.rad.rawValue)
            XCTAssert((_1 × 200).gon.rawValue ≈ πValue.rad.rawValue)
            XCTAssert((_1 × 6).gradians.inGradians ≈ _1 × 6)

            variable = _1.rad
            variable += _1.rad
            XCTAssertEqual(variable, (_1 × 2).rad)

            variable = _1.rad
            variable −= _1.rad
            XCTAssertEqual(variable, Angle<N>.additiveIdentity)

            variable = _1.rad
            variable−=
            XCTAssertEqual(variable, (−_1).rad)

            XCTAssertEqual(|(−_1.rad)|, _1.rad)
            variable = (_1.rad)
            variable.formAbsoluteValue()
            XCTAssertEqual(variable, _1.rad)

            XCTAssertEqual(_1.rad × 2, (_1 × 2).rad)
            XCTAssertEqual(4 × _1.rad, (_1 × 4).rad)
            XCTAssert(_1.rad ÷ (_1 ÷ 2).rad ≈ _1 × 2)
            XCTAssertEqual((_1 × 3).rad.dividedAccordingToEuclid(by: (_1 × 2).rad), 1)
            XCTAssert((_1 × 2).rad.isDivisible(by: _1.rad))
            let _1_5 = gcd((_1 × 1.5).rad, (_1 × 3).rad)
            let _1_5b = gcd((_1 × 3).rad, (_1 × 1.5).rad)
            XCTAssert(_1_5.rawValue ≈ (_1 × 1.5).rad.rawValue)
            XCTAssertEqual(_1_5, _1_5b)
            XCTAssert(lcm((_1 × 1.5).rad, (_1 × 0.5).rad).rawValue ≈ (_1 × 1.5).rad.rawValue)

            XCTAssertEqual(_1.rad.rounded(.down, toMultipleOf: _1.rad × 2), _1.rad × 0)

            XCTAssert(_1.rad.isPositive)
            XCTAssert((−_1).rad.isNegative)
            XCTAssert(Angle<N>.additiveIdentity.isNonPositive)
            XCTAssert(Angle<N>.additiveIdentity.isNonNegative)

            for _ in 1 ..< 100 {
                let random = Angle(randomInRange: N.additiveIdentity.rad ..< _1.rad)
                XCTAssert(random ∈ N.additiveIdentity.rad ..< _1.rad)
                let random2 = Angle(randomInRange: N.additiveIdentity.rad ... _1.rad)
                XCTAssert(random2 ∈ N.additiveIdentity.rad ... _1.rad)
            }
        }
        runTests(Double.self)
        #if os(macOS) || os(Linux)
        runTests(Float80.self)
        #endif
        runTests(Float.self)
        runTests(RealArithmeticExample.self)
    }

    func testArbitraryPrecision() {
        let undecillion: WholeNumber = "1 000 000 000 000 000 000 000 000 000 000 000 000"
        let billion: WholeNumber = 1_000_000_000
        XCTAssertEqual(billion ↑ 4, undecillion)

        XCTAssertEqual(undecillion.dividedAccordingToEuclid(by: (billion ↑ 3)), billion)

        let value: WholeNumber = "66 296 448 936 247 622 620"
        XCTAssertEqual(value.dividedAccordingToEuclid(by: 4), "16 574 112 234 061 905 655")

        let anotherValue: WholeNumber = "18 446 744 073 709 551 616"
        XCTAssertEqual(anotherValue.dividedAccordingToEuclid(by: 1), anotherValue)

        XCTAssertEqual(RationalNumber(undecillion).numerator, Integer(undecillion))
        XCTAssertEqual(RationalNumber(50), 50)
    }

    func testComparable() {
        XCTAssert(ComparableExample(value: −1) < ComparableExample(value: 0))
        XCTAssertFalse(ComparableExample(value: 0) < ComparableExample(value: 0))
        XCTAssertFalse(ComparableExample(value: 1) < ComparableExample(value: 0))

        XCTAssert(ComparableExample(value: −1) ≤ ComparableExample(value: 0))
        XCTAssert(ComparableExample(value: 0) ≤ ComparableExample(value: 0))
        XCTAssertFalse(ComparableExample(value: 1) ≤ ComparableExample(value: 0))

        XCTAssertFalse(ComparableExample(value: −1) ≥ ComparableExample(value: 0))
        XCTAssert(ComparableExample(value: 0) ≥ ComparableExample(value: 0))
        XCTAssert(ComparableExample(value: 1) ≥ ComparableExample(value: 0))

        let list = [1, 4, 1, 5]
        var value = 3

        for entry in list {
            value.decrease(to: entry)
        }
        XCTAssertEqual(value, 1)

        for entry in list {
            value.increase(to: entry)
        }
        XCTAssertEqual(value, 5)

        XCTAssert(1 ≈ (0, 2))
    }

    func testDouble() {
        #if !os(Linux)
            XCTAssert(¬CGFloat(28).debugDescription.isEmpty)
            XCTAssertNotNil(CGFloat("1"))
            XCTAssertNil(CGFloat("a"))
        #endif
    }

    func testFunctionAnalysis() {
        let negativeQuatratic = {
            (input: Int) -> Int in
            return −(input ↑ 2)
        }
        XCTAssertEqual(findLocalMaximum(near: 10, inFunction: negativeQuatratic), 0, "Failed to find local maximum.")

        XCTAssertEqual(findLocalMaximum(near: 10, within: 5...15, inFunction: negativeQuatratic), 5, "Failed to find local maximum.")
        XCTAssertEqual(findLocalMaximum(near: −10, inFunction: negativeQuatratic), 0, "Failed to find local maximum.")

        let quatratic = {
            (input: Int) -> Int in
            return (input ↑ 2)
        }

        XCTAssertEqual(findLocalMinimum(near: 10, inFunction: quatratic), 0, "Failed to find local minimum.")

        XCTAssertEqual(findLocalMinimum(near: 10, within: 5...15, inFunction: quatratic), 5, "Failed to find local minimum.")
    }

    func testIntegralArithmetic() {

        func runTests<N : IntegralArithmetic>(_ type: N.Type) {
            let minusTwo: N = −2
            let minusOne: N = −1
            let one: N = 1
            let two: N = 2
            let three: N = 3

            XCTAssert(minusOne.isNonPositive)
            XCTAssert(minusOne.isNegative)

            XCTAssertEqual(|minusOne|, one)
            /* Swift.AbsoluteValuable */ XCTAssertEqual(abs(minusOne), one)

            XCTAssertEqual(−one, minusOne)
            /* Swift.SignedNumber */ XCTAssertEqual(-one, minusOne)
            /* Swift.SignedNumber */ XCTAssertEqual(one - minusOne, two)

            XCTAssertEqual(three.dividedAccordingToEuclid(by: −two), −two)
            XCTAssertEqual((−three).dividedAccordingToEuclid(by: two), −two)
            XCTAssertEqual(gcd(one × −12, −8), 4)

            for _ in 1 ... 100 {
                let random = N(randomInRange: 3 ... 7)
                XCTAssert(random ∈ 3 ... 7, "\(random) ∉ 3–7")
                let negativeRandom = N(randomInRange: −10 ... −4)
                XCTAssert(negativeRandom ∈ −10 ... −4, "\(negativeRandom) ∉ −10 to −4")
            }

            XCTAssert(minusTwo < minusOne)
        }
        runTests(Int.self)
        runTests(Int64.self)
        runTests(Int32.self)
        runTests(Int16.self)
        runTests(Int8.self)
        runTests(Double.self)
        runTests(Float.self)
        runTests(Integer.self)
        runTests(RationalNumber.self)
        runTests(RealArithmeticExample.self)

        func runStrideableTests<N : IntegralArithmetic>(_ type: N.Type) where N.Stride == N {
            let _1: N = 1
            XCTAssertEqual(_1.advanced(by: 1), _1 + 1)

            XCTAssertEqual(N.additiveIdentity.distance(to: _1), _1)
        }
        runStrideableTests(Int.self)
        runStrideableTests(Double.self)
        runStrideableTests(Float.self)
        runStrideableTests(RealArithmeticExample.self)

        XCTAssertEqual(1.abbreviatedEnglishOrdinal().rawTextApproximation(), "1st")
        XCTAssertEqual(2.verkürzteDeutscheOrdnungszahl(), "2.")
        XCTAssertEqual(3.ordinalFrançaisAbrégé(genre: .masculin, nombre: .singular).rawTextApproximation(), "3e")
        XCTAssertEqual(4.συντομογραφίαΕλληνικούΤακτικούΑριθμού(γένος: .masculine, πτώση: .ονομαστική, αριθμός: .singular).rawTextApproximation(), "4ος")
    }

    func testMeasurement() {
        XCTAssert(0°.hashValue ≤ Int.max)
        XCTAssert(Angle<FloatMax>() == (0 as FloatMax).rad)
    }

    func testNegatable() {
        func runTests<N : Negatable>(_ type: N.Type, value: N, inverse: N) {
            var variable = value
            variable−=
            XCTAssertEqual(variable, inverse)
        }

        runTests(Int.self, value: 1, inverse: −1)
        runTests(Int64.self, value: 1, inverse: −1)
        runTests(Int32.self, value: 1, inverse: −1)
        runTests(Int16.self, value: 1, inverse: −1)
        runTests(Int8.self, value: 1, inverse: −1)
        runTests(Double.self, value: 1, inverse: −1)
        #if os(macOS) || os(Linux)
        runTests(Float80.self, value: 1, inverse: −1)
        #endif
        runTests(Float.self, value: 1, inverse: −1)
        runTests(Integer.self, value: 1, inverse: −1)
        runTests(RationalNumber.self, value: 1, inverse: −1)
        runTests(NegatableExample.self, value: NegatableExample(1), inverse: NegatableExample(−1))
    }

    func testOneDimensionalPoint() {

        var x = 1
        x.decrement()
        XCTAssertEqual(x, 0)

        func runStrideableTests<N : FixedScaleOneDimensionalPoint>(start: N, end: N, vector: N.Vector) {
            XCTAssertEqual(start.advanced(by: vector), end)

            XCTAssertEqual(start.distance(to: end), vector)
        }
        runStrideableTests(start: Int64(0), end: 1, vector: 1)
        runStrideableTests(start: Int32(0), end: 1, vector: 1)
        runStrideableTests(start: Int16(0), end: 1, vector: 1)
        runStrideableTests(start: Int8(0), end: 1, vector: 1)
        runStrideableTests(start: OneDimensionalPointExample(0), end: OneDimensionalPointExample(1), vector: 1)
    }

    func testPointProtocol() {
        func runTests<P : PointProtocol>(start: P, distance: P.Vector, end: P) {
            var variable = start
            variable += distance
            XCTAssertEqual(variable, end)
            variable −= distance
            XCTAssertEqual(variable, start)

            XCTAssertEqual(start + distance, end)
            XCTAssertEqual(end − distance, start)
            XCTAssertEqual(end − start, distance)
        }
        runTests(start: Int64(0), distance: 3, end: 3)
        runTests(start: UInt64(0), distance: 3, end: 3)
        runTests(start: 0 as WholeNumber, distance: 3, end: 3)
        runTests(start: 0 as Integer, distance: 3, end: 3)
        runTests(start: 0 as RationalNumber, distance: 3, end: 3)
        runTests(start: PointProtocolExample(0), distance: 3, end: PointProtocolExample(3))
        runTests(start: PointProtocolExampleWhereVectorIsSelf(0), distance: PointProtocolExampleWhereVectorIsSelf(3), end: PointProtocolExampleWhereVectorIsSelf(3))
    }

    func testRationalArithmetic() {
        func runTests<N : RationalArithmetic>(_ type: N.Type) {
            let one: N = 1
            let oneAndAHalf: N = 1.5
            let two: N = 2
            let three: N = 3

            var variable = three
            variable ÷= two
            XCTAssertEqual(variable, oneAndAHalf)

            XCTAssertEqual(two ↑ −two, one ÷ two ÷ two)

            XCTAssertEqual(oneAndAHalf.rounded(.up), two)
            XCTAssertEqual(oneAndAHalf.rounded(.towardZero), one)
            XCTAssertEqual((−oneAndAHalf).rounded(.towardZero), −one)
            XCTAssertEqual(oneAndAHalf.rounded(.awayFromZero), two)
            XCTAssertEqual((−oneAndAHalf).rounded(.awayFromZero), −two)
            XCTAssertEqual(oneAndAHalf.rounded(.toNearestOrEven), two)
            XCTAssertEqual(oneAndAHalf.rounded(.toNearestOrAwayFromZero), two)
            XCTAssertEqual((one × 0.75).rounded(.toNearestOrEven), one)
            XCTAssertEqual((one × 0.25).rounded(.toNearestOrEven), 0)
            XCTAssertEqual((one × −1.5).rounded(.toNearestOrAwayFromZero), −2)
            XCTAssertEqual((one × 0.5).rounded(.toNearestOrEven), 0)
            variable = 2.5
            variable.round(.toNearestOrAwayFromZero)
            XCTAssertEqual(variable, 3)

            for _ in 1 ..< 100 {let random = N(randomInRange: 0 ..< 1)
                XCTAssert(random ∈ 0 ..< 1)
            }

            XCTAssertEqual(N(binary: "0.000 1"), 1 ÷ 16)
        }
        runTests(Double.self)
        #if os(macOS) || os(Linux)
        runTests(Float80.self)
        #endif
        runTests(Float.self)
        runTests(RationalNumber.self)
        runTests(RationalNumberProtocolExample.self)
        runTests(RealArithmeticExample.self)

        let negativeNineteenOverTwo: RationalNumber = −19 ÷ 2
        let six: RationalNumber = 6
        let fiftyThousandOneOverTenThousand: RationalNumber = 50_001 ÷ 10_000

        XCTAssertEqual(negativeNineteenOverTwo.asSimpleFraction(), "−19⁄2")
        XCTAssertEqual(six.asSimpleFraction(), "6")
        XCTAssertEqual(fiftyThousandOneOverTenThousand.asSimpleFraction(), "(50 001)⁄(10 000)")

        XCTAssertEqual(negativeNineteenOverTwo.asMixedFraction(), "−9 1⁄2")
        XCTAssertEqual(six.asMixedFraction(), "6")
        XCTAssertEqual(fiftyThousandOneOverTenThousand.asMixedFraction(), "5 + 1⁄(10 000)")

        XCTAssertEqual(negativeNineteenOverTwo.asRatio(), "−19 ∶ 2")
        XCTAssertEqual(six.asRatio(), "6 ∶ 1")
        XCTAssertEqual(fiftyThousandOneOverTenThousand.asRatio(), "50 001 ∶ 10 000")

        XCTAssertEqual((1 as RationalNumber).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."), "1")
        XCTAssertEqual((1 as RationalNumber ÷ 10).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."), "0.1")
        XCTAssertEqual((9 as RationalNumber ÷ 10).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."), "0.9")
        XCTAssertEqual((1 as RationalNumber ÷ 100).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."), "0.01")
        XCTAssertEqual((99 as RationalNumber ÷ 100).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."), "0.99")
        XCTAssertEqual((1 as RationalNumber ÷ 1000).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."), "0.001")
        XCTAssertEqual((999 as RationalNumber ÷ 1000).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."), "0.999")
        XCTAssertEqual((1 as RationalNumber ÷ 10_000).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."), "0.000 1")
        XCTAssertEqual((9999 as RationalNumber ÷ 10_000).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."), "0.999 9")
        XCTAssertEqual((1 as RationalNumber ÷ 100_000).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."), "0.000 01")
        XCTAssertEqual((99_999 as RationalNumber ÷ 100_000).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."), "0.999 99")
        XCTAssertEqual((1 as RationalNumber ÷ 1_000_000).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."), "0.000 001")
        XCTAssertEqual((999_999 as RationalNumber ÷ 1_000_000).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."), "0.999 999")
        XCTAssertEqual((1 as RationalNumber ÷ 10_000_000).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."), "0.000 000 1")
        XCTAssertEqual((9_999_999 as RationalNumber ÷ 10_000_000).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."), "0.999 999 9")

        XCTAssertEqual((1 as RationalNumber ÷ 10_000_000).inDigits(maximumDecimalPlaces: 3, radixCharacter: "."), "0.000")
        XCTAssertEqual((999_999 as RationalNumber ÷ 10_000_000).inDigits(maximumDecimalPlaces: 3, radixCharacter: "."), "0.100")
        XCTAssertEqual((9_999_999 as RationalNumber ÷ 10_000_000).inDigits(maximumDecimalPlaces: 3, radixCharacter: "."), "1.000")
    }

    func testRealArithmetic() {
        func runTests<N : RealArithmetic>(_ type: N.Type) {
            let _1: N = 1
            var variable: N = 0

            let πValue: N = πLiteral()
            XCTAssert(N.π ≈ πValue)
            XCTAssertEqual(N.π, π())
            XCTAssertEqual(N.π, N.π.π)

            let τValue: N = τLiteral()
            XCTAssert(N.τ ≈ τValue)
            XCTAssertEqual(N.τ, τ())
            XCTAssertEqual(N.τ, N.τ.τ)

            let eValue: N = eLiteral()
            XCTAssert(N.e ≈ eValue)
            XCTAssertEqual(N.e, e())
            XCTAssertEqual(N.e, N.e.e)

            XCTAssert(√(_1 × 2) ≈ _1 × 1.414_21)
            XCTAssert((_1 × 81).root(ofDegree: 4) ≈ 3)
            XCTAssert((_1 × 27).root(ofDegree: 3) ≈ 3)
            variable = 1
            variable√=
            XCTAssertEqual(variable, 1)

            XCTAssert(log(toBase: 9, of: 3 × _1) ≈ _1 × 0.5)
            XCTAssert(log(_1 × 10) ≈ 1)
            XCTAssert(ln(_1 × 2) ≈ 0.693_14 as N)
            XCTAssert(ln(_1 × 80) ≈ 4.382_02 as N)

            XCTAssert(sin(_1.rad ÷ 2) ≈ 0.479_42 as N)
            XCTAssert(sin(_1°) ≈ 0.017_45 as N)
            XCTAssert(cos(_1.rad ÷ 3) ≈ 0.944_95 as N)
            XCTAssert(cos(_1.rad × −π()) ≈ −1)
            XCTAssert(tan(_1.rad × 5) ≈ −3.380_52 as N)
            XCTAssert(csc(_1.rad) ≈ 1.188_39 as N)
            XCTAssert(sec(_1.rad × 2) ≈ −2.403_00 as N)
            XCTAssert(cot(_1.rad × 3) ≈ −7.015_26 as N)

            XCTAssert(arcsin(_1 ÷ 6).rawValue ≈ (0.167_44 as N).rad.rawValue)
            XCTAssert(arccos(_1 ÷ 7).rawValue ≈ (1.427_44 as N).rad.rawValue)
            XCTAssert(arctan(_1 ÷ 2).rawValue ≈ (0.463_64 as N).rad.rawValue)
            XCTAssert(arctan(_1 × 2).rawValue ≈ (1.107_14 as N).rad.rawValue)
            XCTAssert(arccsc(_1 × 3).rawValue ≈ (0.339_83 as N).rad.rawValue)
            XCTAssert(arcsec(_1 × 4).rawValue ≈ (1.318_11 as N).rad.rawValue)
            XCTAssert(arccot(_1 × 5).rawValue ≈ (0.197_39 as N).rad.rawValue)
            XCTAssert(arccot(_1 × −2).rawValue ≈ (2.677_94 as N).rad.rawValue)
        }
        runTests(Double.self)
        #if os(macOS) || os(Linux)
        runTests(Float80.self)
        #endif
        runTests(Float.self)
        runTests(RealArithmeticExample.self)
    }

    func testSubtractable() {

        func runTests<T : Subtractable>(minuend: T, subtrahend: T, difference: T) where T : Equatable {
            XCTAssertEqual(minuend − subtrahend, difference)
        }
        runTests(minuend: UInt(3), subtrahend: 2, difference: 1)
        runTests(minuend: UInt64(3), subtrahend: 2, difference: 1)
        runTests(minuend: UInt32(3), subtrahend: 2, difference: 1)
        runTests(minuend: UInt16(3), subtrahend: 2, difference: 1)
        runTests(minuend: UInt8(3), subtrahend: 2, difference: 1)
        runTests(minuend: Int(3), subtrahend: 2, difference: 1)
        runTests(minuend: Int64(3), subtrahend: 2, difference: 1)
        runTests(minuend: Int32(3), subtrahend: 2, difference: 1)
        runTests(minuend: Int16(3), subtrahend: 2, difference: 1)
        runTests(minuend: Int8(3), subtrahend: 2, difference: 1)
        runTests(minuend: Double(3), subtrahend: 2, difference: 1)
        runTests(minuend: Float(3), subtrahend: 2, difference: 1)
        runTests(minuend: 3 as WholeNumber, subtrahend: 2, difference: 1)
        runTests(minuend: 3 as Integer, subtrahend: 2, difference: 1)
        runTests(minuend: 3 as RationalNumber, subtrahend: 2, difference: 1)
        runTests(minuend: SubtractableExample(3), subtrahend: SubtractableExample(2), difference: SubtractableExample(1))
        runTests(minuend: SubtractableExampleWherePointProtocolAndVectorIsSelf(3), subtrahend: SubtractableExampleWherePointProtocolAndVectorIsSelf(2), difference: SubtractableExampleWherePointProtocolAndVectorIsSelf(1))
        runTests(minuend: RationalNumberProtocolExample(3), subtrahend: RationalNumberProtocolExample(2), difference: RationalNumberProtocolExample(1))
        runTests(minuend: RealArithmeticExample(3), subtrahend: RealArithmeticExample(2), difference: RealArithmeticExample(1))
    }

    func testTuple() {
        XCTAssertFalse((0, 1) ≤ (0, 0))
        XCTAssert((0, 1) ≤ (0, 1))
        XCTAssert((0, 1) ≤ (1, 1))

        XCTAssertFalse((0, 0, 1) ≤ (0, 0, 0))
        XCTAssert((0, 0, 1) ≤ (0, 0, 1))
        XCTAssert((0, 0, 1) ≤ (0, 1, 1))

        XCTAssertFalse((0, 0, 0, 1) ≤ (0, 0, 0, 0))
        XCTAssert((0, 0, 0, 1) ≤ (0, 0, 0, 1))
        XCTAssert((0, 0, 0, 1) ≤ (0, 0, 1, 1))

        XCTAssertFalse((0, 0, 0, 0, 1) ≤ (0, 0, 0, 0, 0))
        XCTAssert((0, 0, 0, 0, 1) ≤ (0, 0, 0, 0, 1))
        XCTAssert((0, 0, 0, 0, 1) ≤ (0, 0, 0, 1, 1))

        XCTAssertFalse((0, 0, 0, 0, 0, 1) ≤ (0, 0, 0, 0, 0, 0))
        XCTAssert((0, 0, 0, 0, 0, 1) ≤ (0, 0, 0, 0, 0, 1))
        XCTAssert((0, 0, 0, 0, 0, 1) ≤ (0, 0, 0, 0, 1, 1))

        XCTAssert((0, 1) ≥ (0, 0))
        XCTAssert((0, 1) ≥ (0, 1))
        XCTAssertFalse((0, 1) ≥ (1, 1))

        XCTAssert((0, 0, 1) ≥ (0, 0, 0))
        XCTAssert((0, 0, 1) ≥ (0, 0, 1))
        XCTAssertFalse((0, 0, 1) ≥ (0, 1, 1))

        XCTAssert((0, 0, 0, 1) ≥ (0, 0, 0, 0))
        XCTAssert((0, 0, 0, 1) ≥ (0, 0, 0, 1))
        XCTAssertFalse((0, 0, 0, 1) ≥ (0, 0, 1, 1))

        XCTAssert((0, 0, 0, 0, 1) ≥ (0, 0, 0, 0, 0))
        XCTAssert((0, 0, 0, 0, 1) ≥ (0, 0, 0, 0, 1))
        XCTAssertFalse((0, 0, 0, 0, 1) ≥ (0, 0, 0, 1, 1))

        XCTAssert((0, 0, 0, 0, 0, 1) ≥ (0, 0, 0, 0, 0, 0))
        XCTAssert((0, 0, 0, 0, 0, 1) ≥ (0, 0, 0, 0, 0, 1))
        XCTAssertFalse((0, 0, 0, 0, 0, 1) ≥ (0, 0, 0, 0, 1, 1))
    }

    func testVectorProtocol() {
        XCTAssertEqual(3 × VectorProtocolExample(2), VectorProtocolExample(6))
        XCTAssertEqual(VectorProtocolExample(6) ÷ 3, VectorProtocolExample(2))
    }

    func testWholeArithmetic() {
        func runTests<N : WholeArithmetic>(_ type: N.Type) {
            let zero: N = 0
            let one: N = 1
            let two: N = 2
            let three: N = 3

            var variable = zero

            XCTAssertEqual(zero, N.additiveIdentity)

            XCTAssertEqual(one + one, two)

            variable = zero
            variable += one
            XCTAssertEqual(variable, one)

            variable = two
            variable −= two
            XCTAssertEqual(variable, zero)

            XCTAssertEqual(two − one, one)

            XCTAssertEqual(|two|, 2)

            XCTAssertEqual(two × one, two)
            variable = one
            variable ×= two
            XCTAssertEqual(one × two, two)

            variable = three
            variable.formRemainder(mod: 2)
            XCTAssertEqual(variable, 1)

            XCTAssertEqual(lcm(two, 3), 6)

            XCTAssertEqual(two ↑ 3, 8)

            XCTAssert(one.isPositive)
            XCTAssert(one.isNonNegative)

            XCTAssert(zero.isNonNegative)
            XCTAssert(zero.isNonPositive)

            XCTAssert(two.isNatural)
            XCTAssert(one.isIntegral)
            XCTAssert(two.isEven)
            XCTAssert(one.isOdd)

            XCTAssertEqual(one.rounded(.down), one)

            for _ in 1 ... 100 {
                XCTAssert(N(randomInRange: 17 ... 28) ∈ 17 ... 28)
            }

            let uInt8: UInt8 = 94
            XCTAssertEqual(N(uInt8), 94)

            // [_Workaround: This should be “as N”, but that causes a segmentation fault. (Swift 3.1.0)_]
            XCTAssertEqual("1" as WholeNumber, 1)

            XCTAssertEqual(N(hexadecimal: "7F"), 127)
            XCTAssertEqual(N(octal: "10"), 8)
            XCTAssertEqual(N(binary: "10000"), 16)

            if N.self ≠ Int8.self ∧ N.self ≠ UInt8.self {
                XCTAssertEqual(N("10 000"), 10_000)
            }
        }
        runTests(UInt.self)
        runTests(UInt64.self)
        runTests(UInt32.self)
        runTests(UInt16.self)
        runTests(UInt8.self)
        runTests(Int.self)
        runTests(Int64.self)
        runTests(Int32.self)
        runTests(Int16.self)
        runTests(Int8.self)
        runTests(Double.self)
        runTests(Float.self)
        runTests(WholeNumber.self)
        runTests(Integer.self)
        runTests(RationalNumber.self)

        XCTAssertEqual((0 as UInt).inDigits(), "0")
        XCTAssertEqual((1 as UInt).inDigits(), "1")
        XCTAssertEqual((9 as UInt).inDigits(), "9")
        XCTAssertEqual((10 as UInt).inDigits(), "10")
        XCTAssertEqual((999 as UInt).inDigits(), "999")
        XCTAssertEqual((1000 as UInt).inDigits(), "1000")
        XCTAssertEqual((9999 as UInt).inDigits(), "9999")
        XCTAssertEqual((10_000 as UInt).inDigits(), "10 000")
        XCTAssertEqual((999_999 as UInt).inDigits(), "999 999")
        XCTAssertEqual((1_000_000 as UInt).inDigits(), "1 000 000")
        XCTAssertEqual((999_999_999 as UInt).inDigits(), "999 999 999")
        XCTAssertEqual((1_000_000_000 as UInt).inDigits(), "1 000 000 000")

        XCTAssertEqual(1111.inRomanNumerals(), "MCXI")
        XCTAssertEqual(2222.inRomanNumerals(), "MMCCXXII")
        XCTAssertEqual(3333.inRomanNumerals(), "MMMCCCXXXIII")
        XCTAssertEqual(444.inRomanNumerals(), "CDXLIV")
        XCTAssertEqual(555.inRomanNumerals(), "DLV")
        XCTAssertEqual(666.inRomanNumerals(), "DCLXVI")
        XCTAssertEqual(777.inRomanNumerals(), "DCCLXXVII")
        XCTAssertEqual(888.inRomanNumerals(), "DCCCLXXXVIII")
        XCTAssertEqual(999.inRomanNumerals(), "CMXCIX")
        XCTAssertEqual(1000.inRomanNumerals(lowercase: true), "m")
        XCTAssertEqual((1 as Int8).inRomanNumerals(), "I")
        XCTAssertEqual((1 as UInt8).inRomanNumerals(), "I")

        XCTAssertEqual(1111.σεΕλληνικούςΑριθμούς(), "͵ΑΡΙΑʹ")
        XCTAssertEqual(2222.σεΕλληνικούςΑριθμούς(), "͵ΒΣΚΒʹ")
        XCTAssertEqual(3333.σεΕλληνικούςΑριθμούς(), "͵ΓΤΛΓʹ")
        XCTAssertEqual(4444.σεΕλληνικούςΑριθμούς(), "͵ΔΥΜΔʹ")
        XCTAssertEqual(5555.σεΕλληνικούςΑριθμούς(), "͵ΕΦΝΕʹ")
        XCTAssertEqual(6666.σεΕλληνικούςΑριθμούς(), "͵ϚΧΞϚʹ")
        XCTAssertEqual(7777.σεΕλληνικούςΑριθμούς(), "͵ΖΨΟΖʹ")
        XCTAssertEqual(8888.σεΕλληνικούςΑριθμούς(), "͵ΗΩΠΗʹ")
        XCTAssertEqual(9999.σεΕλληνικούςΑριθμούς(), "͵ΘϠϞΘʹ")
        XCTAssertEqual(2222.σεΕλληνικούςΑριθμούς(μικράΓράμματα: true, κεραία: false), "βσκβ")
        XCTAssertEqual((1 as Int8).σεΕλληνικούςΑριθμούς(), "Αʹ")
        XCTAssertEqual((1 as UInt8).σεΕλληνικούςΑριθμούς(), "Αʹ")
        XCTAssertEqual(10.σεΕλληνικούςΑριθμούς(), "Ιʹ")

        XCTAssertEqual(1111.בספרות־עבריות(), "א׳קי״א")
        XCTAssertEqual(2222.בספרות־עבריות(), "ב׳רכ״ב")
        XCTAssertEqual(3333.בספרות־עבריות(), "ג׳של״ג")
        XCTAssertEqual(4444.בספרות־עבריות(), "ד׳תמ״ד")
        XCTAssertEqual(5555.בספרות־עבריות(), "ה׳תקנ״ה")
        XCTAssertEqual(6666.בספרות־עבריות(), "ו׳תרס״ו")
        XCTAssertEqual(7777.בספרות־עבריות(), "ז׳תשע״ז")
        XCTAssertEqual(8888.בספרות־עבריות(), "ח׳תתפ״ח")
        XCTAssertEqual(9999.בספרות־עבריות(), "ט׳תתקצ״ט")
        XCTAssertEqual(2222.בספרות־עבריות(גרשיים: false), "ברכב")
        XCTAssertEqual(15.בספרות־עבריות(), "ט״ו")
        XCTAssertEqual(16.בספרות־עבריות(), "ט״ז")
        XCTAssertEqual(10.בספרות־עבריות(), "י׳")
        XCTAssertEqual((1 as Int8).בספרות־עבריות(), "א׳")
        XCTAssertEqual((1 as UInt8).בספרות־עבריות(), "א׳")

        XCTAssertEqual((1 as WholeNumber).abbreviatedEnglishOrdinal().rawTextApproximation(), "1st")
        XCTAssertEqual((2 as WholeNumber).verkürzteDeutscheOrdnungszahl(), "2.")
        XCTAssertEqual((3 as WholeNumber).ordinalFrançaisAbrégé(genre: .masculin, nombre: .singular).rawTextApproximation(), "3e")
        XCTAssertEqual((4 as WholeNumber).συντομογραφίαΕλληνικούΤακτικούΑριθμού(γένος: .masculine, πτώση: .ονομαστική, αριθμός: .singular).rawTextApproximation(), "4ος")

        XCTAssertEqual(1.abbreviatedEnglishOrdinal().rawTextApproximation(), "1st")
        XCTAssertEqual(2.abbreviatedEnglishOrdinal().rawTextApproximation(), "2nd")
        XCTAssertEqual(3.abbreviatedEnglishOrdinal().rawTextApproximation(), "3rd")
        XCTAssertEqual(4.abbreviatedEnglishOrdinal().rawTextApproximation(), "4th")
        XCTAssertEqual(11.abbreviatedEnglishOrdinal().rawTextApproximation(), "11th")
        XCTAssertEqual(12.abbreviatedEnglishOrdinal().rawTextApproximation(), "12th")
        XCTAssertEqual(13.abbreviatedEnglishOrdinal().rawTextApproximation(), "13th")
        XCTAssertEqual(14.abbreviatedEnglishOrdinal().rawTextApproximation(), "14th")
        XCTAssertEqual(21.abbreviatedEnglishOrdinal().rawTextApproximation(), "21st")
        XCTAssertEqual(22.abbreviatedEnglishOrdinal().rawTextApproximation(), "22nd")
        XCTAssertEqual(23.abbreviatedEnglishOrdinal().rawTextApproximation(), "23rd")
        XCTAssertEqual(24.abbreviatedEnglishOrdinal().rawTextApproximation(), "24th")

        XCTAssertEqual(1.ordinalFrançaisAbrégé(genre: .masculin, nombre: .singular).rawTextApproximation(), "1er")
        XCTAssertEqual(1.ordinalFrançaisAbrégé(genre: .féminin, nombre: .singular).rawTextApproximation(), "1re")
        XCTAssertEqual(1.ordinalFrançaisAbrégé(genre: .masculin, nombre: .plural).rawTextApproximation(), "1ers")
        XCTAssertEqual(1.ordinalFrançaisAbrégé(genre: .féminin, nombre: .plural).rawTextApproximation(), "1res")
        XCTAssertEqual(2.ordinalFrançaisAbrégé(genre: .masculin, nombre: .singular).rawTextApproximation(), "2e")
        XCTAssertEqual(2.ordinalFrançaisAbrégé(genre: .féminin, nombre: .singular).rawTextApproximation(), "2e")
        XCTAssertEqual(2.ordinalFrançaisAbrégé(genre: .masculin, nombre: .plural).rawTextApproximation(), "2es")
        XCTAssertEqual(2.ordinalFrançaisAbrégé(genre: .féminin, nombre: .plural).rawTextApproximation(), "2es")

        XCTAssertEqual(1.συντομογραφίαΕλληνικούΤακτικούΑριθμού(γένος: .masculine, πτώση: .ονομαστική, αριθμός: .singular).rawTextApproximation(), "1ος")
        XCTAssertEqual(1.συντομογραφίαΕλληνικούΤακτικούΑριθμού(γένος: .masculine, πτώση: .αιτιατική, αριθμός: .singular).rawTextApproximation(), "1ο")
        XCTAssertEqual(1.συντομογραφίαΕλληνικούΤακτικούΑριθμού(γένος: .masculine, πτώση: .γενική, αριθμός: .singular).rawTextApproximation(), "1ου")
        XCTAssertEqual(1.συντομογραφίαΕλληνικούΤακτικούΑριθμού(γένος: .masculine, πτώση: .κλητική, αριθμός: .singular).rawTextApproximation(), "1ε")
        XCTAssertEqual(1.συντομογραφίαΕλληνικούΤακτικούΑριθμού(γένος: .feminine, πτώση: .ονομαστική, αριθμός: .singular).rawTextApproximation(), "1η")
        XCTAssertEqual(1.συντομογραφίαΕλληνικούΤακτικούΑριθμού(γένος: .feminine, πτώση: .γενική, αριθμός: .singular).rawTextApproximation(), "1ης")
        XCTAssertEqual(1.συντομογραφίαΕλληνικούΤακτικούΑριθμού(γένος: .neuter, πτώση: .ονομαστική, αριθμός: .singular).rawTextApproximation(), "1ο")
        XCTAssertEqual(1.συντομογραφίαΕλληνικούΤακτικούΑριθμού(γένος: .neuter, πτώση: .γενική, αριθμός: .singular).rawTextApproximation(), "1ου")
        XCTAssertEqual(1.συντομογραφίαΕλληνικούΤακτικούΑριθμού(γένος: .masculine, πτώση: .ονομαστική, αριθμός: .plural).rawTextApproximation(), "1οι")
        XCTAssertEqual(1.συντομογραφίαΕλληνικούΤακτικούΑριθμού(γένος: .masculine, πτώση: .αιτιατική, αριθμός: .plural).rawTextApproximation(), "1ους")
        XCTAssertEqual(1.συντομογραφίαΕλληνικούΤακτικούΑριθμού(γένος: .masculine, πτώση: .γενική, αριθμός: .plural).rawTextApproximation(), "1ων")
        XCTAssertEqual(1.συντομογραφίαΕλληνικούΤακτικούΑριθμού(γένος: .feminine, πτώση: .ονομαστική, αριθμός: .plural).rawTextApproximation(), "1ες")
        XCTAssertEqual(1.συντομογραφίαΕλληνικούΤακτικούΑριθμού(γένος: .feminine, πτώση: .γενική, αριθμός: .plural).rawTextApproximation(), "1ων")
        XCTAssertEqual(1.συντομογραφίαΕλληνικούΤακτικούΑριθμού(γένος: .neuter, πτώση: .ονομαστική, αριθμός: .plural).rawTextApproximation(), "1α")
        XCTAssertEqual(1.συντομογραφίαΕλληνικούΤακτικούΑριθμού(γένος: .neuter, πτώση: .γενική, αριθμός: .plural).rawTextApproximation(), "1ων")
    }

    static var allTests: [(String, (MathematicsTests) -> () throws -> Void)] {
        return [
            ("testAddable", testAddable),
            ("testAngle", testAngle),
            ("testArbitraryPrecision", testArbitraryPrecision),
            ("testComparable", testComparable),
            ("testDouble", testDouble),
            ("testFunctionAnalysis", testFunctionAnalysis),
            ("testIntegralArithmetic", testIntegralArithmetic),
            ("testMeasurement", testMeasurement),
            ("testNegatable", testNegatable),
            ("testOneDimensionalPoint", testOneDimensionalPoint),
            ("testPointProtocol", testPointProtocol),
            ("testRationalArithmetic", testRationalArithmetic),
            ("testRealArithmetic", testRealArithmetic),
            ("testSubtractable", testSubtractable),
            ("testTuple", testTuple),
            ("testVectorProtocol", testVectorProtocol),
            ("testWholeArithmetic", testWholeArithmetic)
        ]
    }
}

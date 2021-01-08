/*
 APITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics

import XCTest

import SDGTesting
import SDGMathematicsTestUtilities
import SDGXCTestUtilities

class APITests: TestCase {

  struct AddableStrideableExample: Addable, SignedNumeric, Strideable {
    var value: Int
    init(_ value: Int) {
      self.value = value
    }
    static func == (
      precedingValue: AddableStrideableExample,
      followingValue: AddableStrideableExample
    ) -> Bool {
      return precedingValue.value == followingValue.value
    }
    static func < (
      precedingValue: AddableStrideableExample,
      followingValue: AddableStrideableExample
    ) -> Bool {
      return precedingValue.value < followingValue.value
    }
    static func += (
      precedingValue: inout AddableStrideableExample,
      followingValue: AddableStrideableExample
    ) {
      precedingValue.value += followingValue.value
    }
    static func -= (  // @exempt(from: unicode)
      precedingValue: inout AddableStrideableExample,
      followingValue: AddableStrideableExample
    ) {
      precedingValue.value −= followingValue.value
    }
    static func - (  // @exempt(from: unicode)
      precedingValue: AddableStrideableExample,
      followingValue: AddableStrideableExample
    ) -> AddableStrideableExample {
      return AddableStrideableExample(precedingValue.value − followingValue.value)
    }
    static func *= (  // @exempt(from: unicode)
      precedingValue: inout AddableStrideableExample,
      followingValue: AddableStrideableExample
    ) {
      precedingValue.value ×= followingValue.value
    }
    static func * (  // @exempt(from: unicode)
      precedingValue: AddableStrideableExample,
      followingValue: AddableStrideableExample
    ) -> AddableStrideableExample {
      return AddableStrideableExample(precedingValue.value × followingValue.value)
    }
    var magnitude: UInt {
      return value.magnitude
    }
    init(integerLiteral value: Int) {
      self.init(value)
    }
    init?<T>(exactly source: T) where T: BinaryInteger {
      guard let int = Int(exactly: source) else {
        return nil
      }
      self.init(int)
    }
    func distance(to other: AddableStrideableExample) -> AddableStrideableExample {
      return AddableStrideableExample(value.distance(to: other.value))
    }
    func advanced(by n: AddableStrideableExample) -> AddableStrideableExample {
      return AddableStrideableExample(value.advanced(by: n.value))
    }
  }
  func testAddable() {
    testAddableConformance(
      augend: AddableStrideableExample(5),
      addend: AddableStrideableExample(25),
      sum: AddableStrideableExample(30)
    )
  }

  func testAngle() {
    #if !os(Windows)  // #workaround(Swift 5.3.1, Segmentation fault.)
      testMeasurementConformance(of: Angle<Double>.self)

      let _1: Double = 1

      XCTAssertEqual((_1 × τ()).rad, _1.rotations)
      XCTAssertEqual((_1 × τ()).rad.inRotations, _1)

      let πValue: Double = π()
      XCTAssert((_1 × 180)°.rawValue ≈ πValue.rad.rawValue)
      XCTAssert((_1 × 6)°.inDegrees ≈ _1 × 6)
      XCTAssertEqual((_1 × 60)′, _1°)
      XCTAssert((_1 × 6)′.inMinutes ≈ _1 × 6)
      XCTAssertEqual((_1 × 60)′′, _1′)
      XCTAssert((_1 × 6)′′.inSeconds ≈ _1 × 6)

      XCTAssert((_1 × 200).gradians.rawValue ≈ πValue.rad.rawValue)
      XCTAssert((_1 × 200).gon.rawValue ≈ πValue.rad.rawValue)
      XCTAssert((_1 × 6).gradians.inGradians ≈ _1 × 6)
    #endif
  }

  struct BitFieldExample: BitField, Equatable, ExpressibleByIntegerLiteral {
    var field: UInt8
    init(integerLiteral: UInt8) {
      field = integerLiteral
    }
    mutating func formBitwiseNot() {
      field.formBitwiseNot()
    }
    mutating func formBitwiseAnd(with other: BitFieldExample) {
      field.formBitwiseAnd(with: other.field)
    }
    mutating func formBitwiseOr(with other: BitFieldExample) {
      field.formBitwiseOr(with: other.field)
    }
    mutating func formBitwiseExclusiveOr(with other: BitFieldExample) {
      field.formBitwiseExclusiveOr(with: other.field)
    }
  }
  func testBitField() {
    testBitFieldConformance(
      start: 0b0101_0110 as BitFieldExample,
      not: 0b1010_1001,
      other: 0b1101_0010,
      and: 0b0101_0010,
      or: 0b1101_0110,
      exclusiveOr: 0b1000_0100
    )
  }

  func testComparable() {
    test(operator: (≤, "≤"), on: (0, 1), returns: true)
    test(operator: (≤, "≤"), on: (0, 0), returns: true)
    test(operator: (≤, "≤"), on: (0, −1), returns: false)

    test(operator: (≥, "≥"), on: (0, 1), returns: false)
    test(operator: (≥, "≥"), on: (0, 0), returns: true)
    test(operator: (≥, "≥"), on: (0, −1), returns: true)

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

    XCTAssert(compare(0, 1, by: { _ in 0 }, { _ in 0 }, { _ in 0 }, { $0 }))
    XCTAssertFalse(compare(0, 0, by: { $0 }, { $0 }, { $0 }, { $0 }))
  }

  func testFloat() {
    #if !os(Windows)  // #workaround(Swift 5.3.1, Segmentation fault.)
      testRealArithmeticConformance(of: Double.self)
      testRealArithmeticConformance(of: FloatMax.self)
      testRealArithmeticConformance(of: CGFloat.self)
      #if !(os(Windows) || os(WASI) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
        testRealArithmeticConformance(of: Float80.self)
      #endif
      testRealArithmeticConformance(of: Float.self)
      #if !PLATFORM_LACKS_SWIFT_FLOAT_16
        if #available(tvOS 14, iOS 14, *) {
          testRealArithmeticConformance(of: Float16.self)
        }
      #endif

      XCTAssert(¬CGFloat(28).debugDescription.isEmpty)
      XCTAssertNotNil(CGFloat("1"))
      XCTAssertNotNil(CGFloat(String("1")))
      XCTAssertNil(CGFloat(String("a")))

      test(method: (Double.rounded, "rounded"), of: 5.1, returns: 5)
    #endif
  }

  func testFunctionAnalysis() {
    #if !os(Windows)  // #workaround(Swift 5.3.1, Segmentation fault.)
      let negativeQuatratic = { (input: Int) -> Int in
        return −(input ↑ 2)
      }
      XCTAssertEqual(
        findLocalMaximum(near: 10, inFunction: negativeQuatratic),
        0,
        "Failed to find local maximum."
      )

      XCTAssertEqual(
        findLocalMaximum(near: 10, within: 5...15, inFunction: negativeQuatratic),
        5,
        "Failed to find local maximum."
      )
      XCTAssertEqual(
        findLocalMaximum(near: −10, inFunction: negativeQuatratic),
        0,
        "Failed to find local maximum."
      )

      let quatratic = { (input: Int) -> Int in
        return (input ↑ 2)
      }

      XCTAssertEqual(
        findLocalMinimum(near: 10, inFunction: quatratic),
        0,
        "Failed to find local minimum."
      )

      XCTAssertEqual(
        findLocalMinimum(near: 10, within: 5...15, inFunction: quatratic),
        5,
        "Failed to find local minimum."
      )
    #endif
  }

  func testInt() {
    #if !os(Windows)  // #workaround(Swift 5.3.1, Segmentation fault.)
      testIntegralArithmeticConformance(of: Int.self)
      testIntegralArithmeticConformance(of: IntMax.self)
      testIntegralArithmeticConformance(of: Int64.self)
      testIntegralArithmeticConformance(of: Int32.self)
      testIntegralArithmeticConformance(of: Int16.self)
      testIntegralArithmeticConformance(of: Int8.self)
    #endif
  }

  struct NegatableSignedNumeric: Negatable, SignedNumeric {
    typealias IntegerLiteralType = Int
    typealias Magnitude = UInt
    var value: Int
    init(_ value: Int) {
      self.value = value
    }
    static func += (
      precedingValue: inout NegatableSignedNumeric,
      followingValue: NegatableSignedNumeric
    ) {
      precedingValue.value += followingValue.value
    }
    static func −= (
      precedingValue: inout NegatableSignedNumeric,
      followingValue: NegatableSignedNumeric
    ) {
      precedingValue.value −= followingValue.value
    }
    init?<T>(exactly source: T) where T: BinaryInteger {
      guard let int = Int(exactly: source) else { return nil }
      self = NegatableSignedNumeric(int)
    }
    init(integerLiteral value: Int) {
      self = NegatableSignedNumeric(value)
    }
    var magnitude: UInt {
      return value.magnitude
    }
    static func * (  // @exempt(from: unicode)
      lhs: NegatableSignedNumeric,
      rhs: NegatableSignedNumeric
    ) -> NegatableSignedNumeric {
      return NegatableSignedNumeric(lhs.value × rhs.value)
    }
    static func *= (  // @exempt(from: unicode)
      lhs: inout NegatableSignedNumeric,
      rhs: NegatableSignedNumeric
    ) {
      lhs.value ×= rhs.value
    }
  }
  func testNegatable() {
    #if !os(Windows)  // #workaround(Swift 5.3.1, Segmentation fault.)
      testNegatableConformance(
        minuend: NegatableSignedNumeric(5),
        subtrahend: NegatableSignedNumeric(3),
        difference: NegatableSignedNumeric(2)
      )
    #endif
  }

  func testOneDimensionalPoint() {
    #if !os(Windows)  // #workaround(Swift 5.3.1, Segmentation fault.)
      var x = 1
      x.decrement()
      XCTAssertEqual(0, x)
    #endif
  }

  enum OrderedEnumerationExample: Int, OrderedEnumeration {
    typealias RawValue = Int
    case a
    case b
    case c
  }
  func testOrderedEnumeration() {
    XCTAssertEqual(OrderedEnumerationExample.a.cyclicSuccessor(), OrderedEnumerationExample.b)
    XCTAssertEqual(OrderedEnumerationExample.c.cyclicPredecessor(), OrderedEnumerationExample.b)
    XCTAssertEqual(OrderedEnumerationExample.a.cyclicPredecessor(), OrderedEnumerationExample.c)
    XCTAssertEqual(OrderedEnumerationExample.c.cyclicSuccessor(), OrderedEnumerationExample.a)
    XCTAssert(OrderedEnumerationExample.a < OrderedEnumerationExample.b)

    var enumeration = OrderedEnumerationExample.b
    enumeration.increment()
    XCTAssertEqual(enumeration, .c)
    enumeration.decrement()
    XCTAssertEqual(enumeration, .b)
    XCTAssertEqual(enumeration.successor(), .c)
    enumeration = .c
    enumeration.incrementCyclically()
    XCTAssertEqual(enumeration, .a)
    enumeration.decrementCyclically()
    XCTAssertEqual(enumeration, .c)
  }

  struct PointProtocolVectorSelfExample: Negatable, PointProtocol {
    typealias Vector = PointProtocolVectorSelfExample
    var value: Int
    init(_ value: Int) {
      self.value = value
    }
    static var zero = PointProtocolVectorSelfExample(0)
    static func += (
      precedingValue: inout PointProtocolVectorSelfExample,
      followingValue: PointProtocolVectorSelfExample
    ) {
      precedingValue.value += followingValue.value
    }
    static func − (
      precedingValue: PointProtocolVectorSelfExample,
      followingValue: PointProtocolVectorSelfExample
    ) -> PointProtocolVectorSelfExample {
      return PointProtocolVectorSelfExample(precedingValue.value − followingValue.value)
    }
  }
  struct PointProtocolStrideableExample: PointProtocol, Strideable {
    var value: Int
    init(_ value: Int) {
      self.value = value
    }
    func distance(to other: PointProtocolStrideableExample) -> Int32 {
      return Int32(value.distance(to: other.value))
    }
    func advanced(by n: Int32) -> PointProtocolStrideableExample {
      return PointProtocolStrideableExample(value.advanced(by: Int(n)))
    }
    typealias Vector = Int64
    static func += (precedingValue: inout PointProtocolStrideableExample, followingValue: Int64) {
      precedingValue.value += Int(followingValue)
    }
    static func − (
      precedingValue: PointProtocolStrideableExample,
      followingValue: PointProtocolStrideableExample
    ) -> Int64 {
      return Int64(precedingValue.value − followingValue.value)
    }
  }
  struct PointProtocolStrideableVectorStrideExample: PointProtocol, Strideable {
    var value: Int
    init(_ value: Int) {
      self.value = value
    }
    func distance(to other: PointProtocolStrideableVectorStrideExample) -> Int {
      return value.distance(to: other.value)
    }
    func advanced(by n: Int) -> PointProtocolStrideableVectorStrideExample {
      return PointProtocolStrideableVectorStrideExample(value.advanced(by: n))
    }
    typealias Vector = Int
    static func += (
      precedingValue: inout PointProtocolStrideableVectorStrideExample,
      followingValue: Int
    ) {
      precedingValue.value += followingValue
    }
    static func − (
      precedingValue: PointProtocolStrideableVectorStrideExample,
      followingValue: PointProtocolStrideableVectorStrideExample
    ) -> Int {
      return precedingValue.value − followingValue.value
    }
  }
  func testPointProtocol() {
    #if !os(Windows)  // #workaround(Swift 5.3.1, Segmentation fault.)
      testPointProtocolConformance(
        departure: PointProtocolVectorSelfExample(8),
        vector: PointProtocolVectorSelfExample(1),
        destination: PointProtocolVectorSelfExample(9)
      )
      testPointProtocolConformance(
        departure: PointProtocolStrideableExample(0),
        vector: 9,
        destination: PointProtocolStrideableExample(9)
      )
      testPointProtocolConformance(
        departure: PointProtocolStrideableVectorStrideExample(7),
        vector: 2,
        destination: PointProtocolStrideableVectorStrideExample(9)
      )
    #endif
  }

  struct RealArithmeticExample: RealArithmetic {
    var value: Double
    init(_ value: Double) {
      self.value = value
    }
    static func == (precedingValue: RealArithmeticExample, followingValue: RealArithmeticExample)
      -> Bool
    {
      return precedingValue.value == followingValue.value
    }
    static func < (precedingValue: RealArithmeticExample, followingValue: RealArithmeticExample)
      -> Bool
    {
      return precedingValue.value < followingValue.value
    }
    typealias Vector = RealArithmeticExample
    init(_ uInt: SDGMathematics.UIntMax) {
      value = Double(uInt)
    }
    init?<T>(exactly source: T) where T: BinaryInteger {
      guard let double = Double(exactly: source) else {
        return nil
      }
      self.init(double)
    }
    static func += (
      precedingValue: inout RealArithmeticExample,
      followingValue: RealArithmeticExample
    ) {
      precedingValue.value += followingValue.value
    }
    static func −= (
      precedingValue: inout RealArithmeticExample,
      followingValue: RealArithmeticExample
    ) {
      precedingValue.value −= followingValue.value
    }
    static func ×= (
      precedingValue: inout RealArithmeticExample,
      followingValue: RealArithmeticExample
    ) {
      precedingValue.value ×= followingValue.value
    }
    mutating func divideAccordingToEuclid(by divisor: RealArithmeticExample) {
      value.divideAccordingToEuclid(by: divisor.value)
    }
    static func ↑= (
      precedingValue: inout RealArithmeticExample,
      followingValue: RealArithmeticExample
    ) {
      precedingValue.value ↑= followingValue.value
    }
    static func random<R>(
      in range: ClosedRange<APITests.RealArithmeticExample>,
      using generator: inout R
    ) -> APITests.RealArithmeticExample where R: RandomNumberGenerator {
      return RealArithmeticExample(
        Double.random(in: range.lowerBound.value...range.upperBound.value, using: &generator)
      )
    }
    init(_ int: SDGMathematics.IntMax) {
      value = Double(int)
    }
    #if !(os(Windows) || os(WASI) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
      init(_ floatingPoint: FloatMax) {
        value = Double(floatingPoint)
      }
    #endif
    static func ÷= (
      precedingValue: inout RealArithmeticExample,
      followingValue: RealArithmeticExample
    ) {
      precedingValue.value ÷= followingValue.value
    }
    static var π = RealArithmeticExample(Double.π)
    static var e = RealArithmeticExample(Double.e)
    mutating func formLogarithm(toBase base: RealArithmeticExample) {
      value.formLogarithm(toBase: base.value)
    }
    static func sin(_ angle: Angle<RealArithmeticExample>) -> RealArithmeticExample {
      return RealArithmeticExample(SDGMathematics.sin(angle.inRadians.value.radians))
    }
    static func arctan(_ tangent: RealArithmeticExample) -> Angle<RealArithmeticExample> {
      return RealArithmeticExample(SDGMathematics.arctan(tangent.value).inRadians).radians
    }
    var floatingPointApproximation: FloatMax {
      return FloatMax(value)
    }
  }
  func testRealArithmetic() {
    #if !os(Windows)  // #workaround(Swift 5.3.1, Segmentation fault.)
      XCTAssertEqual(0.π, Double.π)
      XCTAssertEqual(0.τ, Double.τ)
      XCTAssertEqual(e(), Double.e)
      XCTAssert((√RealArithmeticExample(4)).value ≈ RealArithmeticExample(2).value)
      test(function: (log, "log"), on: 100 as RealArithmeticExample, returns: 2)
      XCTAssert(ln(RealArithmeticExample(714)).value ≈ 6.570_88)
      XCTAssert(cos(RealArithmeticExample(401).radians).value ≈ 0.432_21)
      XCTAssert(tan((5 as RealArithmeticExample).rad).value ≈ −3.380_52)
      XCTAssert(arcsin((1 ÷ 6 as RealArithmeticExample)).inRadians.value ≈ 0.167_44)
      XCTAssert(arccos((1 ÷ 7 as RealArithmeticExample)).inRadians.value ≈ 1.427_44)
    #endif
  }

  func testSequence() {
    #if !os(Windows)  // #workaround(Swift 5.3.1, Segmentation fault.)
      XCTAssertEqual(∑[1, 2, 3, 4], 10)
      XCTAssertEqual(∏[1, 2, 3, 4], 24)

      XCTAssertEqual(([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10] as [Double]).mean(), 5)
      XCTAssertEqual(([0, 0, 0, 0, 50] as [Double]).mean(), 10)
      XCTAssertNil(([] as [Double]).mean())

      XCTAssertEqual(([0] as [Double]).median(), 0)
      XCTAssertEqual(([−1, 0, 1] as [Double]).median(), 0)
      XCTAssertEqual(([−1, 1, 0] as [Double]).median(), 0)
      XCTAssertEqual(([1, 2, 3, 4] as [Double]).median(), 2.5)
      XCTAssertEqual(([1, 4, 3, 2] as [Double]).median(), 2.5)
      XCTAssertNil(([] as [Double]).median())

      XCTAssertEqual("ABCABA".statisticalModes(), ["A"])
      XCTAssertEqual("ABCABAB".statisticalModes().sorted(), ["A", "B"])
      XCTAssertEqual("".statisticalModes(), [])
    #endif
  }

  struct SubtractableNumericExample: Numeric, Subtractable {
    var value: Int
    init(_ value: Int) {
      self.value = value
    }
    static func < (
      precedingValue: SubtractableNumericExample,
      followingValue: SubtractableNumericExample
    ) -> Bool {
      return precedingValue.value < followingValue.value
    }
    static func += (
      precedingValue: inout SubtractableNumericExample,
      followingValue: SubtractableNumericExample
    ) {
      precedingValue.value += followingValue.value
    }
    static func −= (
      precedingValue: inout SubtractableNumericExample,
      followingValue: SubtractableNumericExample
    ) {
      precedingValue.value −= followingValue.value
    }
    static func *= (  // @exempt(from: unicode)
      precedingValue: inout SubtractableNumericExample,
      followingValue: SubtractableNumericExample
    ) {
      precedingValue.value ×= followingValue.value
    }
    static func * (  // @exempt(from: unicode)
      precedingValue: SubtractableNumericExample,
      followingValue: SubtractableNumericExample
    ) -> SubtractableNumericExample {
      return SubtractableNumericExample(precedingValue.value × followingValue.value)
    }
    var magnitude: UInt {
      return value.magnitude
    }
    init(integerLiteral value: Int) {
      self.init(value)
    }
    init?<T>(exactly source: T) where T: BinaryInteger {
      guard let int = Int(exactly: source) else {
        return nil
      }
      self.init(int)
    }
  }
  struct SubtractableStrideableExample: SignedNumeric, Strideable, Subtractable {
    var value: Int
    init(_ value: Int) {
      self.value = value
    }
    static func == (
      precedingValue: SubtractableStrideableExample,
      followingValue: SubtractableStrideableExample
    ) -> Bool {
      return precedingValue.value == followingValue.value
    }
    static func < (
      precedingValue: SubtractableStrideableExample,
      followingValue: SubtractableStrideableExample
    ) -> Bool {
      return precedingValue.value < followingValue.value
    }
    static func += (
      precedingValue: inout SubtractableStrideableExample,
      followingValue: SubtractableStrideableExample
    ) {
      precedingValue.value += followingValue.value
    }
    static func −= (
      precedingValue: inout SubtractableStrideableExample,
      followingValue: SubtractableStrideableExample
    ) {
      precedingValue.value −= followingValue.value
    }
    typealias Stride = SubtractableStrideableExample
    func distance(to other: SubtractableStrideableExample) -> SubtractableStrideableExample {
      return SubtractableStrideableExample(value.distance(to: other.value))
    }
    func advanced(by n: SubtractableStrideableExample) -> SubtractableStrideableExample {
      return SubtractableStrideableExample(value.advanced(by: n.value))
    }
    static func *= (  // @exempt(from: unicode)
      precedingValue: inout SubtractableStrideableExample,
      followingValue: SubtractableStrideableExample
    ) {
      precedingValue.value ×= followingValue.value
    }
    static func * (  // @exempt(from: unicode)
      precedingValue: SubtractableStrideableExample,
      followingValue: SubtractableStrideableExample
    ) -> SubtractableStrideableExample {
      return SubtractableStrideableExample(precedingValue.value × followingValue.value)
    }
    var magnitude: UInt {
      return value.magnitude
    }
    init(integerLiteral value: Int) {
      self.init(value)
    }
    init?<T>(exactly source: T) where T: BinaryInteger {
      guard let int = Int(exactly: source) else {
        return nil
      }
      self.init(int)
    }
  }
  func testSubtractable() {
    #if !os(Windows)  // #workaround(Swift 5.3.1, Segmentation fault.)
      XCTAssertEqual(
        SubtractableNumericExample(6) - SubtractableNumericExample(5),  // @exempt(from: unicode)
        SubtractableNumericExample(1)
      )
      var x = SubtractableNumericExample(7)
      x -= SubtractableNumericExample(8)  // @exempt(from: unicode)
      XCTAssertEqual(x, SubtractableNumericExample(−1))

      XCTAssertEqual(
        SubtractableStrideableExample(6)
          - SubtractableStrideableExample(5),  // @exempt(from: unicode)
        SubtractableStrideableExample(1)
      )
      var y = SubtractableStrideableExample(7)
      y -= SubtractableStrideableExample(8)  // @exempt(from: unicode)
      XCTAssertEqual(y, SubtractableStrideableExample(−1))
    #endif
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

  func testUInt() {
    #if !os(Windows)  // #workaround(Swift 5.3.1, Segmentation fault.)
      testWholeArithmeticConformance(of: UInt.self, includingNegatives: false)
      testWholeArithmeticConformance(of: UIntMax.self, includingNegatives: false)
      testWholeArithmeticConformance(of: UInt64.self, includingNegatives: false)
      testWholeArithmeticConformance(of: UInt32.self, includingNegatives: false)
      testWholeArithmeticConformance(of: UInt16.self, includingNegatives: false)
      testWholeArithmeticConformance(of: UInt8.self, includingNegatives: false)

      testBitFieldConformance(
        start: 0b0101_0110 as UInt8,
        not: 0b1010_1001,
        other: 0b1101_0010,
        and: 0b0101_0010,
        or: 0b1101_0110,
        exclusiveOr: 0b1000_0100
      )
    #endif
  }

  struct VectorProtocolExample: RationalVector {
    var value: Double
    init(_ value: Double) {
      self.value = value
    }
    static func += (
      precedingValue: inout VectorProtocolExample,
      followingValue: VectorProtocolExample
    ) {
      precedingValue.value += followingValue.value
    }
    static var zero: VectorProtocolExample {
      return VectorProtocolExample(0)
    }
    typealias Scalar = Double
    static func ×= (precedingValue: inout VectorProtocolExample, followingValue: Scalar) {
      precedingValue.value ×= followingValue
    }
    static func ÷= (precedingValue: inout VectorProtocolExample, followingValue: Scalar) {
      precedingValue.value ÷= followingValue
    }
    static func −= (
      precedingValue: inout VectorProtocolExample,
      followingValue: VectorProtocolExample
    ) {
      precedingValue.value −= followingValue.value
    }
  }
  func testVectorProtocol() {
    #if !os(Windows)  // #workaround(Swift 5.3.1, Segmentation fault.)
      testRationalVectorConformance(
        augend: VectorProtocolExample(1),
        addend: VectorProtocolExample(2),
        sum: VectorProtocolExample(3),
        multiplicand: VectorProtocolExample(4),
        multiplier: 5,
        product: VectorProtocolExample(20)
      )
      XCTAssertEqual(5 × VectorProtocolExample(4), VectorProtocolExample(20))
    #endif
  }
}

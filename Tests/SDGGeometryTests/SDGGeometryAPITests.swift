/*
 SDGGeometryAPITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGMathematics
import SDGGeometry

import XCTest

import SDGXCTestUtilities
import SDGMathematicsTestUtilities
import SDGGeometryTestUtilities

class SDGGeometryAPITests: TestCase {

  func testAngle() {
    #if !os(Windows)  // #workaround(Swift 5.1.3, SegFault)
      _ = 0°.playgroundDescription
      _ = (−90)°.playgroundDescription
    #endif
  }

  func testBézierPath() {
    #if canImport(AppKit) || canImport(UIKit)
      _ = BézierPath().playgroundDescription
    #endif
  }

  func testPoint() {
    testTwoDimensionalPointProtocolConformance(TwoDimensionalPoint<Double>.self)
    #if canImport(CoreGraphics)
      testTwoDimensionalPointProtocolConformance(CGPoint.self)
    #endif

    typealias Point = TwoDimensionalPoint<Double>
    XCTAssertEqual(Point(1, 1) − Point.Vector(Δx: 1, Δy: 1), Point(0, 0))
    XCTAssertEqual(Point(0, 0) + Point.Vector(Δx: 1, Δy: 1), Point(1, 1))
    XCTAssertEqual(Point(1, 1) − Point(0, 0), Point.Vector(Δx: 1, Δy: 1))

    let point = Point(1.21, 1.21).rounded(.down, toMultipleOf: 0.2)
    XCTAssert(point.x ≈ 1.2)
    XCTAssert(point.y ≈ 1.2)
    let anotherPoint = point.rounded(.down)
    XCTAssert(anotherPoint.x ≈ 1)
    XCTAssert(anotherPoint.y ≈ 1)
  }

  func testVector() {
    testTwoDimensionalVectorProtocolConformance(TwoDimensionalVector<Double>.self)
    #if canImport(CoreGraphics)
      testTwoDimensionalVectorProtocolConformance(CGVector.self)
    #endif

    typealias Vector = TwoDimensionalVector<Double>

    XCTAssertEqual(Vector(Δx: 1, Δy: 1) − Vector(Δx: 1, Δy: 1), Vector(Δx: 0, Δy: 0))
    XCTAssertEqual(Vector(Δx: 0, Δy: 0) + Vector(Δx: 1, Δy: 1), Vector(Δx: 1, Δy: 1))

    XCTAssert(Vector(Δx: 3, Δy: 4).length ≈ 5)
    XCTAssert(Vector(Δx: −3, Δy: 4).length ≈ 5)
    XCTAssert(Vector(Δx: 3, Δy: −4).length ≈ 5)
    XCTAssert(Vector(Δx: −3, Δy: −4).length ≈ 5)

    XCTAssert(Vector(Δx: 1, Δy: 0).direction.inDegrees ≈ 0)
    XCTAssert(Vector(Δx: 0, Δy: 1).direction.inDegrees ≈ 90)
    XCTAssert(Vector(Δx: −1, Δy: 0).direction.inDegrees ≈ 180)
    XCTAssert(Vector(Δx: 0, Δy: −1).direction.inDegrees ≈ 270)

    XCTAssert(Vector(Δx: 1, Δy: 1).direction.inDegrees ≈ 45)
    XCTAssert(Vector(Δx: −1, Δy: 1).direction.inDegrees ≈ 135)
    XCTAssert(Vector(Δx: −1, Δy: −1).direction.inDegrees ≈ 225)
    XCTAssert(Vector(Δx: 1, Δy: −1).direction.inDegrees ≈ 315)

    XCTAssert(Vector(direction: 0°, length: 1).Δx ≈ 1)
    XCTAssert(Vector(direction: 0°, length: 1).Δy ≈ 0)
    XCTAssert(Vector(direction: 90°, length: 1).Δx ≈ 0)
    XCTAssert(Vector(direction: 90°, length: 1).Δy ≈ 1)
    XCTAssert(Vector(direction: 180°, length: 1).Δx ≈ −1)
    XCTAssert(Vector(direction: 180°, length: 1).Δy ≈ 0)
    XCTAssert(Vector(direction: 270°, length: 1).Δx ≈ 0)
    XCTAssert(Vector(direction: 270°, length: 1).Δy ≈ −1)

    var hasher = Hasher()
    Vector(Δx: 1, Δy: 1).hash(into: &hasher)

    XCTAssertEqual(Vector(Δx: 0, Δy: 0), Vector.zero)

    var vector = Vector(Δx: 1, Δy: 0)
    vector.direction = 90°
    XCTAssert(vector.Δx ≈ 0)
    XCTAssert(vector.Δy ≈ 1)

    vector.length = 2
    XCTAssert(vector.Δx ≈ 0)
    XCTAssert(vector.Δy ≈ 2)

    vector ×= 2
    XCTAssert(vector.Δx ≈ 0)
    XCTAssert(vector.Δy ≈ 4)

    vector ÷= 4
    XCTAssert(vector.Δx ≈ 0)
    XCTAssert(vector.Δy ≈ 1)
  }
}

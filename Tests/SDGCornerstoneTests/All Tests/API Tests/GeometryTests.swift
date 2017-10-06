/*
 GeometryTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest
import Foundation

#if !os(Linux)
    import CoreGraphics
#endif

import SDGCornerstone

class GeometryTests : TestCase {

    func testPoint() {/* [_Workaround: See CGPoint.swift. (Swift 4.0)_]
        #if !os(Linux)
            XCTAssertEqual(CGPoint(x: 1, y: 1) − CGVector(Δx : 1, Δy : 1), CGPoint(x: 0, y: 0))
            XCTAssertEqual(CGPoint(x: 0, y: 0) + CGVector(Δx : 1, Δy : 1), CGPoint(x: 1, y: 1))
            XCTAssertEqual(CGPoint(x: 1, y: 1) − CGPoint(x: 0, y: 0), CGVector(Δx : 1, Δy : 1))

            let point = CGPoint(x: 1.21, y: 1.21).rounded(.down, toMultipleOf: 0.2)
            XCTAssert(point.x ≈ 1.2 as CGFloat)
            XCTAssert(point.y ≈ 1.2 as CGFloat)
            let anotherPoint = point.rounded(.down)
            XCTAssert(anotherPoint.x ≈ 1)
            XCTAssert(anotherPoint.y ≈ 1)
        #endif*/
    }

    func testVector() {
        #if !os(Linux)
            XCTAssertEqual(CGVector(Δx : 1, Δy : 1) − CGVector(Δx : 1, Δy : 1), CGVector(Δx : 0, Δy : 0))
            XCTAssertEqual(CGVector(Δx : 0, Δy : 0) + CGVector(Δx : 1, Δy : 1), CGVector(Δx : 1, Δy : 1))

            XCTAssert(CGVector(Δx : 3, Δy : 4).length ≈ 5)
            XCTAssert(CGVector(Δx : −3, Δy : 4).length ≈ 5)
            XCTAssert(CGVector(Δx : 3, Δy : −4).length ≈ 5)
            XCTAssert(CGVector(Δx : −3, Δy : −4).length ≈ 5)

            XCTAssert(CGVector(Δx : 1, Δy : 0).direction.inDegrees ≈ 0)
            XCTAssert(CGVector(Δx : 0, Δy : 1).direction.inDegrees ≈ 90)
            XCTAssert(CGVector(Δx : −1, Δy : 0).direction.inDegrees ≈ 180)
            XCTAssert(CGVector(Δx : 0, Δy : −1).direction.inDegrees ≈ 270)

            XCTAssert(CGVector(Δx : 1, Δy : 1).direction.inDegrees ≈ 45)
            XCTAssert(CGVector(Δx : −1, Δy : 1).direction.inDegrees ≈ 135)
            XCTAssert(CGVector(Δx : −1, Δy : −1).direction.inDegrees ≈ 225)
            XCTAssert(CGVector(Δx : 1, Δy : −1).direction.inDegrees ≈ 315)

            XCTAssert(CGVector(direction: 0°, length: 1).Δx ≈ 1)
            XCTAssert(CGVector(direction: 0°, length: 1).Δy ≈ 0)
            XCTAssert(CGVector(direction: 90°, length: 1).Δx ≈ 0)
            XCTAssert(CGVector(direction: 90°, length: 1).Δy ≈ 1)
            XCTAssert(CGVector(direction: 180°, length: 1).Δx ≈ −1)
            XCTAssert(CGVector(direction: 180°, length: 1).Δy ≈ 0)
            XCTAssert(CGVector(direction: 270°, length: 1).Δx ≈ 0)
            XCTAssert(CGVector(direction: 270°, length: 1).Δy ≈ −1)

            XCTAssert(CGVector(Δx : 1, Δy : 1).hashValue ≤ Int.max)

            XCTAssertEqual(TwoDimensionalVectorExample(Δx : 0, Δy : 0), TwoDimensionalVectorExample.additiveIdentity)

            var vector = CGVector(Δx : 1, Δy : 0)
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
        #endif
    }

    static var allTests: [(String, (GeometryTests) -> () throws -> Void)] {
        return [
            ("testPoint", testPoint),
            ("testVector", testVector)
        ]
    }
}

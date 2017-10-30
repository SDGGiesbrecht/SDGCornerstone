/*
 DateExamples.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
import XCTest

import SDGCornerstone

// [_Define Example: DateDefinition_]
extension CalendarDate {

    // This initializer creates a date using the number of days into the current millennium.
    public init(daysIntoMillennium: FloatMax) {
        self.init(definition: DaysIntoMillennium(daysIntoMillennium))
    }

    // This property is available to dates with any kind of definition.
    public var daysIntoMillennium: FloatMax {
        return converted(to: DaysIntoMillennium.self).daysIntoMillennium
    }
}

private struct DaysIntoMillennium : DateDefinition {

    // The reference date is January 1, 2001 at 00:00
    fileprivate static let referenceDate = CalendarDate(gregorian: .january, 1, 2001, at: 0, 0, 0)

    fileprivate static let identifier: StrictString = "MyModule.DaysIntoMillenium"
    fileprivate let daysIntoMillennium: FloatMax
    fileprivate let intervalSinceReferenceDate: CalendarInterval<FloatMax>

    fileprivate init(_ daysIntoMillennium: FloatMax) {
        self.daysIntoMillennium = daysIntoMillennium
        intervalSinceReferenceDate = daysIntoMillennium.days
    }

    fileprivate init(intervalSinceReferenceDate: CalendarInterval<FloatMax>) {
        self.intervalSinceReferenceDate = intervalSinceReferenceDate
        daysIntoMillennium = intervalSinceReferenceDate.inDays
    }

    fileprivate func encode(to encoder: Encoder) throws {
        // Only the definition (i.e. daysIntoMillennium) needs to be encoded.
        // Derived information (i.e. intervalSinceRefrenceDate) can be recomputed.
        try encode(to: encoder, via: daysIntoMillennium)
    }
    fileprivate init(from decoder: Decoder) throws {
        try self.init(from: decoder, via: FloatMax.self, convert: { DaysIntoMillennium($0) }, debugErrorDescription: { _ in
            unreachable()
        })
    }
}
// [_End_]

class DateExampleTests : TestCase {

    func testCustomDate() {
        DateExampleTests.testCustomDate()
    }
    static func testCustomDate() {
        XCTAssertEqual(CalendarDate(gregorian: .january, 12, 2001, at: 0, 0).daysIntoMillennium, 11)

        // Unregistered definitions.
        let unregistered = CalendarDate(daysIntoMillennium: 12345)
        let unregisteredCoded = "[[\u{22}MyModule.DaysIntoMillenium\u{22},\u{22}[12345.0]\u{22},[3507559200.0,259200]]]"
        XCTAssertRecodes(unregistered, equivalentFormats: [unregisteredCoded])
        do {
            let recoded = try JSONDecoder().decode(CalendarDate.self, from: try JSONEncoder().encode(unregistered))
            XCTAssertRecodes(recoded, equivalentFormats: [unregisteredCoded])
        } catch let error {
            XCTFail(error.localizedDescription)
        }
        // Once registered...
        CalendarDate.register(DaysIntoMillennium.self)
        XCTAssertRecodes(unregistered, equivalentFormats: [unregisteredCoded])
    }

    static var allTests: [(String, (DateExampleTests) -> () throws -> Void)] {
        return [
            ("testCustomDate", testCustomDate)
        ]
    }
}

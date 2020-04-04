/*
 APITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow

import XCTest

import SDGTesting
import SDGXCTestUtilities

class APITests: TestCase {

  func testCaching() {

    var callCount = 0
    func compute() -> Bool {
      callCount += 1
      return true
    }
    func compute(_ parameter: Bool) -> Bool {
      callCount += 1
      return parameter
    }

    var cache: Bool?
    var parameterizedCache: [Bool: Bool] = [:]

    XCTAssertEqual(cached(in: &cache, compute), true, "Cache contained incorrect value.")
    XCTAssertEqual(callCount, 1, "Cache value not computed.")
    XCTAssertEqual(cached(in: &cache, compute), true, "Cache contained incorrect value.")
    XCTAssertEqual(callCount, 1, "Cache value recomputed unnecessarily.")

    callCount = 0

    XCTAssertEqual(
      cached(in: &parameterizedCache[true], { compute(true) }),
      true,
      "Cache contained incorrect value."
    )
    XCTAssertEqual(
      cached(in: &parameterizedCache[false], { compute(false) }),
      false,
      "Cache contained incorrect value."
    )
    XCTAssertEqual(callCount, 2, "Cache values mixed up.")
    XCTAssertEqual(
      cached(in: &parameterizedCache[true], { compute(true) }),
      true,
      "Cache contained incorrect value."
    )
    XCTAssertEqual(
      cached(in: &parameterizedCache[false], { compute(false) }),
      false,
      "Cache contained incorrect value."
    )
    XCTAssertEqual(callCount, 2, "Cache value recomputed unnecessarily.")
  }

  struct CodableExample: Codable, Equatable {
    var value: Bool
    init(_ value: Bool) {
      self.value = value
    }
    func encode(to coder: Encoder) throws {
      return try encode(to: coder, via: value)
    }
    init(from decoder: Decoder) throws {
      try self.init(from: decoder, via: Bool.self) { CodableExample($0) }
    }
  }
  func testCodable() {
    let original = CodableExample(true)
    do {
      let encoded = try JSONEncoder().encode([original])
      let decoded = try JSONDecoder().decode([CodableExample].self, from: encoded)
      XCTAssertEqual(original, decoded.first, "Encoded and decoded: \(decoded) ≠ \(original)")
    } catch {
      XCTFail("\(error)")
    }
  }

  struct NonmutatingVariantExample: Equatable {
    var value: Set<UnicodeScalar> = []
    mutating func modify(a: Bool, b: Bool, c: Bool) {
      if a { value.insert("a") }
      if b { value.insert("b") }
      if c { value.insert("c") }
    }
    func modifying(a: Bool, b: Bool, c: Bool) -> NonmutatingVariantExample {
      return nonmutatingVariant(of: { $0.modify(a: $1, b: $2, c: $3) }, on: self, with: (a, b, c))
    }
  }
  func testNonmutatingVariants() {
    let sorted = nonmutatingVariant(of: { $0.sort() }, on: [2, 3, 1])
    XCTAssert(sorted == [1, 2, 3], "Nonmutating variant returned an unexpected value: \(sorted)")
    let appended = nonmutatingVariant(of: { $0.append($1) }, on: [1, 2], with: 3)
    XCTAssert(
      appended == [1, 2, 3],
      "Nonmutating variant returned an unexpected value: \(appended)"
    )
    let start = "BCD"
    let inserted = nonmutatingVariant(
      of: { $0.insert($1, at: $2) },
      on: start,
      with: ("A", start.startIndex)
    )
    XCTAssert(inserted == "ABCD", "Nonmutating variant returned an unexpected value: \(inserted)")
    let modified = NonmutatingVariantExample().modifying(a: true, b: false, c: true)
    XCTAssert(
      modified.value == ["a", "c"],
      "Nonmutating variant returned an unexpected value: \(modified)"
    )
    let added = nonmutatingVariant(of: +=, on: [1, 2], with: [3])
    XCTAssert(added == [1, 2, 3], "Nonmutating variant returned an unexpected value: \(added)")
    let incremented = nonmutatingVariant(of: { (x: inout Int) in x += 1 }, on: 1)
    XCTAssert(incremented == 2, "Nonmutating variant returned an unexpected value: \(incremented)")
  }

  func testPerformanceTest() {
    #if !os(Windows)  // #workaround(workspace 0.32.0, SegFault)
      limit("Performance", to: 1) {}
    #endif
  }

  class SharedValueObserverExample: SharedValueObserver {
    init(_ value: Shared<Int>, normalizing: Bool) {
      self.value = value
      self.normalizing = normalizing
      value.register(observer: self)
    }
    var value: Shared<Int>
    var lastReportedValue: Int?
    var normalizing: Bool
    func valueChanged(for identifier: String) {
      lastReportedValue = value.value
      if normalizing {
        if value.value == 0 {} else {
          value.value = 0
        }
      }
    }
  }
  func testShared() {
    var shared: Shared<Int>? = Shared(1)
    weak var weakShared = shared
    XCTAssertEqual(shared?.value, 1)

    var nilObserver: SharedValueObserverExample? = SharedValueObserverExample(
      shared!,
      normalizing: false
    )
    _ = nilObserver
    nilObserver = nil

    var observer1: SharedValueObserverExample? = SharedValueObserverExample(
      shared!,
      normalizing: false
    )
    weak var weakObserver1 = observer1
    XCTAssertEqual(observer1?.lastReportedValue, 1)

    shared?.value = 2
    XCTAssertEqual(shared?.value, 2)
    XCTAssertEqual(observer1?.lastReportedValue, 2)

    var observer2: SharedValueObserverExample? = SharedValueObserverExample(
      shared!,
      normalizing: true
    )
    weak var weakObserver2 = observer2
    XCTAssertEqual(shared?.value, 0)
    XCTAssertEqual(observer1?.lastReportedValue, 0)
    XCTAssertEqual(observer2?.lastReportedValue, 0)

    shared?.value = 3
    XCTAssertEqual(shared?.value, 0)
    XCTAssertEqual(observer1?.lastReportedValue, 0)
    XCTAssertEqual(observer2?.lastReportedValue, 0)

    observer2 = nil
    XCTAssertEqual(shared?.value, 0)
    XCTAssertEqual(observer1?.lastReportedValue, 0)
    XCTAssertNil(weakObserver2)

    shared?.value = 4
    XCTAssertEqual(shared?.value, 4)
    XCTAssertEqual(observer1?.lastReportedValue, 4)

    observer1 = nil
    XCTAssertEqual(shared?.value, 4)
    XCTAssertNil(weakObserver1)

    shared?.value = 5
    XCTAssertEqual(shared?.value, 5)

    shared = nil
    XCTAssertNil(weakShared)

    shared = Shared(6)
    XCTAssertEqual(shared?.value, 6)

    observer1 = SharedValueObserverExample(shared!, normalizing: false)
    XCTAssertEqual(shared?.value, 6)
    XCTAssertEqual(observer1?.lastReportedValue, 6)

    shared?.cancel(observer: observer1!)
    XCTAssertEqual(shared?.value, 6)
    XCTAssertEqual(observer1?.lastReportedValue, 6)

    shared?.value = 7
    XCTAssertEqual(shared?.value, 7)
    XCTAssertEqual(observer1?.lastReportedValue, 6)

    _ = String(reflecting: Shared(1))
  }

  func testSharedProperty() {
    class Class {
      init() {}
      init(property: String) {
        self.property = property
      }
      @SharedProperty var property: String = "default"
      @SharedProperty("direct") var otherProperty: String
    }
    var instance = Class()
    XCTAssertEqual(instance.property, "default")
    instance = Class(property: "initialized")
    XCTAssertEqual(instance.property, "initialized")
    XCTAssertEqual(instance.otherProperty, "direct")
    class Observer: SharedValueObserver {
      func valueChanged(for identifier: String) {}
    }
    instance.$property.cancel(observer: Observer())
    instance.$property = Shared("replaced")
    XCTAssertEqual(instance.property, "replaced")
    _ = SharedProperty(wrappedValue: "").wrappedInstance
  }

  func testWeak() {
    var pointee: NSObject? = NSObject()

    let reference = Weak(pointee)
    XCTAssertNotNil(reference.pointee)

    pointee = nil
    XCTAssertNil(reference.pointee)

    _ = reference.wrappedInstance

    class Class {}
    struct Structure {
      init() {}
      @Weak var property: Class?
    }
    var instance = Structure()
    instance.property = Class()
    XCTAssertNil(instance.property)
    instance.$property = Weak(Class())
    XCTAssertNil(instance.$property.pointee)
  }
}

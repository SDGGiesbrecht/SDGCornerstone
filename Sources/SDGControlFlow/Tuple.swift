/*
 Tuple.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// MARK: - Initialization

extension Tuple2 {
  /// Creates a wrapped tuple.
  ///
  /// - Parameters:
  ///   - tuple: The tuple.
  @inlinable public init(_ tuple: (A, B)) {
    self.tuple = tuple
  }
}
extension Tuple3 {
  /// Creates a wrapped tuple.
  ///
  /// - Parameters:
  ///   - tuple: The tuple.
  @inlinable public init(_ tuple: (A, B, C)) {
    self.tuple = tuple
  }
}
extension Tuple4 {
  /// Creates a wrapped tuple.
  ///
  /// - Parameters:
  ///   - tuple: The tuple.
  @inlinable public init(_ tuple: (A, B, C, D)) {
    self.tuple = tuple
  }
}
extension Tuple5 {
  /// Creates a wrapped tuple.
  ///
  /// - Parameters:
  ///   - tuple: The tuple.
  @inlinable public init(_ tuple: (A, B, C, D, E)) {
    self.tuple = tuple
  }
}
extension Tuple6 {
  /// Creates a wrapped tuple.
  ///
  /// - Parameters:
  ///   - tuple: The tuple.
  @inlinable public init(_ tuple: (A, B, C, D, E, F)) {
    self.tuple = tuple
  }
}

// MARK: - Properties

/// A tuple wrapped in a named type to enable protocol conformances.
public struct Tuple2<A, B> {
  /// The underlying tuple.
  public var tuple: (A, B)
}
/// A tuple wrapped in a named type to enable protocol conformances.
public struct Tuple3<A, B, C> {
  /// The underlying tuple.
  public var tuple: (A, B, C)
}
/// A tuple wrapped in a named type to enable protocol conformances.
public struct Tuple4<A, B, C, D> {
  /// The underlying tuple.
  public var tuple: (A, B, C, D)
}
/// A tuple wrapped in a named type to enable protocol conformances.
public struct Tuple5<A, B, C, D, E> {
  /// The underlying tuple.
  public var tuple: (A, B, C, D, E)
}
/// A tuple wrapped in a named type to enable protocol conformances.
public struct Tuple6<A, B, C, D, E, F> {
  /// The underlying tuple.
  public var tuple: (A, B, C, D, E, F)
}

// MARK: - Comparable

extension Tuple2: Comparable where A: Comparable, B: Comparable {
  public static func < (precedingValue: Tuple2, followingValue: Tuple2) -> Bool {
    return precedingValue.tuple < followingValue.tuple
  }
}
extension Tuple3: Comparable where A: Comparable, B: Comparable, C: Comparable {
  public static func < (precedingValue: Tuple3, followingValue: Tuple3) -> Bool {
    return precedingValue.tuple < followingValue.tuple
  }
}
extension Tuple4: Comparable where A: Comparable, B: Comparable, C: Comparable, D: Comparable {
  public static func < (precedingValue: Tuple4, followingValue: Tuple4) -> Bool {
    return precedingValue.tuple < followingValue.tuple
  }
}
extension Tuple5: Comparable
where A: Comparable, B: Comparable, C: Comparable, D: Comparable, E: Comparable {
  public static func < (precedingValue: Tuple5, followingValue: Tuple5) -> Bool {
    return precedingValue.tuple < followingValue.tuple
  }
}
extension Tuple6: Comparable
where A: Comparable, B: Comparable, C: Comparable, D: Comparable, E: Comparable, F: Comparable {
  public static func < (precedingValue: Tuple6, followingValue: Tuple6) -> Bool {
    return precedingValue.tuple < followingValue.tuple
  }
}

// MARK: - Decodable

extension Tuple2: Decodable where A: Decodable, B: Decodable {
  public init(from decoder: Decoder) throws {
    var container = try decoder.unkeyedContainer()
    let a = try container.decode(A.self)
    let b = try container.decode(B.self)
    self.init((a, b))
  }
}
extension Tuple3: Decodable where A: Decodable, B: Decodable, C: Decodable {
  public init(from decoder: Decoder) throws {
    var container = try decoder.unkeyedContainer()
    let a = try container.decode(A.self)
    let b = try container.decode(B.self)
    let c = try container.decode(C.self)
    self.init((a, b, c))
  }
}
extension Tuple4: Decodable where A: Decodable, B: Decodable, C: Decodable, D: Decodable {
  public init(from decoder: Decoder) throws {
    var container = try decoder.unkeyedContainer()
    let a = try container.decode(A.self)
    let b = try container.decode(B.self)
    let c = try container.decode(C.self)
    let d = try container.decode(D.self)
    self.init((a, b, c, d))
  }
}
extension Tuple5: Decodable
where A: Decodable, B: Decodable, C: Decodable, D: Decodable, E: Decodable {
  public init(from decoder: Decoder) throws {
    var container = try decoder.unkeyedContainer()
    let a = try container.decode(A.self)
    let b = try container.decode(B.self)
    let c = try container.decode(C.self)
    let d = try container.decode(D.self)
    let e = try container.decode(E.self)
    self.init((a, b, c, d, e))
  }
}
extension Tuple6: Decodable
where A: Decodable, B: Decodable, C: Decodable, D: Decodable, E: Decodable, F: Decodable {
  public init(from decoder: Decoder) throws {
    var container = try decoder.unkeyedContainer()
    let a = try container.decode(A.self)
    let b = try container.decode(B.self)
    let c = try container.decode(C.self)
    let d = try container.decode(D.self)
    let e = try container.decode(E.self)
    let f = try container.decode(F.self)
    self.init((a, b, c, d, e, f))
  }
}

// MARK: - Encodable

extension Tuple2: Encodable where A: Encodable, B: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.unkeyedContainer()
    try container.encode(tuple.0)
    try container.encode(tuple.1)
  }
}
extension Tuple3: Encodable where A: Encodable, B: Encodable, C: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.unkeyedContainer()
    try container.encode(tuple.0)
    try container.encode(tuple.1)
    try container.encode(tuple.2)
  }
}
extension Tuple4: Encodable where A: Encodable, B: Encodable, C: Encodable, D: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.unkeyedContainer()
    try container.encode(tuple.0)
    try container.encode(tuple.1)
    try container.encode(tuple.2)
    try container.encode(tuple.3)
  }
}
extension Tuple5: Encodable
where A: Encodable, B: Encodable, C: Encodable, D: Encodable, E: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.unkeyedContainer()
    try container.encode(tuple.0)
    try container.encode(tuple.1)
    try container.encode(tuple.2)
    try container.encode(tuple.3)
    try container.encode(tuple.4)
  }
}
extension Tuple6: Encodable
where A: Encodable, B: Encodable, C: Encodable, D: Encodable, E: Encodable, F: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.unkeyedContainer()
    try container.encode(tuple.0)
    try container.encode(tuple.1)
    try container.encode(tuple.2)
    try container.encode(tuple.3)
    try container.encode(tuple.4)
    try container.encode(tuple.5)
  }
}

// MARK: - Equatable

extension Tuple2: Equatable where A: Equatable, B: Equatable {
  public static func == (precedingValue: Tuple2, followingValue: Tuple2) -> Bool {
    return precedingValue.tuple == followingValue.tuple
  }
}
extension Tuple3: Equatable where A: Equatable, B: Equatable, C: Equatable {
  public static func == (precedingValue: Tuple3, followingValue: Tuple3) -> Bool {
    return precedingValue.tuple == followingValue.tuple
  }
}
extension Tuple4: Equatable where A: Equatable, B: Equatable, C: Equatable, D: Equatable {
  public static func == (precedingValue: Tuple4, followingValue: Tuple4) -> Bool {
    return precedingValue.tuple == followingValue.tuple
  }
}
extension Tuple5: Equatable
where A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable {
  public static func == (precedingValue: Tuple5, followingValue: Tuple5) -> Bool {
    return precedingValue.tuple == followingValue.tuple
  }
}
extension Tuple6: Equatable
where A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable, F: Equatable {
  public static func == (precedingValue: Tuple6, followingValue: Tuple6) -> Bool {
    return precedingValue.tuple == followingValue.tuple
  }
}

// MARK: - Hashable

extension Tuple2: Hashable where A: Hashable, B: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(tuple.0)
    hasher.combine(tuple.1)
  }
}
extension Tuple3: Hashable where A: Hashable, B: Hashable, C: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(tuple.0)
    hasher.combine(tuple.1)
    hasher.combine(tuple.2)
  }
}
extension Tuple4: Hashable where A: Hashable, B: Hashable, C: Hashable, D: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(tuple.0)
    hasher.combine(tuple.1)
    hasher.combine(tuple.2)
    hasher.combine(tuple.3)
  }
}
extension Tuple5: Hashable where A: Hashable, B: Hashable, C: Hashable, D: Hashable, E: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(tuple.0)
    hasher.combine(tuple.1)
    hasher.combine(tuple.2)
    hasher.combine(tuple.3)
    hasher.combine(tuple.4)
  }
}
extension Tuple6: Hashable
where A: Hashable, B: Hashable, C: Hashable, D: Hashable, E: Hashable, F: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(tuple.0)
    hasher.combine(tuple.1)
    hasher.combine(tuple.2)
    hasher.combine(tuple.3)
    hasher.combine(tuple.4)
    hasher.combine(tuple.5)
  }
}

// MARK: - TransparentWrapper

extension Tuple2: TransparentWrapper {
  public var wrappedInstance: Any {
    return tuple
  }
}
extension Tuple3: TransparentWrapper {
  public var wrappedInstance: Any {
    return tuple
  }
}
extension Tuple4: TransparentWrapper {
  public var wrappedInstance: Any {
    return tuple
  }
}
extension Tuple5: TransparentWrapper {
  public var wrappedInstance: Any {
    return tuple
  }
}
extension Tuple6: TransparentWrapper {
  public var wrappedInstance: Any {
    return tuple
  }
}

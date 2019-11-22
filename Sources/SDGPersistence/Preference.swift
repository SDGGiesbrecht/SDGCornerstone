/*
 Preference.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGLogic

/// A persistent user preference which can hold any codable value.
///
/// `Preference` instances are obtained from `PreferenceSet.subscript(key:)`.
public struct Preference: Equatable, TransparentWrapper {

  // MARK: - Initialization

  /// Returns an empty mock preference.
  ///
  /// The returned instance can be used with any API which expects a `Preference` type, but it does not belong to a `PreferenceSet` and will never be saved to the disk.
  ///
  /// (Real preferences are obtained from `PreferenceSet.subscript(key:)`.)
  public static func mock() -> Preference {
    return Preference(propertyListObject: nil)
  }

  internal init(propertyListObject: NSObject?) {
    self.propertyListObject = propertyListObject
  }

  // MARK: - Properties

  internal var propertyListObject: NSObject? {
    didSet {
      cache = Cache()
    }
  }
  private class Cache {
    fileprivate init() {}
    fileprivate var types: [ObjectIdentifier: Any?] = [:]
  }
  private var cache: Cache = Cache()

  // MARK: - Usage

  private func cast(_ instance: Any) -> NSObject {
    return Preference.cast(instance)
  }
  internal static func cast(_ instance: Any) -> NSObject {
    if let object = instance as? NSObject {
      return object
    } else if let dictionary = instance as? [String: Any] {  // @exempt(from: tests)
      // @exempt(from: tests) Unreachable where the Objective‐C runtime is available.
      return NSDictionary(dictionary: dictionary.mapValues({ cast($0) }))  // @exempt(from: tests)
    } else if let array = instance as? [Any] {
      return NSArray(array: array.map({ cast($0) }))  // @exempt(from: tests)
    } else if let boolean = instance as? Bool {
      return NSNumber(value: boolean)
    } else if let integer = instance as? Int {
      return NSNumber(value: integer)
    } else if let floatingPoint = instance as? Double {
      return NSNumber(value: floatingPoint)
    } else if let string = instance as? String {
      return NSString(string: string)
    } else if let date = instance as? Date {
      return NSDate(timeInterval: 0, since: date)
    } else if let data = instance as? Data {
      return NSData(data: data)
    } else if let integer = instance as? UInt {
      return NSNumber(value: integer)
    } else if let integer = instance as? Int64 {
      return NSNumber(value: integer)
    } else if let integer = instance as? UInt64 {
      return NSNumber(value: integer)
    } else if let integer = instance as? Int32 {
      return NSNumber(value: integer)
    } else if let integer = instance as? UInt32 {
      return NSNumber(value: integer)
    } else if let floatingPoint = instance as? Float {
      return NSNumber(value: floatingPoint)
    } else if let integer = instance as? Int16 {
      return NSNumber(value: integer)
    } else if let integer = instance as? UInt16 {
      return NSNumber(value: integer)
    } else if let integer = instance as? Int8 {
      return NSNumber(value: integer)
    } else if let integer = instance as? UInt8 {
      return NSNumber(value: integer)
    } else if let dictionary = instance as? [NSString: Any] {
      return NSDictionary(dictionary: dictionary.mapValues({ cast($0) }))  // @exempt(from: tests)
    } else {
      _unreachable()
    }
  }

  private func encodeAndDeserialize<T>(_ value: [T]) throws -> Any where T: Encodable {
    return try PropertyListSerialization.propertyList(
      from: PropertyListEncoder().encode(value),
      options: [],
      format: nil
    )
  }
  private func serializeAndDecode<T>(_ array: NSArray, as type: T.Type) throws -> [T]
  where T: Decodable {
    return try PropertyListDecoder().decode(
      [T].self,
      from: PropertyListSerialization.data(fromPropertyList: array, format: .binary, options: 0)
    )
  }

  // @documentation(SDGCornerstone.Preference.set(to:))
  /// Sets the preference to a particular value.
  ///
  /// - Parameters:
  ///     - value: The new preference value, either an instance of a `Codable` type or `nil`.
  public mutating func set<T>(to value: T?) where T: Encodable {

    guard let theValue = value else {
      // Setting to nil
      propertyListObject = nil
      return
    }

    do {
      let arrayObject = cast(try encodeAndDeserialize([theValue])) as! NSArray
      let object = cast(arrayObject.firstObject!)
      propertyListObject = object
    } catch {  // @exempt(from: tests)
      #if PREFERENCE_WARNINGS  // @exempt(from: tests)
        // This indicates a precondition violation during coding, but it is not worth stopping execution.
        print(error)
      #endif
      propertyListObject = nil
    }
  }

  // #documentation(SDGCornerstone.Preference.set(to:))
  /// Sets the preference to a particular value.
  ///
  /// - Parameters:
  ///     - value: The new preference value, either an instance of a `Codable` type or `nil`.
  public mutating func set(to value: NilLiteral) {
    propertyListObject = nil
  }

  /// Returns the preference cast to a particular type.
  ///
  /// The result will be `nil` if the preference is unset or if its value has a differing type. (Types with compatible `Coding` representations will still be returned successfully.)
  ///
  /// - Parameters:
  ///     - type: The type to cast to.
  public func `as`<T>(_ type: T.Type) -> T? where T: Decodable {
    guard let object = propertyListObject else {
      // Value is nil.
      return nil
    }

    let converted = cached(in: &cache.types[ObjectIdentifier(type)]) { () -> Any? in

      do {
        return try serializeAndDecode(NSArray(object: object), as: T.self)[0]
      } catch {
        #if PREFERENCE_WARNINGS
          print(error)
        #endif
        return nil
      }
    }
    return converted as! T?
  }

  /// The preference cast to a particular type.
  ///
  /// The result will be `nil` if the preference is unset or if its value has a differing type. (Types with compatible `Coding` representations will still be returned successfully.)
  ///
  /// - Parameters:
  ///     - type: The type to cast to.
  public subscript<T>(as type: T.Type) -> T? where T: Decodable, T: Encodable {
    get {
      return `as`(type)
    }
    set {
      set(to: newValue)
    }
  }

  /// The preference cast to a particular type, or a default value.
  ///
  /// The result will be the default if the preference is unset or if its value has a differing type. (Types with compatible `Coding` representations will still be returned successfully.)
  ///
  /// - Parameters:
  ///     - type: The type to cast to.
  ///     - default: The default.
  public subscript<T>(as type: T.Type, default default: T) -> T where T: Decodable, T: Encodable {
    get {
      return self[as: type] ?? `default`
    }
    set {
      self[as: type] = newValue
    }
  }

  // MARK: - Equatable

  public static func == (precedingValue: Preference, followingValue: Preference) -> Bool {
    return precedingValue.propertyListObject == followingValue.propertyListObject
  }

  // MARK: - TransparentWrapper

  public var wrappedInstance: Any {
    return propertyListObject as Any
  }
}

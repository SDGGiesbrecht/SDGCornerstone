/*
 Preference.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow

public struct Preference : CustomStringConvertible, Equatable {

    // MARK: - Initialization

    /// Returns an empty mock preference.
    ///
    /// The returned instance can be used with any API which expects a `Preference` type, but it does not belong to a `PreferenceSet` and will never be saved to the disk.
    ///
    /// (Real preferences are obtained from `PreferenceSet.subscript(key:)`.)
    @_inlineable public static func mock() -> Preference {
        return Preference(propertyListObject: nil)
    }

    @_versioned internal init(propertyListObject: NSObject?) {
        self.propertyListObject = propertyListObject
    }

    // MARK: - Properties

    @_versioned internal var propertyListObject: NSObject? {
        didSet {
            cache = Cache()
        }
    }
    @_versioned internal class Cache {
        fileprivate init() {}
        @_versioned internal var types: [ObjectIdentifier : Any?] = [:]
    }
    @_versioned internal var cache: Cache = Cache()

    // MARK: - Usage

    #if os(Linux)
        // [_Workaround: Linux has casting issues. (Swift 4.0.3)_]
        private func cast(_ instance: Any) -> NSObject {
            return Preference.cast(instance)
        }
        internal static func cast(_ instance: Any) -> NSObject {
            if let object = instance as? NSObject {
                return object
            } else if let dictionary = instance as? [String: Any] {
                return NSDictionary(dictionary: dictionary.mapValues({ cast($0) }))
            } else if let array = instance as? [Any] {
                return NSArray(array: array.map({ cast($0) }))
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
                return NSDictionary(dictionary: dictionary.mapValues({ cast($0) }))
            } else {
                _unreachable()
            }
        }
    #endif

    public mutating func set<T>(to value: T?) where T : Encodable {

        guard let theValue = value else {
            // Setting to nil
            propertyListObject = nil
            return
        }

        do {
            #if os(Linux)
                // [_Workaround: Until Linux has PropertyListEncoder. (Swift 4.0.3)_]
                let encodedArray = try JSONEncoder().encode([theValue])
                let arrayObject = cast(try JSONSerialization.jsonObject(with: encodedArray, options: [])) as! NSArray
                let object = cast(arrayObject.firstObject!)
            #else
                let encodedArray = try PropertyListEncoder().encode([theValue])
                let arrayObject = try PropertyListSerialization.propertyList(from: encodedArray, options: [], format: nil) as! NSArray
                let object = arrayObject.firstObject! as! NSObject
            #endif
            propertyListObject = object
        } catch { // [_Exempt from Test Coverage_]
            if BuildConfiguration.current == .debug { // [_Exempt from Test Coverage_]
                // This indicates a precondition violation during coding, but it is not worth stopping execution.
                print(error)
            } // [_Exempt from Test Coverage_]
            propertyListObject = nil
        }
    }

    @_inlineable public mutating func set(to value: NilLiteral) {
        propertyListObject = nil
    }

    @_inlineable public func `as`<T>(_ type: T.Type) -> T? where T : Decodable {
        guard let object = propertyListObject else {
            // Value is nil.
            return nil
        }

        let converted = cached(in: &cache.types[ObjectIdentifier(type)]) { () -> Any? in

            do {
                #if os(Linux)
                // [_Workaround: Until Linux has PropertyListEncoder. (Swift 4.0.3)_]
                    let encodedArray = try JSONSerialization.data(withJSONObject: NSArray(object: object), options: [])
                    let decodedArray = try JSONDecoder().decode([T].self, from: encodedArray)
                #else
                    let encodedArray = try PropertyListSerialization.data(fromPropertyList: NSArray(object: object), format: .binary, options: 0)
                    let decodedArray = try PropertyListDecoder().decode([T].self, from: encodedArray)
                #endif
                return decodedArray[0]
            } catch {
                if BuildConfiguration.current == .debug {
                    print(error)
                }
                return nil
            }
        }
        return converted as! T?
    }

    // MARK: - CustomStringConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomStringConvertible.description_]
    /// A textual representation of the instance.
    @_inlineable public var description: String {
        return String(describing: propertyListObject)
    }

    // MARK: - Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    @_inlineable public static func ==(precedingValue: Preference, followingValue: Preference) -> Bool {
        return precedingValue.propertyListObject == followingValue.propertyListObject
    }
}

/*
 PropertyListValue.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

/// A property list value. (`Bool`, `IntFamily`, `FloatFamily`, `String` (except `Float80`), `Date`, `Data`, `[PropertyListValue]`, [String: PropertyListValue], or `UIntFamily`)
public protocol PropertyListValue {

}

// These are necessary for reliable as? casting.
extension NSNumber : PropertyListValue {}
extension NSString : PropertyListValue {}
extension NSDate : PropertyListValue {}
extension NSData : PropertyListValue {}
extension NSArray : PropertyListValue {}
extension NSDictionary : PropertyListValue {}

extension PropertyListValue {

    /// A representation that can be tested for equality with any other property list value no matter the type.
    public typealias EquatableRepresentation = NSObject

    // [_Define Documentation: SDGCornerstone.PropertyListValue.equatableRepresentation_]
    /// The equatable representation
    public var equatableRepresentation: EquatableRepresentation {
        if let result = self as? EquatableRepresentation {
            return result

            // [_Workaround: Linux does not bridge well yet. (Swift 3.1.0)_]

        } else if let boolean = self as? Bool { // [_Exempt from Code Coverage_] Unreachable on macOS.
            return NSNumber(value: boolean)
        } else if let integer = self as? Int { // [_Exempt from Code Coverage_] Unreachable on macOS.
            return NSNumber(value: integer)
        } else if let integer = self as? UInt { // [_Exempt from Code Coverage_] Unreachable on macOS.
            return NSNumber(value: integer)
        } else if let integer = self as? Int64 { // [_Exempt from Code Coverage_] Unreachable on macOS.
            return NSNumber(value: integer)
        } else if let integer = self as? UInt64 { // [_Exempt from Code Coverage_] Unreachable on macOS.
            return NSNumber(value: integer)
        } else if let integer = self as? Int32 { // [_Exempt from Code Coverage_] Unreachable on macOS.
            return NSNumber(value: integer)
        } else if let integer = self as? UInt32 { // [_Exempt from Code Coverage_] Unreachable on macOS.
            return NSNumber(value: integer)
        } else if let integer = self as? Int16 { // [_Exempt from Code Coverage_] Unreachable on macOS.
            return NSNumber(value: integer)
        } else if let integer = self as? UInt16 { // [_Exempt from Code Coverage_] Unreachable on macOS.
            return NSNumber(value: integer)
        } else if let integer = self as? Int8 { // [_Exempt from Code Coverage_] Unreachable on macOS.
            return NSNumber(value: integer)
        } else if let integer = self as? UInt8 { // [_Exempt from Code Coverage_] Unreachable on macOS.
            return NSNumber(value: integer)
        } else if let floatingPointNumber = self as? Double { // [_Exempt from Code Coverage_] Unreachable on macOS.
            return NSNumber(value: floatingPointNumber)
        } else if let floatingPointNumber = self as? Float { // [_Exempt from Code Coverage_] Unreachable on macOS.
            return NSNumber(value: floatingPointNumber)
        } else if let string = self as? String { // [_Exempt from Code Coverage_] Unreachable on macOS.
            return NSString(string: string)
        } else if let date = self as? Date { // [_Exempt from Code Coverage_] Unreachable on macOS.
            return NSDate(timeInterval: 0, since: date)
        } else if let data = self as? Data { // [_Exempt from Code Coverage_] Unreachable on macOS.
            return NSData(data: data)
        } else if let array = self as? [Any] { // [_Exempt from Code Coverage_] Unreachable on macOS.
            return NSArray(array: array)
        } else if let dictionary = self as? [String: Any] { // [_Exempt from Code Coverage_] Unreachable on macOS.
            return NSDictionary(dictionary: dictionary)
        } else if let dictionary = self as? [NSString: Any] { // [_Exempt from Code Coverage_] Unreachable on macOS.
            return NSDictionary(dictionary: dictionary)
        } else {
            preconditionFailure("\(type(of: self)) is not a property list value.")
        }
    }
}

// [_Workaround: The following are temporary replacements for as?, because Linux doesn’t bridge well yet. (Swift 3.1.0)_]

extension PropertyListValue {

    /// Returns the property list value as the specified type if possible, or `nil`.
    ///
    /// - Note: This is a temporary replacement for `as? V` until it works reliably on all platforms.
    public func `as`<V : PropertyListValue>(_ type: V.Type) -> V? {
        if let result = self as? V {
            return result
        } else if V.self == Bool.self {
            if let result = self as? NSNumber {
                return result.boolValue as? V
            } else {
                return nil
            }
        } else if V.self == Int.self {
            if let result = self as? NSNumber {
                return result.intValue as? V
            } else {
                return nil
            }
        } else if V.self == UInt.self {
            if let result = self as? NSNumber {
                return result.uintValue as? V
            } else {
                return nil
            }
        } else if V.self == Int64.self {
            if let result = self as? NSNumber {
                return result.int64Value as? V
            } else {
                return nil
            }
        } else if V.self == UInt64.self {
            if let result = self as? NSNumber {
                return result.uint64Value as? V
            } else {
                return nil
            }
        } else if V.self == Int32.self {
            if let result = self as? NSNumber {
                return result.int32Value as? V
            } else {
                return nil
            }
        } else if V.self == UInt32.self {
            if let result = self as? NSNumber {
                return result.uint32Value as? V
            } else {
                return nil
            }
        } else if V.self == Int16.self {
            if let result = self as? NSNumber {
                return result.int16Value as? V
            } else {
                return nil
            }
        } else if V.self == UInt16.self {
            if let result = self as? NSNumber {
                return result.uint16Value as? V
            } else {
                return nil
            }
        } else if V.self == Int8.self {
            if let result = self as? NSNumber {
                return result.int8Value as? V
            } else {
                return nil
            }
        } else if V.self == UInt8.self {
            if let result = self as? NSNumber {
                return result.uint8Value as? V
            } else {
                return nil
            }
        } else if V.self == Double.self {
            if let result = self as? NSNumber {
                return result.doubleValue as? V
            } else {
                return nil
            }
        } else if V.self == Float.self {
            if let result = self as? NSNumber {
                return result.floatValue as? V
            } else {
                return nil
            }
        } else if V.self == NSNumber.self {
            if let result = self as? Bool {
                return NSNumber(value: result) as? V
            } else if let result = self as? Int {
                return NSNumber(value: result) as? V
            } else if let result = self as? UInt {
                return NSNumber(value: result) as? V
            } else if let result = self as? Int64 {
                return NSNumber(value: result) as? V
            } else if let result = self as? UInt64 {
                return NSNumber(value: result) as? V
            } else if let result = self as? Int32 {
                return NSNumber(value: result) as? V
            } else if let result = self as? UInt32 {
                return NSNumber(value: result) as? V
            } else if let result = self as? Int16 {
                return NSNumber(value: result) as? V
            } else if let result = self as? UInt16 {
                return NSNumber(value: result) as? V
            } else if let result = self as? Int8 {
                return NSNumber(value: result) as? V
            } else if let result = self as? UInt8 {
                return NSNumber(value: result) as? V
            } else if let result = self as? Double {
                return NSNumber(value: result) as? V
            } else if let result = self as? Float {
                return NSNumber(value: result) as? V
            } else {
                return nil
            }
        } else if V.self == String.self {
            if let result = self as? NSString {
                return result.substring(from: 0) as? V
            } else {
                return nil
            }
        } else if V.self == NSString.self {
            if let result = self as? String {
                return NSString(string: result) as? V
            } else {
                return nil
            }
        } else if V.self == Date.self {
            if let result = self as? NSDate {
                return Date(timeIntervalSinceReferenceDate: result.timeIntervalSinceReferenceDate) as? V
            } else {
                return nil
            }
        } else if V.self == NSDate.self {
            if let result = self as? Date {
                return NSDate(timeInterval: 0, since: result) as? V
            } else {
                return nil
            }
        } else if V.self == Data.self {
            if let result = self as? NSData {
                return result.subdata(with: NSRange(location: 0, length: result.length)) as? V
            } else {
                return nil
            }
        } else if V.self == NSData.self {
            if let result = self as? Data {
                return NSData(data: result) as? V
            } else {
                return nil
            }
        } else if V.self == [PropertyListValue].self {
            if let result = self as? NSArray {
                return result.map({ $0 }) as? V
            } else {
                return nil
            }
        } else if V.self == NSArray.self {
            if let result = self as? [PropertyListValue] {
                return NSArray(array: result) as? V
            } else {
                return nil
            }
        } else if V.self == [String: PropertyListValue].self {
            if let result = self as? NSDictionary {
                var dictionary: [String: PropertyListValue] = [:]
                for (propertyListKey, propertyListValue) in result {
                    if let key = (propertyListKey as? PropertyListValue)?.as(String.self),
                        let value = propertyListValue as? PropertyListValue {
                        dictionary[key] = value
                    } else {
                        return nil
                    }
                }
                return dictionary as? V
            } else if let result = self as? [NSString: PropertyListValue] {
                var dictionary: [String: PropertyListValue] = [:]
                for (key, value) in result {
                    dictionary[key.substring(from: 0)] = value
                }
                return dictionary as? V
            } else {
                return nil
            }
        } else if V.self == NSDictionary.self {
            if let result = self as? [String: PropertyListValue] {
                return NSDictionary(dictionary: result) as? V
            } else if let result = self as? [NSString: PropertyListValue] {
                return NSDictionary(dictionary: result) as? V
            } else {
                return nil
            }
        } else if V.self == [NSString: PropertyListValue].self {
            if let result = self as? NSDictionary {
                var dictionary: [NSString: PropertyListValue] = [:]
                for (propertyListKey, propertyListValue) in result {
                    if let key = (propertyListKey as? PropertyListValue)?.as(NSString.self),
                        let value = propertyListValue as? PropertyListValue {
                        dictionary[key] = value
                    } else {
                        return nil
                    }
                }
                return dictionary as? V
            } else if let result = self as? [String: PropertyListValue] {
                var dictionary: [NSString: PropertyListValue] = [:]
                for (key, value) in result {
                    dictionary[NSString(string: key)] = value
                }
                return dictionary as? V
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}

private struct WrongType : Error {}

extension PropertyListValue {

    /// Returns the property list value as an array of the specified type if possible, or `nil`.
    ///
    /// - Note: This is a temporary replacement for `as? [V]` until it works reliably on all platforms.
    public func asArray<V : PropertyListValue>(of type: V.Type) -> [V]? {
        if let array = `as`([V].self) {
            return array
        } else if let array = `as`([PropertyListValue].self) {
            return try? array.map() { (element: PropertyListValue) -> V in
                guard let result = element.as(V.self) else {
                    throw WrongType()
                }
                return result
            }
        } else {
            return nil
        }
    }

    /// Returns the property list value as a dictionary of the specified type if possible, or `nil`.
    ///
    /// - Note: This is a temporary replacement for `as? [V]` until it works reliably on all platforms.
    public func asDictionary<V : PropertyListValue>(of type: V.Type) -> [String: V]? {
        if let dictionary = `as`([String: V].self) {
            return dictionary
        } else if let dictionary = `as`([String: PropertyListValue].self) {
            return try? dictionary.mapKeyValuePairs() { (key: String, value: PropertyListValue) -> (String, V) in
                guard let result = value.as(V.self) else {
                    throw WrongType()
                }
                return (key, result)
            }
        } else {
            return nil
        }
    }
}

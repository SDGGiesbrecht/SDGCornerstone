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
        guard let result = self as? EquatableRepresentation else { // [_Exempt from Code Coverage_]
            #if os(Linux)
                // [_Workaround: Linux doesn’t bridge well on its own yet. (Swift 3.1.0)_]
                if let boolean = self as? Bool {
                    return NSNumber(value: boolean)
                } else if let integer = self as? Int {
                    return NSNumber(value: integer)
                } else if let integer = self as? UInt {
                    return NSNumber(value: integer)
                } else if let integer = self as? Int64 {
                    return NSNumber(value: integer)
                } else if let integer = self as? UInt64 {
                    return NSNumber(value: integer)
                } else if let integer = self as? Int32 {
                    return NSNumber(value: integer)
                } else if let integer = self as? UInt32 {
                    return NSNumber(value: integer)
                } else if let integer = self as? Int16 {
                    return NSNumber(value: integer)
                } else if let integer = self as? UInt16 {
                    return NSNumber(value: integer)
                } else if let integer = self as? Int8 {
                    return NSNumber(value: integer)
                } else if let integer = self as? UInt8 {
                    return NSNumber(value: integer)
                } else if let floatingPointNumber = self as? Double {
                    return NSNumber(value: floatingPointNumber)
                } else if let floatingPointNumber = self as? Float {
                    return NSNumber(value: floatingPointNumber)
                } else if let string = self as? String {
                    return NSString(string: string)
                } else if let date = self as? Date {
                    return NSDate(timeInterval: 0, since: date)
                } else if let data = self as? Data {
                    return NSData(data: data)
                } else if let array = self as? [Any] {
                    return NSArray(array: array)
                } else if let dictionary = self as? [String: Any] {
                    return NSDictionary(dictionary: dictionary)
                }
            #endif
            preconditionFailure("\(type(of: self)) is not a property list value.")
        }
        return result
    }
}

// [_Workaround: The following are temporary replacements for as?, because Linux doesn’t bridge well yet. (Swift 3.1.0)_]

extension PropertyListValue {

    fileprivate var normalized: PropertyListValue {
        if let result = self as? Bool {
            return NSNumber(value: result)
        } else if let result = self as? Int {
            return NSNumber(value: result)
        } else if let result = self as? UInt {
            return NSNumber(value: result)
        } else if let result = self as? Int64 {
            return NSNumber(value: result)
        } else if let result = self as? UInt64 {
            return NSNumber(value: result)
        } else if let result = self as? Int32 {
            return NSNumber(value: result)
        } else if let result = self as? UInt32 {
            return NSNumber(value: result)
        } else if let result = self as? Int16 {
            return NSNumber(value: result)
        } else if let result = self as? UInt16 {
            return NSNumber(value: result)
        } else if let result = self as? Int8 {
            return NSNumber(value: result)
        } else if let result = self as? UInt8 {
            return NSNumber(value: result)
        } else if let result = self as? Double {
            return NSNumber(value: result)
        } else if let result = self as? Float {
            return NSNumber(value: result)
        } else if let result = self as? NSString {
            return result.substring(from: 0)
        } else if let result = self as? NSDate {
            return Date(timeIntervalSinceReferenceDate: result.timeIntervalSinceReferenceDate)
        } else if let result = self as? NSData {
            return result.subdata(with: NSRange(location: 0, length: result.length))
        } else if let result = self as? [PropertyListValue] {
            return result.map() { $0.normalized }
        } else if let object = self as? NSArray { // [_Exempt from Code Coverage_] Unreachable on macOS.
            var result: [PropertyListValue] = []
            for objectElement in object { // [_Exempt from Code Coverage_] Unreachable on macOS.
                guard let element = objectElement as? PropertyListValue else {
                    preconditionFailure("\(objectElement) (\(type(of: objectElement))) is not a property list value.")
                } // [_Exempt from Code Coverage_] Unreachable on macOS.
                result.append(element.normalized)
            } // [_Exempt from Code Coverage_] Unreachable on macOS.
            return result
        } else if let result = self as? [String: PropertyListValue] {
            return result.mapKeyValuePairs() { ($0, $1.normalized) }
        } else if let object = self as? NSDictionary {
            var result: [String: PropertyListValue] = [:]
            for (objectKey, objectValue) in object {
                guard let key = (objectKey as? PropertyListValue)?.asString else {
                    preconditionFailure("\(objectKey) (\(type(of: objectKey))) is not a property list key.")
                }
                guard let value = objectValue as? PropertyListValue else {
                    preconditionFailure("\(objectValue) (\(type(of: objectValue))) is not a property list value.")
                }
                result[key] = value.normalized
            }
            return result
        } else { // [_Exempt from Code Coverage_] Unreachable on macOS.
            return self
        }
    }

    /// Accesses the property list value as a boolean value.
    ///
    /// - Note: This is a temporary replacement for `value as? Bool` until it works reliably on Linux.
    public var asBool: Bool? {
        return self as? Bool ?? (normalized as? NSNumber)?.boolValue // [_Exempt from Code Coverage_] Unreachable on macOS.
    }

    /// Accesses the property list value as an integer.
    ///
    /// - Note: This is a temporary replacement for `value as? Int` until it works reliably on Linux.
    public var asInt: Int? {
        return self as? Int ?? (normalized as? NSNumber)?.intValue // [_Exempt from Code Coverage_] Unreachable on macOS.
    }

    /// Accesses the property list value as a floating point number.
    ///
    /// - Note: This is a temporary replacement for `value as? Double` until it works reliably on Linux.
    public var asDouble: Double? {
        return self as? Double ?? (normalized as? NSNumber)?.doubleValue // [_Exempt from Code Coverage_] Unreachable on macOS.
    }

    /// Accesses the property list value as a string value.
    ///
    /// - Note: This is a temporary replacement for `value as? String` until it works reliably on Linux.
    public var asString: String? {
        return self as? String ?? normalized as? String // [_Exempt from Code Coverage_] Unreachable on macOS.
    }

    /// Accesses the property list value as a date value.
    ///
    /// - Note: This is a temporary replacement for `value as? Date` until it works reliably on Linux.
    public var asDate: Date? {
        return self as? Date ?? normalized as? Date // [_Exempt from Code Coverage_] Unreachable on macOS.
    }

    /// Accesses the property list value as a data value.
    ///
    /// - Note: This is a temporary replacement for `value as? Data` until it works reliably on Linux.
    public var asData: Data? {
        return self as? Data ?? normalized as? Data // [_Exempt from Code Coverage_] Unreachable on macOS.
    }
}

private struct WrongType : Error {}

extension PropertyListValue {

    /// Accesses the property list value as an array value.
    ///
    /// - Note: This is a temporary replacement for `value as? [V]` until it works reliably on Linux.
    public func asArray<V : PropertyListValue>(of type: V.Type) -> [V]? {
        if let array = asArray {
            return try? array.map() { (element: PropertyListValue) -> V in
                guard let result = element as? V else {
                    throw WrongType()
                }
                return result
            }
        } else {
            return nil
        }
    }

    /// Accesses the property list value as an array value.
    ///
    /// - Note: This is a temporary replacement for `value as? [PropertyListValue]` until it works reliably on Linux.
    public var asArray: [PropertyListValue]? {
        return self as? [PropertyListValue] ?? normalized as? [PropertyListValue] // [_Exempt from Code Coverage_] Unreachable on macOS.
    }

    /// Accesses the property list value as a dictionary value.
    ///
    /// - Note: This is a temporary replacement for `value as? [String: V]` until it works reliably on Linux.
    public func asDictionary<V : PropertyListValue>(of type: V.Type) -> [String: V]? {
        if let dictionary = asDictionary {
            return try? dictionary.mapKeyValuePairs() { (key: String, value: PropertyListValue) -> (String, V) in
                guard let result = value as? V else {
                    throw WrongType()
                }
                return (key, result)
            }
        } else {
            return nil
        }
    }

    /// Accesses the property list value as a dictionary value.
    ///
    /// - Note: This is a temporary replacement for `value as? [String: PropertyListValue]` until it works reliably on Linux.
    public var asDictionary: [String: PropertyListValue]? {
        return self as? [String: PropertyListValue] ?? normalized as? [String: PropertyListValue]
    }
}

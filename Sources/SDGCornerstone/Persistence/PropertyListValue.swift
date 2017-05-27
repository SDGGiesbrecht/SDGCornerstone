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
                } else if let floatingPointNumber = self as? Double {
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

extension Shared where Value == PropertyListValue? {
    // MARK: - where Value == PropertyListValue?

    /// Accesses the property list value as a boolean value.
    ///
    /// - Note: This is a temporary replacement for `value as? Bool` until it works reliably on Linux.
    public var asBool: Bool? {
        get {
            #if os(Linux)

                if let result = value as? Bool {
                    return result
                } else if let result = value as? NSNumber {
                    return result.boolValue
                } else {
                    return nil
                }

            #else

                return value as? Bool

            #endif
        }
        set {
            value = newValue
        }
    }

    /// Accesses the property list value as an integer.
    ///
    /// - Note: This is a temporary replacement for `value as? Int` until it works reliably on Linux.
    public var asInt: Int? {
        get {
            #if os(Linux)

                if let result = value as? Int {
                    return result
                } else if let result = value as? NSNumber {
                    return result.intValue
                } else {
                    return nil
                }

            #else

                return value as? Int

            #endif
        }
        set {
            value = newValue
        }
    }

    /// Accesses the property list value as a floating point number.
    ///
    /// - Note: This is a temporary replacement for `value as? Double` until it works reliably on Linux.
    public var asDouble: Double? {
        get {
            #if os(Linux)

                if let result = value as? Double {
                    return result
                } else if let result = value as? NSNumber {
                    return result.doubleValue
                } else {
                    return nil
                }

            #else

                return value as? Double

            #endif
        }
        set {
            value = newValue
        }
    }

    /// Accesses the property list value as a string value.
    ///
    /// - Note: This is a temporary replacement for `value as? String` until it works reliably on Linux.
    public var asString: String? {
        get {
            #if os(Linux)

                if let result = value as? String {
                    return result
                } else if let result = value as? NSString {
                    return result.substring(with: NSRange(location: 0, length: result.length))
                } else {
                    return nil
                }

            #else

                return value as? String

            #endif
        }
        set {
            value = newValue
        }
    }

    /// Accesses the property list value as a date value.
    ///
    /// - Note: This is a temporary replacement for `value as? Date` until it works reliably on Linux.
    public var asDate: Date? {
        get {
            #if os(Linux)

                if let result = value as? Date {
                    return result
                } else if let result = value as? NSDate {
                    return Date(timeIntervalSinceReferenceDate: result.timeIntervalSinceReferenceDate)
                } else {
                    return nil
                }

            #else

                return value as? Date

            #endif
        }
        set {
            value = newValue
        }
    }

    /// Accesses the property list value as a data value.
    ///
    /// - Note: This is a temporary replacement for `value as? Data` until it works reliably on Linux.
    public var asData: Data? {
        get {
            #if os(Linux)

                if let result = value as? Data {
                    return result
                } else if let result = value as? NSData {
                    return result.subdata(with: NSRange(location: 0, length: result.length))
                } else {
                    return nil
                }

            #else

                return value as? Data

            #endif
        }
        set {
            value = newValue
        }
    }

    /// Accesses the property list value as an array value.
    ///
    /// - Note: This is a temporary replacement for `value as? [PropertyListValue]` until it works reliably on Linux.
    public var asArray: [PropertyListValue]? {
        get {
            #if os(Linux)

                if let result = value as? [PropertyListValue] {
                    return result
                } else if let object = value as? NSArray {
                    var result: [PropertyListValue] = []
                    for entry in object {
                        if let property = entry as? PropertyListValue {
                            result.append(property)
                        } else {
                            return nil
                        }
                    }
                } else {
                    return nil
                }

            #else

                return value as? [PropertyListValue]

            #endif
        }
        set {
            value = newValue
        }
    }

    /// Accesses the property list value as a dictionary value.
    ///
    /// - Note: This is a temporary replacement for `value as? [String: PropertyListValue]` until it works reliably on Linux.
    public var asDictionary: [String: PropertyListValue]? {
        get {
            #if os(Linux)

            if let result = value as? [String: PropertyListValue] {
                    return result
                } else if let object = value as? NSDictionary {
                    var result: [String: PropertyListValue] = [:]
                    for (identifier, entry) in object {
                        let key: String
                        if let string = identifier as? String {
                            key = string
                        } else if let nsString = identifier as? NSString {
                            key = nsString.substring(with: NSRange(location: 0, length: nsString.length))
                        } else {
                            return nil
                        }

                        if let property = entry as? PropertyListValue {
                            result[key] = property
                        } else {
                            return nil
                        }
                    }
                } else {
                    return nil
                }

            #else

                return value as? [String: PropertyListValue]

            #endif
        }
        set {
            value = newValue
        }
    }
}

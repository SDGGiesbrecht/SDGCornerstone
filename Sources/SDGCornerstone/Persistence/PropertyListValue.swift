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

/// A property list value. (`Data`, `String`, `Bool`, `IntFamily`, `FloatFamily` (except `Float80`), `Date`, `[PropertyListValue]` or [String: PropertyListValue])
public protocol PropertyListValue {

}

// These are necessary for reliable as? casting.
extension NSData : PropertyListValue {}
extension NSString : PropertyListValue {}
extension NSNumber : PropertyListValue {}
extension NSDate : PropertyListValue {}
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

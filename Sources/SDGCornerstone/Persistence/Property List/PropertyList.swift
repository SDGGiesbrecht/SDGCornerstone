/*
 PropertyList.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

/// A property list.
public enum PropertyList : Equatable, FileConvertible {

    // MARK: - Cases

    /// A dictionary.
    case dictionary([String: PropertyListValue])

    /// An array.
    case array([PropertyListValue])

    // MARK: - Properties

    /// The contents of the property list as a property list value.
    public var value: PropertyListValue {
        switch self {
        case .dictionary(let result):
            return result
        case .array(let result):
            return result
        }
    }

    // MARK: - Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - lhs: A value to compare.
    ///     - rhs: Another value to compare.
    public static func == (lhs: PropertyList, rhs: PropertyList) -> Bool {
        return lhs.value.equatableRepresentation == rhs.value.equatableRepresentation
    }

    // MARK: - FileConvertible

    /// A read error.
    public enum ReadError : Error {
        /// The data does not represent a valid property list.
        case invalid
    }

    // [_Inherit Documentation: SDGCornerstone.FileConvertible.init(file:origin:)_]
    /// Creates an instance using raw data from a file on the disk.
    ///
    /// - Parameters:
    ///     - file: The data.
    ///     - origin: A URL indicating where the data came from. In some cases this may be helpful in determining how to interpret the data, such as by checking the file extension. This parameter may be `nil` if the data did not come from a file on the disk.
    public init(file: Data, origin: URL?) throws {
        if let value = try PropertyListSerialization.propertyList(from: file, options: [], format: nil) as? PropertyListValue {
            if let dictionary = value.as([String: PropertyListValue].self) {
                self = .dictionary(dictionary)
                return
            } else if let array = value.as([PropertyListValue].self) {
                self = .array(array)
                return
            }
        }
        throw ReadError.invalid
    }

    // [_Inherit Documentation: SDGCornerstone.FileConvertible.file_]
    /// A binary representation that can be written as a file.
    public var file: Data {
        let value: Any
        switch self {
        case .dictionary(let dictionary):
            value = dictionary
        case .array(let array):
            value = array
        }
        guard let data = try? PropertyListSerialization.data(fromPropertyList: value, format: .xml, options: 0) else {
            unreachable()
        }
        return data
    }
}

/*
 String.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

extension String : FileConvertible {

    // MARK: - FileConvertible

    // #documentation(SDGCornerstone.FileConvertible.init(file:origin:))
    /// Creates an instance using raw data from a file on the disk.
    ///
    /// - Parameters:
    ///     - file: The data.
    ///     - origin: A URL indicating where the data came from. In some cases this may be helpful in determining how to interpret the data, such as by checking the file extension. This parameter may be `nil` if the data did not come from a file on the disk.
    public init(file: Data, origin: URL?) throws {

        // Let Foundation try...
        if let url = origin {
            var encoding: String.Encoding = .utf8
            if let string = try? String(contentsOf: url, usedEncoding: &encoding) {
                if string.data(using: encoding, allowLossyConversion: false) == file {
                    // Only initialize from the underlying file if it matches the data provided.
                    self = string
                }
            }
        }

        // Guess blindly...

        if let string = String(data: file, encoding: .utf8) {
            self = string
        } else if let string = String(data: file, encoding: .utf16) {
            self = string
        } else if let string = String(data: file, encoding: .utf32) { // [_Exempt from Test Coverage_] macOS does not fail UTF‐16 on invalid surrogate use, so this is unreachable.
            self = string
        } else if let string = String(data: file, encoding: .isoLatin1) { // [_Exempt from Test Coverage_] macOS does not fail UTF‐16 on invalid surrogate use, so this is unreachable.
            self = string // [_Exempt from Test Coverage_]
        } else {
            _unreachable()
        }
    }

    // #documentation(SDGCornerstone.FileConvertible.file)
    /// A binary representation that can be written as a file.
    public var file: Data {
        guard let result = data(using: .utf8) else {
            _unreachable()
        }
        return result
    }
}

/*
 Data.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Data : FileConvertible {

    // MARK: - FileConvertible

    // [_Inherit Documentation: SDGCornerstone.FileConvertible.init(file:origin:)_]
    /// Creates an instance using raw data from a file on the disk.
    ///
    /// - Parameters:
    ///     - file: The data.
    ///     - origin: A URL indicating where the data came from. In some cases this may be helpful in determining how to interpret the data, such as by checking the file extension. This parameter may be `nil` if the data did not come from a file on the disk.
    public init(file: Data, origin: URL?) throws {
        self = file
    }

    // [_Inherit Documentation: SDGCornerstone.FileConvertible.file_]
    /// A binary representation that can be written as a file.
    public var file: Data {
        return self
    }
}

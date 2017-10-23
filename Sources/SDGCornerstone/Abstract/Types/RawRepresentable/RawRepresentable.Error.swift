/*
 RawRepresentable.Error.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An error that occurs while converting from a raw value.
public enum RawRepresentableError<RawValue> : Error {

    /// The raw value is invalid.
    case invalidRawValue(RawValue, Any.Type)

    internal var debugDescription: UserFacingText<APILocalization, Void> {
        switch self {
        case .invalidRawValue(let value, let type):
            return UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
                switch localization {
                case .englishCanada: // [_Exempt from Code Coverage_]
                    return StrictString("Invalid raw value “\(value)” for \(type).")
                }
            })
        }
    }
}

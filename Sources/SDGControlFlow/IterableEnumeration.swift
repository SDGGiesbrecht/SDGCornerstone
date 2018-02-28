/*
 IterableEnumeration.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An enumeration whose cases can be iterated over.
///
/// Conformance Requirements:
///
/// - `RawRepresentable where RawValue == Int
/// - The raw values must be contiguous and begin at 0.
public protocol IterableEnumeration : RawRepresentable
where Self.RawValue == Int {

    // [_Define Documentation: SDGCornerstone.IterableEnumeration.cases_]
    /// An array containing every case of the enumeration.
    static var cases: [Self] { get }
}

extension IterableEnumeration {

    // [_Inherit Documentation: SDGCornerstone.IterableEnumeration.cases_]
    /// An array containing every case of the enumeration.
    @_inlineable public static var cases: [Self] {
        guard var instance = Self(rawValue: 0) else {
            _preconditionFailure({ (localization: _APILocalization) -> String in // [_Exempt from Test Coverage_]
                switch localization {
                case .englishCanada: // [_Exempt from Test Coverage_]
                    return "“\(Self.self)” has no case with a raw value of 0."
                }
            })
        }

        var result: [Self] = [instance]
        while let next = Self(rawValue: instance.rawValue + 1) {
            result.append(next)
            instance = next
        }
        return result
    }
}

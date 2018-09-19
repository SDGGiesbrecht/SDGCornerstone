/*
 IterableEnumeration.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 4.1.2, This will probably be obsolete when SE-0194 is implemented.)

/// An enumeration whose cases can be iterated over.
///
/// Conformance Requirements:
///
/// - `RawRepresentable where RawValue == Int
/// - The raw values must be contiguous and begin at 0.
public protocol IterableEnumeration : RawRepresentable {
    // #workaround(Swift 4.1.2, This should be constrained to “where RawValue == Int”, but that triggers abort traps when Linux tries to link against it.)

    // @documentation(SDGCornerstone.IterableEnumeration.cases)
    /// An array containing every case of the enumeration.
    static var cases: [Self] { get }
}

extension IterableEnumeration where RawValue == Int {
    // MARK: - where RawValue == Int

    // #documentation(SDGCornerstone.IterableEnumeration.cases)
    /// An array containing every case of the enumeration.
    @inlinable public static var cases: [Self] {
        guard var instance = Self(rawValue: 0) else {
            _preconditionFailure({ (localization: _APILocalization) -> String in // @exempt(from: tests)
                switch localization {
                case .englishCanada: // @exempt(from: tests)
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

/*
 IterableEnumeration.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An enumeration whose cases can be iterated over.
///
/// Conformance Requirements:
///
/// - `RawRepresentable where RawValue : OneDimensionalPoint, ExpressibleByIntegerLiteral, RawValue.Vector : IntegerType`
/// - The raw values must be contiguous and begin at 0.
public protocol IterableEnumeration : RawRepresentable {

    // [_Inherit Documentation: SDGCornerstone.RawRepresentable.RawValue_]
    /// The raw value type.
    associatedtype RawValue : OneDimensionalPoint, ExpressibleByIntegerLiteral

    // [_Define Documentation: SDGCornerstone.IterableEnumeration.cases_]
    /// An array containing every case of the enumeration.
    static var cases: [Self] { get }
}

extension IterableEnumeration where RawValue.Vector : IntegerType {
    // MARK: - where RawValue.Vector : IntegerType

    internal static var first: Self? {
        return Self(rawValue: 0)
    }

    internal func successorAsIterableEnumeration() -> Self? {
        return Self(rawValue: rawValue.successor())
    }

    // [_Inherit Documentation: SDGCornerstone.IterableEnumeration.cases_]
    /// An array containing every case of the enumeration.
    public static var cases: [Self] {
        guard var instance = first else {
            return []
        }
        var result: [Self] = [instance]
        while let next = instance.successorAsIterableEnumeration() {
            result.append(next)
            instance = next
        }
        return result
    }
}

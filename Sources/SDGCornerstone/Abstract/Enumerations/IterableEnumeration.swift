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
/// - `RawRepresentable where RawValue : FixedScaleOneDimensionalPoint, ExpressibleByIntegerLiteral, RawValue.Vector : IntegerProtocol`
/// - The raw values must be contiguous and begin at 0.
public protocol IterableEnumeration : RawRepresentable
where Self.RawValue : FixedScaleOneDimensionalPoint, Self.RawValue : ExpressibleByIntegerLiteral, Self.RawValue.Vector : IntegerProtocol {

    // [_Define Documentation: SDGCornerstone.IterableEnumeration.cases_]
    /// An array containing every case of the enumeration.
    static var cases: [Self] { get }
}

extension IterableEnumeration {

    private static func noZeroCase() -> UserFacingText<APILocalization, Void> { // [_Exempt from Code Coverage_]
        return UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in // [_Exempt from Code Coverage_]
            switch localization {
            case .englishCanada: // [_Exempt from Code Coverage_]
                return StrictString("\(Self.self) has no case with a raw value 0.")
            }
        })
    }

    internal static var first: Self {
        guard let result = Self(rawValue: 0) else {
            preconditionFailure(noZeroCase())
        }
        return result
    }

    internal static var last: Self {
        guard let result = Self.cases.last else {
            preconditionFailure(noZeroCase())
        }
        return result
    }

    internal func successorAsIterableEnumeration() -> Self? {
        return Self(rawValue: rawValue.successor())
    }

    // [_Inherit Documentation: SDGCornerstone.IterableEnumeration.cases_]
    /// An array containing every case of the enumeration.
    public static var cases: [Self] {
        var instance = first
        var result: [Self] = [instance]
        while let next = instance.successorAsIterableEnumeration() {
            result.append(next)
            instance = next
        }
        return result
    }
}

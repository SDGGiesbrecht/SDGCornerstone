/*
 ExpressibleByFloatLiteral.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension ExpressibleByFloatLiteral where Self : RationalArithmetic {
    // MARK: - where Self : RationalArithmetic

    // [_Define Documentation: SDGCornerstone.ExpressibleByFloatLiteral.init(floatLiteral:)_]
    /// Creates an instance from a floating‐point literal.
    ///
    /// - Parameters:
    ///     - floatLiteral: The floating point literal.
    public init(floatLiteral: FloatMax) {
        self.init(floatLiteral)
    }
}

// [_Workaround: The next line causes a segmentation fault. (Swift 4.0.3)_]
extension /*ExpressibleByFloatLiteral where Self : */ SmallestCalendarComponent {
    // MARK: - where Self : SmallestCalendarComponent

    // [_Inherit Documentation: SDGCornerstone.ExpressibleByFloatLiteral.init(floatLiteral:)_]
    /// Creates an instance from a floating‐point literal.
    ///
    /// - Parameters:
    ///     - floatLiteral: The floating point literal.
    public init(floatLiteral: FloatMax) {
        self.init(RawValue(floatLiteral))
    }
}

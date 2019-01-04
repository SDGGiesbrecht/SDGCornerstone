/*
 SmallestCalendarComponent.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The smallest component of a particular calendar.
public protocol SmallestCalendarComponent : ExpressibleByFloatLiteral, NumericCalendarComponent
where RawValue : RationalArithmetic {

}

extension SmallestCalendarComponent {

    // MARK: - ExpressibleByFloatLiteral

    // #documentation(SDGCornerstone.ExpressibleByFloatLiteral.init(floatLiteral:))
    /// Creates an instance from a floating‐point literal.
    ///
    /// - Parameters:
    ///     - floatLiteral: The floating point literal.
    @inlinable public init(floatLiteral: FloatMax) {
        self.init(RawValue(floatLiteral))
    }
}

/*
 SmallestCalendarComponent.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The smallest component of a particular calendar.
public protocol SmallestCalendarComponent : ExpressibleByFloatLiteral, NumericCalendarComponent {

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.RawValue_]
    /// Creates an instance with an unchecked raw value.
    ///
    /// - Note: Do not call this initializer directly. Call `init(_:)` instead, because it validates the raw value before passing it to this initializer.
    // The raw value type.
    associatedtype RawValue : RationalArithmetic
}

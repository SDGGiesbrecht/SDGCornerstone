/*
 OrdinalCalendarComponent.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

/// A calendar component defined by an ordinal raw value.
public protocol OrdinalCalendarComponent : NumericCalendarComponent {}

extension OrdinalCalendarComponent {

    // MARK: - ConsistentlyOrderedCalendarComponent

    public init(numberAlreadyElapsed: Vector) {
        self.init(numberAlreadyElapsed + (1 as Vector))
    }

    public init(ordinal: Vector) {
        self.init(ordinal)
    }

    public var numberAlreadyElapsed: Vector {
        return rawValue − (1 as Vector)
    }

    public var ordinal: Vector {
        return rawValue
    }
}

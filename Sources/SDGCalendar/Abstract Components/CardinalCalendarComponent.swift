/*
 CardinalCalendarComponent.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A calendar component defined by an cardinal number raw value.
public protocol CardinalCalendarComponent : NumericCalendarComponent {}

extension CardinalCalendarComponent {

    // MARK: - ConsistentlyOrderedCalendarComponent

    @inlinable public init(numberAlreadyElapsed: RawValue) {
        self.init(numberAlreadyElapsed)
    }

    @inlinable public init(ordinal: RawValue) {
        self.init(ordinal − (1 as Vector))
    }

    @inlinable public var numberAlreadyElapsed: RawValue {
        return rawValue
    }

    @inlinable public var ordinal: RawValue {
        return rawValue + (1 as Vector)
    }
}

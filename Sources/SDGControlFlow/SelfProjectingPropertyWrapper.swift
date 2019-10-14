/*
 SelfProjectingPropertyWrapper.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A property wrapper which is its own projected value.
public protocol SelfProjectingPropertyWrapper : ProjectingPropertyWrapper where Projected == Self {}

extension SelfProjectingPropertyWrapper {

    public var projectedValue: Self {
        return self
    }
}

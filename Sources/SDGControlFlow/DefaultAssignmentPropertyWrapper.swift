/*
 DefaultAssignmentPropertyWrapper.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A property wrapper that can be used with default assignment.
///
/// Such property wrappers can be used with this syntax:
///
/// ```swift
/// @Wrapper var property: Type = assignedDefault
/// ```
public protocol DefaultAssignmentPropertyWrapper : PropertyWrapper {

    /// Creates a wrapper with a value.
    ///
    /// - Parameters:
    ///     - wrappedValue: The wrapped value.
    init(wrappedValue: Wrapped)
}

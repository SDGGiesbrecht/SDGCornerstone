/*
 DateDefinition.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Example 1: DateDefinition_]
/// A type that provides a definition for a `CalendarDate`.
///
/// ```swift
/// ```
///
/// Conformance Requirements:
///
/// - `static var uniqueTypeIdentifier: String { get }`
/// - `static var referenceDate: CalendarDate { get }`
/// - `init(intervalSinceReferenceDate: CalendarInterval<FloatMax>)`
/// - `var intervalSinceReferenceDate: CalendarInterval<FloatMax> { get }`
public protocol DateDefinition {

    // MARK: - Static Properties

    // [_Warning: Can this be removed?_]

    // [_Define Documentation: SDGCornerstone.DateDefinition.uniqueTypeIdentifier_]
    /// A unique identifier for differentiating definition types.
    ///
    /// This is used as a key to store and retreive cached conversions to this specific type of definition. If two or more types share the same identifier (including between super and subclasses), conversions may be repeated instead of cached.
    static var uniqueTypeIdentifier: String { get }

    // [_Define Documentation: SDGCornerstone.DateDefinition.referenceDate_]
    /// The reference date for the type.
    static var referenceDate: CalendarDate { get }

    // MARK: - Initialization

    // [_Define Documentation: SDGCornerstone.DateDefinition.init(intervalSinceReferenceDate:)_]
    /// Creates a date from an interval since the reference date.
    init(intervalSinceReferenceDate: CalendarInterval<FloatMax>)

    // MARK: - Properties

    // [_Define Documentation: SDGCornerstone.DateDefinition.intervalSinceReferenceDate_]
    /// The interval since the reference date.
    var intervalSinceReferenceDate: CalendarInterval<FloatMax> { get }
}

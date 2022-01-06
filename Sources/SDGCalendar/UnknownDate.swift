/*
 UnknownDate.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGText
import SDGLocalization

import SDGCornerstoneLocalizations

internal struct UnknownDate: DateDefinition {

  // MARK: - Initialization

  internal init(
    encodingIdentifier: StrictString,
    encodedDefinition: StrictString,
    lastCalculatedInstant: CalendarInterval<FloatMax>
  ) {
    self.encodingIdentifier = encodingIdentifier
    self.encodedDefinition = encodedDefinition
    self.lastCalculatedInstant = lastCalculatedInstant
  }

  // MARK: - Properties

  internal let encodingIdentifier: StrictString
  internal let encodedDefinition: StrictString
  internal let lastCalculatedInstant: CalendarInterval<FloatMax>

  // MARK: - DateDefinition

  internal static let identifier: StrictString = "?"
  internal static let referenceDate: CalendarDate = CalendarDate.epoch

  internal var intervalSinceReferenceDate: CalendarInterval<FloatMax> {
    return lastCalculatedInstant
  }

  internal init(intervalSinceReferenceDate: CalendarInterval<FloatMax>) {
    unreachable()  // This definition is never converted to.
  }

  // MARK: - Decodable

  internal init(from decoder: Decoder) throws {
    unreachable()  // This definition is never encoded.
  }

  // MARK: - Encodable

  internal func encode(to encoder: Encoder) throws {
    unreachable()  // This definition is never encoded.
  }
}

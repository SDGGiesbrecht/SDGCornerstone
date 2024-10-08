/*
 HebrewYearLength.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2024 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGText
import SDGLocalization

import SDGCornerstoneLocalizations

extension HebrewYear {

  /// The length of a Hebrew year.
  public enum Length: CaseIterable {

    // MARK: - Static Properties

    /// The minimum number of days in a year.
    public static let minimumNumberOfDays: Int = 353
    /// The maximum number of days in a year.
    public static let maximumNumberOfDays: Int = 385

    // MARK: - Cases

    /// A deficient year.
    case deficient
    /// A normal year.
    case normal
    /// A whole year.
    case whole

    // MARK: - Initialization

    /// Creates a length from a number of days.
    ///
    /// - Precondition: The number of days is valid.
    ///
    /// - Parameters:
    ///   - numberOfDays: The number of days in the year.
    public init(numberOfDays: Int) {
      let min = HebrewYear.Length.minimumNumberOfDays
      let max = HebrewYear.Length.maximumNumberOfDays
      switch numberOfDays {

      case min /* 353 */, 383:
        self = .deficient
      case 354, 384:
        self = .normal
      case 355, max /* 385 */:
        self = .whole
      default:
        preconditionFailure(
          UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:  // @exempt(from: tests)
              return "\(numberOfDays.inDigits()) is an invalid number of days for a Hebrew year."
            }
          })
        )
      }
    }
  }
}

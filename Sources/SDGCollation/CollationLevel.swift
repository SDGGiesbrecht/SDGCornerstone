/*
 CollationLevel.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

internal enum CollationLevel: Int, OrderedEnumeration {

    // MARK: - Cases

    case primary
    case accentsInReverse
    case accentsForward
    case `case`
    case punctuation
    case script

    // MARK: - Properties

    internal var isInReverse: Bool {
        switch self {
        case .primary, .accentsForward, .case, .punctuation, .script:
            return false
        case .accentsInReverse:
            return true
        }
    }
}

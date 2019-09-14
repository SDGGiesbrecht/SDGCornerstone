/*
 LocalizationSetting.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@testable import SDGLocalization

extension LocalizationSetting {

    internal func clearStabilizationCache<L>(for: L.Type) {
        resetStabilization(for: L.self)
    }
}

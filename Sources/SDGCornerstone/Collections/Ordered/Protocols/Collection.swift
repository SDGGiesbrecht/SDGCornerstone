/*
 Collection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic
import SDGCollections

import SDGCornerstoneLocalizations

extension Collection {

    internal func assertIndexExists(_ index: Index) {
        assert(index ∈ bounds, UserFacingText({ (localization: APILocalization) in
            switch localization {
            case .englishCanada: // [_Exempt from Test Coverage_]
                return "Index out of bounds."
            }
        }))
    }
}

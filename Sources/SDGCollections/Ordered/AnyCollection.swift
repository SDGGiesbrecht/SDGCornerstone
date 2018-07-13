/*
 AnyCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension AnyCollection : SearchableCollection where Element : Equatable {
    // MARK: - where Element : Equatable
}
extension AnyBidirectionalCollection : SearchableBidirectionalCollection, SearchableCollection where Element : Equatable {
    // MARK: - where Element : Equatable
}
extension AnyRandomAccessCollection : SearchableBidirectionalCollection, SearchableCollection where Element : Equatable {
    // MARK: - where Element : Equatable
}

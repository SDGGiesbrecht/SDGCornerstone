/*
 ReversedCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension ReversedCollection : SearchableCollection where Base : SearchableCollection {
    // MARK: - where Base : SearchableCollection
}
extension ReversedCollection : SearchableBidirectionalCollection where Base : SearchableBidirectionalCollection {
    // MARK: - where Base : SearchableCollection
}

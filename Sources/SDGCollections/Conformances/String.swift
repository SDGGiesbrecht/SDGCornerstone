/*
 String.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#warning("Temporary.")
typealias SearchableBidirectionalCollection = SearchableCollection

extension String: SearchableBidirectionalCollection {}
extension String.UnicodeScalarView: SearchableBidirectionalCollection {}
extension String.UTF8View: SearchableBidirectionalCollection {}
extension String.UTF16View: SearchableBidirectionalCollection {}
extension Substring: SearchableBidirectionalCollection {}
extension Substring.UnicodeScalarView: SearchableBidirectionalCollection {}
extension Substring.UTF8View: SearchableBidirectionalCollection {}
extension Substring.UTF16View: SearchableBidirectionalCollection {}

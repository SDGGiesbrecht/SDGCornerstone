/*
 Int.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

/// A member of the `Int` family: `Int`, `Int64`, `Int32`, `Int16` or `Int8`.
public protocol IntFamily : IntFamilyCore, IntegerProtocol {

}

extension Int : IntFamily {}

extension Int64 : IntFamily {}
extension Int32 : IntFamily {}
extension Int16 : IntFamily {}
extension Int8 : IntFamily {}

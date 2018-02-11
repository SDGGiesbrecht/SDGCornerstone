/*
 Float.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematicsCore

/// A member of the `Float` family: `Double`, `Float80` or `Float`
public protocol FloatFamily : FloatFamilyCore, RealNumberProtocol {

}

extension Double : FloatFamily, PropertyListValue {

}

#if !os(Linux)
    // MARK: - #if !os(Linux)

    extension CGFloat : FloatFamily, PropertyListValue {

    }
#endif

#if !(os(iOS) || os(watchOS) || os(tvOS))
    // MARK: - #if !(os(iOS) || os(watchOS) || os(tvOS))

    extension Float80 : FloatFamily {

    }
#endif

extension Float : FloatFamily, PropertyListValue {

}

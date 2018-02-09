/*
 FloatingPointPrecision.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone

func ≈ <T : Subtractable>(precedingValue: T, followingValue: T) -> Bool where T : Comparable, T : ExpressibleByFloatLiteral {
    return precedingValue ≈ followingValue ± 0.000_01
}

func πLiteral<T>() -> T where T : ExpressibleByFloatLiteral {
    return 3.141_59
}

func τLiteral<T>() -> T where T : ExpressibleByFloatLiteral {
    return 6.283_18
}

func eLiteral<T>() -> T where T : ExpressibleByFloatLiteral {
    return 2.718_28
}

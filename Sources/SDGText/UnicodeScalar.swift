/*
 UnicodeScalar.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic
import SDGMathematics
import SDGCollections

extension Unicode {
    // @localization(🇩🇪DE) @notLocalized(🇨🇦EN)
    /// Ein Unicode‐Skalarwert. (`Scalar`)
    public typealias Skalar = Scalar
}

extension Unicode.Scalar {

    /// `true` if the scalar is decomposable in NFKD, otherwise `false`.
    public var isDecomposableInNFKD: Bool {
        return ¬StrictString(self).elementsEqual([self])
    }

    /// The hexadecimal code for the character.
    public var hexadecimalCode: String {
        var result = String(value, radix: 16, uppercase: true)
        result.scalars.fill(to: 4, with: "0", from: .start)
        return result
    }

    /// Returns a visible representation for the character.
    ///
    /// Characters are represented in one of four ways:
    ///
    /// - Visible characters remain unchanged.
    /// - Combining characters are applied to a dotted circle.
    /// - Invisible characters are represented by their acronyms from the [Unicode code charts](http://www.unicode.org/charts/) in brackets.
    /// - Private use or unassigned code points are represented by their hexadecimal codes in brackets.
    public var visibleRepresentation: String {

        func control(acronym: String) -> String {
            return "[\(acronym)]"
        }

        // Controls (Cc, Cf), Separators (Zs, Zl, Zp) & Some Non‐Spacing Marks (Mn)
        switch self {

        // C0 Controls & Basic Latin
        case "\u{0}":
            return control(acronym: "NUL")
        case "\u{1}":
            return control(acronym: "SOH")
        case "\u{2}":
            return control(acronym: "STX")
        case "\u{3}":
            return control(acronym: "ETX")
        case "\u{4}":
            return control(acronym: "EOT")
        case "\u{5}":
            return control(acronym: "ENQ")
        case "\u{6}":
            return control(acronym: "ACK")
        case "\u{7}":
            return control(acronym: "BEL")
        case "\u{8}":
            return control(acronym: "BS")
        case "\u{9}":
            return control(acronym: "HT")
        case "\u{A}":
            return control(acronym: "LF")
        case "\u{B}":
            return control(acronym: "VT")
        case "\u{C}":
            return control(acronym: "FF")
        case "\u{D}":
            return control(acronym: "CR")
        case "\u{E}":
            return control(acronym: "SO")
        case "\u{F}":
            return control(acronym: "SI")
        case "\u{10}":
            return control(acronym: "DLE")
        case "\u{11}":
            return control(acronym: "DC1")
        case "\u{12}":
            return control(acronym: "DC2")
        case "\u{13}":
            return control(acronym: "DC3")
        case "\u{14}":
            return control(acronym: "DC4")
        case "\u{15}":
            return control(acronym: "NAK")
        case "\u{16}":
            return control(acronym: "SYN")
        case "\u{17}":
            return control(acronym: "ETB")
        case "\u{18}":
            return control(acronym: "CAN")
        case "\u{19}":
            return control(acronym: "EM")
        case "\u{1A}":
            return control(acronym: "SUB")
        case "\u{1B}":
            return control(acronym: "ESC")
        case "\u{1C}":
            return control(acronym: "FS")
        case "\u{1D}":
            return control(acronym: "GS")
        case "\u{1E}":
            return control(acronym: "RS")
        case "\u{1F}":
            return control(acronym: "US")
        case "\u{20}":
            return control(acronym: "SP")
        case "\u{7F}":
            return control(acronym: "DEL")

        // C1 Controls & Latin‐1 Supplement
        case "\u{80}":
            return control(acronym: "XXX")
        case "\u{81}":
            return control(acronym: "XXX")
        case "\u{82}":
            return control(acronym: "BPH")
        case "\u{83}":
            return control(acronym: "NBH")
        case "\u{84}":
            return control(acronym: "IND")
        case "\u{85}":
            return control(acronym: "NEL")
        case "\u{86}":
            return control(acronym: "SSA")
        case "\u{87}":
            return control(acronym: "ESA")
        case "\u{88}":
            return control(acronym: "HTS")
        case "\u{89}":
            return control(acronym: "HTJ")
        case "\u{8A}":
            return control(acronym: "VTS")
        case "\u{8B}":
            return control(acronym: "PLD")
        case "\u{8C}":
            return control(acronym: "PLU")
        case "\u{8D}":
            return control(acronym: "RI")
        case "\u{8E}":
            return control(acronym: "SS2")
        case "\u{8F}":
            return control(acronym: "SS3")
        case "\u{90}":
            return control(acronym: "DCS")
        case "\u{91}":
            return control(acronym: "PU1")
        case "\u{92}":
            return control(acronym: "PU2")
        case "\u{93}":
            return control(acronym: "STS")
        case "\u{94}":
            return control(acronym: "CCH")
        case "\u{95}":
            return control(acronym: "MW")
        case "\u{96}":
            return control(acronym: "SPA")
        case "\u{97}":
            return control(acronym: "EPA")
        case "\u{98}":
            return control(acronym: "SOS")
        case "\u{99}":
            return control(acronym: "XXX")
        case "\u{9A}":
            return control(acronym: "SCI")
        case "\u{9B}":
            return control(acronym: "CSI")
        case "\u{9C}":
            return control(acronym: "ST")
        case "\u{9D}":
            return control(acronym: "OSC")
        case "\u{9E}":
            return control(acronym: "PM")
        case "\u{9F}":
            return control(acronym: "APC")
        case "\u{A0}":
            return control(acronym: "NBSP")
        case "\u{AD}":
            return control(acronym: "SHY‐")

        // Combining Diacritical Marks
        case "\u{34F}":
            return control(acronym: "◌CGJ")

        // Arabic
        case "\u{600}" ... "\u{605}":
            return control(acronym: String(self))
        case "\u{61C}":
            return control(acronym: "ALM")
        case "\u{6DD}":
            return control(acronym: String(self))

        // Syriac
        case "\u{70F}":
            return control(acronym: String(self) + "SAM")

        // Arabic Extended‐A
        case "\u{8E2}":
            return control(acronym: String(self))

        // Ogham
        case "\u{1680}":
            return control(acronym: "─")

        // Mongolian
        case "\u{180B}":
            return control(acronym: "FVS1")
        case "\u{180C}":
            return control(acronym: "FVS2")
        case "\u{180D}":
            return control(acronym: "FVS3")
        case "\u{180E}":
            return control(acronym: "MVS")

        // General Punctuation
        case "\u{2000}":
            return control(acronym: "NQSP")
        case "\u{2001}":
            return control(acronym: "MQSP")
        case "\u{2002}":
            return control(acronym: "ENSP")
        case "\u{2003}":
            return control(acronym: "EMSP")
        case "\u{2004}":
            return control(acronym: "3/MSP")
        case "\u{2005}":
            return control(acronym: "4/MSP")
        case "\u{2006}":
            return control(acronym: "6/MSP")
        case "\u{2007}":
            return control(acronym: "FSP")
        case "\u{2008}":
            return control(acronym: "PSP")
        case "\u{2009}":
            return control(acronym: "THSP")
        case "\u{200A}":
            return control(acronym: "HSP")
        case "\u{200B}":
            return control(acronym: "ZWSP")
        case "\u{200C}":
            return control(acronym: "ZWNJ")
        case "\u{200D}":
            return control(acronym: "ZWJ")
        case "\u{200E}":
            return control(acronym: "LRM")
        case "\u{200F}":
            return control(acronym: "RLM")
        case "\u{2011}":
            return control(acronym: "NB‐")
        case "\u{2028}":
            return control(acronym: "LSEP")
        case "\u{2029}":
            return control(acronym: "PSEP")
        case "\u{202A}":
            return control(acronym: "LRE")
        case "\u{202B}":
            return control(acronym: "RLE")
        case "\u{202C}":
            return control(acronym: "PDF")
        case "\u{202D}":
            return control(acronym: "LRO")
        case "\u{202E}":
            return control(acronym: "RLO")
        case "\u{202F}":
            return control(acronym: "NNBSP")
        case "\u{205F}":
            return control(acronym: "MMSP")
        case "\u{2060}":
            return control(acronym: "WJ")
        case "\u{2061}":
            return control(acronym: "f()")
        case "\u{2062}":
            return control(acronym: "×")
        case "\u{2063}":
            return control(acronym: ",")
        case "\u{2064}":
            return control(acronym: "+")
        case "\u{2066}":
            return control(acronym: "LRI")
        case "\u{2067}":
            return control(acronym: "RLI")
        case "\u{2068}":
            return control(acronym: "FSI")
        case "\u{2069}":
            return control(acronym: "PDI")
        case "\u{206A}":
            return control(acronym: "ISS")
        case "\u{206B}":
            return control(acronym: "ASS")
        case "\u{206C}":
            return control(acronym: "IAFS")
        case "\u{206D}":
            return control(acronym: "AAFS")
        case "\u{206E}":
            return control(acronym: "NADS")
        case "\u{206F}":
            return control(acronym: "NODS")

        // CJK Symbols & Punctuation
        case "\u{3000}":
            return control(acronym: "IDSP")

        // Variation Selectors
        case "\u{FE00}" ... "\u{FE0F}":
            let baseCode = self.value − 0xFE00 + UInt32(1)
            return control(acronym: "VS" + "\(baseCode)")

        // Arabic Presentation Forms‐B
        case "\u{FEFF}":
            return control(acronym: "ZWNBSP")

        // Specials
        case "\u{FFF9}":
            return control(acronym: "IAA")
        case "\u{FFFA}":
            return control(acronym: "IAS")
        case "\u{FFFB}":
            return control(acronym: "IAT")
        case "\u{FFFC}":
            return control(acronym: "OBJ")

        // Kaithi
        case "\u{110BD}":
            return control(acronym: String(self))

        // Shorthand Format Controls
        case "\u{1BCA0}":
            return control(acronym: "⇸")
        case "\u{1BCA1}":
            return control(acronym: "↳")
        case "\u{1BCA2}":
            return control(acronym: "↑")
        case "\u{1BCA3}":
            return control(acronym: "↓")

        // Musical Symbols
        case "\u{1D159}":
            return control(acronym: "NULL NOTE HEAD")
        case "\u{1D173}":
            return control(acronym: "BEGIN BEAM")
        case "\u{1D174}":
            return control(acronym: "END BEAM")
        case "\u{1D175}":
            return control(acronym: "BEGIN TIE")
        case "\u{1D176}":
            return control(acronym: "END TIE")
        case "\u{1D177}":
            return control(acronym: "BEGIN SLUR")
        case "\u{1D178}":
            return control(acronym: "END SLUR")
        case "\u{1D179}":
            return control(acronym: "BEGIN PHR.")
        case "\u{1D17A}":
            return control(acronym: "END PHR.")

        case "\u{E0001}":
            return control(acronym: "BEGIN🏷")
        case "\u{E0020}":
            return control(acronym: "SP🏷")
        case "\u{E0020}" ..< "\u{E007E}":
            return control(acronym: String(UnicodeScalar(value − 0xE0000)!) + "🏷")
        case "\u{E007F}":
            return control(acronym: "END🏷")

        default:

            // Marks (Mn, Mc, Me)
            if self ∈ CharacterSet.nonBaseCharacters {
                return "◌" + String(self)

                // Letters (Lu, Ll, Lt, Lm, Lo), Numbers (Nd, Nl, No), Punctuation (Pc, Pd, Ps, Pe, Pi, Pf, Po) & Symbols (Sm, Sc, Sk, So)
            } else if self ∈ (CharacterSet.alphanumerics ∪ CharacterSet.punctuationCharacters) ∪ CharacterSet.symbols {
                return String(self)

                // Private Use (Co), Surrogate (Cs) & Unassigned (Cn)
            } else {
                return control(acronym: hexadecimalCode)
            }
        }
    }
}

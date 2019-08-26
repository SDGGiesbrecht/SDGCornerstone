/*
 State.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGText

// Internal so that adding and removing cases is not source‐breaking.
internal enum State : String, CaseIterable {

    // MARK: - Cases

    case 中国 = "CN"
    case 中國 = "TW"

    case españa = "ES"
    case méxico = "MX"
    case colombia = "CO"
    case argentina = "AR"
    case venezuela = "VE"
    case perú = "PE"
    case chile = "CL"
    case ecuador = "EC"
    case cuba = "CU"
    case repúblicaDominicana = "DO"
    case guatamala = "GT"
    case honduras = "HN"
    case salvador = "SV"
    case nicaragua = "NI"
    case bolivia = "BO"
    case costaRica = "CR"
    case uruguay = "UY"
    case panamá = "PA"
    case paraguay = "PY"
    case guineaEcuatorial = "GQ"

    case unitedKingdom = "GB"
    case unitedStates = "US"
    case canada = "CA"
    case australia = "AU"
    case southAfrica = "ZA"
    case ireland = "IE"
    case newZealand = "NZ"
    case trinidadAndTobago = "TT"
    case guyana = "GY"
    case liberia = "LR"
    case sierraLeone = "SL"
    case barbados = "BB"
    case bahamas = "BS"
    case zimbabwe = "ZW"
    case belize = "BZ"
    case papuaNewGuinea = "PG"
    case saintVincentAndGrenadines = "VC"
    case zambia = "ZM"
    case grenada = "GD"
    case antiguaAndBarbuda = "AG"
    case jamaica = "JM"
    case saintKittsAndNevis = "KN"
    case sriLanka = "LK"
    case philippines = "PH"
    case saintLucia = "LC"
    case namibia = "NA"
    case solomonIslands = "SB"
    case nauru = "NR"
    case fiji = "FJ"
    case micronesia = "FM"
    case dominica = "DM"
    case samoa = "WS"
    case palau = "PW"
    case malawi = "MW"
    case botswana = "BW"
    case ethiopia = "ET"
    case gambia = "GM"
    case ghana = "GH"
    case kenya = "KE"
    case kiribati = "KI"
    case lesotho = "LS"
    case malta = "MT"
    case marshallIslands = "MH"
    case nigeria = "NG"
    case pakistan = "PK"
    case rwanda = "RW"
    case southSudan = "SS"
    case swaziland = "SZ"
    case tanzania = "TZ"
    case tongo = "TO"
    case tuvalu = "TV"
    case uganda = "UG"

    case السعودية = "SA"
    case مصر = "EG"
    case الجزائر = "DZ"
    case السودان = "SD"
    case المغرب = "MA"
    case العراق = "IQ"
    case سوريا = "SY"
    case اليمن = "YE"
    case تونس = "TN"
    case الأردن = "JO"
    case ليبيا = "LY"
    case لبنان = "LB"
    case الصومال = "SO"
    case الإمارات_العربية_المتحدة = "AE"
    case موريتانيا = "MR"
    case عمان = "OM"
    case الكويت = "KW"
    case تشاد = "TD"
    case قطر = "QA"
    case البحرين = "BH"
    case جيبوتي = "DJ"
    case جزر_القمر = "KM"

    case भारत = "IN"

    case portugal = "PT"
    case brasil = "BR"
    case angola = "AO"
    case moçambique = "MZ"
    case sãoToméEPríncipe = "ST"
    case timorLeste = "TL"
    case caboVerde = "CV"
    case guinéBissau = "GW"

    case россия = "RU"
    case беларусь = "BY"
    case казахстан = "KZ"
    case киргизия = "KG"

    case 日本国 = "JP"

    case deutschland = "DE"
    case österreich = "AT"
    case schweiz = "CH"
    case liechtenstein = "LI"
    case luxemburg = "LU"

    case việtNam = "VN"

    case 한국 = "KR"
    case 조선 = "KP"

    case france = "FR"
    case burkinaFaso = "BF"
    case sénégal = "SN"
    case maurice = "MU"
    case gabon = "GA"
    case congoBrazzaville = "CG"
    case madagascar = "MG"
    case côteDIvoire = "CI"
    case bénin = "BJ"
    case monaco = "MC"
    case centrafrique = "CF"
    case mali = "ML"
    case niger = "NE"
    case togo = "TG"
    case burundi = "BI"
    case vanuatu = "VU"
    case seychelles = "SC"
    case cameroun = "CM"
    case congoKinshasa = "CD"
    case guinée = "GN"
    case haïti = "HT"

    case türkiye = "TR"

    case italia = "IT"
    case sanMarino = "SM"
    case cittàDiVaticano = "VA"

    case polska = "PL"

    case україна = "UA"

    case nederland = "NL"
    case belgië = "BE"
    case suriname = "SR"

    case malaysia = "MY"
    case singapura = "SG"
    case brunei = "BN"

    case românia = "RO"
    case moldova = "MD"

    case ไทย = "TH"

    case ελλάδα = "GR"
    case κύπρης = "CY"

    case česko = "CZ"

    case magyarország = "HU"

    case sverige = "SE"

    case indonesia = "ID"

    case danmark = "DK"

    case suomi = "FI"

    case slovensko = "SK"

    case ישראל = "IL"

    case norge = "NO"

    case hrvatska = "HR"

    case andorra = "AD"

    // MARK: - Initialization

    internal init?(code: String) {
        self.init(rawValue: code)
    }

    internal init?(flag: StrictString) {
        self.init(code: String(String.ScalarView(flag.scalars.map({
            if $0.value > State.flagOffset {
                return UnicodeScalar($0.value − State.flagOffset)!
            } else {
                return UnicodeScalar(0)
            }
        })))) // @exempt(from: tests) Meaningless region.
    }

    // MARK: - Properties

    internal var code: String {
        return rawValue
    }

    private static let flagOffset: UInt32 = 0x1F1A5
    internal var flag: StrictString {
        return StrictString(code.scalars.map({ UnicodeScalar($0.value + State.flagOffset)! }))
    }

    // MARK: - Description

    internal func localizedIsolatedName() -> UserFacing<StrictString, _InterfaceLocalization> {
        return UserFacing<StrictString, _InterfaceLocalization>({ localization in
            switch self {
            case .中国:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "China‐Beijing"
                case .deutschDeutschland:
                    return "China‐Peking"
                }
            case .中國:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "China‐Taipei"
                case .deutschDeutschland:
                    return "China‐Taipeh"
                }

            case .españa:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Spain"
                case .deutschDeutschland:
                    return "Spanien"
                }
            case .méxico:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Mexico"
                case .deutschDeutschland:
                    return "Mexiko"
                }
            case .colombia:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Colombia"
                case .deutschDeutschland:
                    return "Kolumbien"
                }
            case .argentina:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Argentina"
                case .deutschDeutschland:
                    return "Argentinien"
                }
            case .venezuela:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Venezuela"
                }
            case .perú:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada
                    ,.deutschDeutschland:
                    return "Peru"
                }
            case .chile:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Chile"
                }
            case .ecuador:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Ecuador"
                }
            case .cuba:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Cuba"
                case .deutschDeutschland:
                    return "Kuba"
                }
            case .repúblicaDominicana:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Dominican Republic"
                case .deutschDeutschland:
                    return "Dominikanische Republik"
                }
            case .guatamala:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Guatemala"
                }
            case .honduras:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Honduras"
                }
            case .salvador:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "El Salvador"
                }
            case .nicaragua:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Nicaragua"
                }
            case .bolivia:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Bolivia"
                case .deutschDeutschland:
                    return "Bolivien"
                }
            case .costaRica:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Costa Rica"
                }
            case .uruguay:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Uruguay"
                }
            case .panamá:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Panama"
                }
            case .paraguay:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Paraguay"
                }
            case .guineaEcuatorial:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Equatorial Guinea"
                case .deutschDeutschland:
                    return "Äquatorialguinea"
                }

            case .unitedKingdom:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "United Kingdom"
                case .deutschDeutschland:
                    return "Vereinigtes Königreich"
                }
            case .unitedStates:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "United States"
                case .deutschDeutschland:
                    return "Vereinigte Staaten"
                }
            case .canada:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Canada"
                case .deutschDeutschland:
                    return "Kanada"
                }
            case .australia:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Australia"
                case .deutschDeutschland:
                    return "Australien"
                }
            case .southAfrica:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "South Africa"
                case .deutschDeutschland:
                    return "Südafrika"
                }
            case .ireland:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Ireland"
                case .deutschDeutschland:
                    return "Irland"
                }
            case .newZealand:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "New Zealand"
                case .deutschDeutschland:
                    return "Neuseeland"
                }
            case .trinidadAndTobago:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Trinidad & Tobago"
                case .deutschDeutschland:
                    return "Trinidad und Tobago"
                }
            case .guyana:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Guyana"
                }
            case .liberia:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Liberia"
                }
            case .sierraLeone:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Sierra Leone"
                }
            case .barbados:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Barbados"
                }
            case .bahamas:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Bahamas"
                }
            case .zimbabwe:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Zimbabwe"
                case .deutschDeutschland:
                    return "Simbabwe"
                }
            case .belize:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Belize"
                }
            case .papuaNewGuinea:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Papua New Guinea"
                case .deutschDeutschland:
                    return "Papua‐Neuguinea"
                }
            case .saintVincentAndGrenadines:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Saint Vincent & the Grenadines"
                case .deutschDeutschland:
                    return "Sankt Vincent und die Grenadinen"
                }
            case .zambia:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Zambia"
                case .deutschDeutschland:
                    return "Sambia"
                }
            case .grenada:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Grenada"
                }
            case .antiguaAndBarbuda:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Antigua & Barbuda"
                case .deutschDeutschland:
                    return "Antigua und Barbuda"
                }
            case .jamaica:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Jamaica"
                case .deutschDeutschland:
                    return "Jamaika"
                }
            case .saintKittsAndNevis:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Saint Kitts & Nevis"
                case .deutschDeutschland:
                    return "Sankt Kitts und Nevis"
                }
            case .sriLanka:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Sri Lanka"
                }
            case .philippines:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Philippines"
                case .deutschDeutschland:
                    return "Philippinen"
                }
            case .saintLucia:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Saint Lucia"
                case .deutschDeutschland:
                    return "Sankt Lucia"
                }
            case .namibia:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Namibia"
                }
            case .solomonIslands:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Solomon Islands"
                case .deutschDeutschland:
                    return "Salomonen"
                }
            case .nauru:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Nauru"
                }
            case .fiji:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Fiji"
                case .deutschDeutschland:
                    return "Fidschi"
                }
            case .micronesia:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Micronesia"
                case .deutschDeutschland:
                    return "Mikronesien"
                }
            case .dominica:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Dominica"
                }
            case .samoa:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Samoa"
                }
            case .palau:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Palau"
                }
            case .malawi:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Malawi"
                }
            case .botswana:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Botswana"
                case .deutschDeutschland:
                    return "Botsuana"
                }
            case .ethiopia:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Ethiopia"
                case .deutschDeutschland:
                    return "Äthiopien"
                }
            case .gambia:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Gambia"
                }
            case .ghana:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Ghana"
                }
            case .kenya:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Kenya"
                case .deutschDeutschland:
                    return "Kenia"
                }
            case .kiribati:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Kiribati"
                }
            case .lesotho:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Lesotho"
                }
            case .malta:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Malta"
                }
            case .marshallIslands:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Marshall Islands"
                case .deutschDeutschland:
                    return "Marshallinseln"
                }
            case .nigeria:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Nigeria"
                }
            case .pakistan:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Pakistan"
                }
            case .rwanda:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Rwanda"
                case .deutschDeutschland:
                    return "Ruanda"
                }
            case .southSudan:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "South Sudan"
                case .deutschDeutschland:
                    return "Südsudan"
                }
            case .swaziland:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Swaziland"
                case .deutschDeutschland:
                    return "Swasiland"
                }
            case .tanzania:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Tanzania"
                case .deutschDeutschland:
                    return "Tansania"
                }
            case .tongo:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Tonga"
                }
            case .tuvalu:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Tuvalu"
                }
            case .uganda:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Uganda"
                }

            case .السعودية:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Saudi Arabia"
                case .deutschDeutschland:
                    return "Saudi‐Arabien"
                }
            case .مصر:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Egypt"
                case .deutschDeutschland:
                    return "Ägypten"
                }
            case .الجزائر:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Algeria"
                case .deutschDeutschland:
                    return "Algerien"
                }
            case .السودان:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Sudan"
                case .deutschDeutschland:
                    return "Sudan"
                }
            case .المغرب:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Morocco"
                case .deutschDeutschland:
                    return "Marokko"
                }
            case .العراق:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Iraq"
                case .deutschDeutschland:
                    return "Irak"
                }
            case .سوريا:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Syria"
                case .deutschDeutschland:
                    return "Syrien"
                }
            case .اليمن:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Yemen"
                case .deutschDeutschland:
                    return "Jemen"
                }
            case .تونس:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Tunisia"
                case .deutschDeutschland:
                    return "Tunesien"
                }
            case .الأردن:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Jordan"
                case .deutschDeutschland:
                    return "Jordanien"
                }
            case .ليبيا:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Libya"
                case .deutschDeutschland:
                    return "Libyen"
                }
            case .لبنان:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Lebanon"
                case .deutschDeutschland:
                    return "Libanon"
                }
            case .الصومال:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Somalia"
                }
            case .الإمارات_العربية_المتحدة:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "United Arab Emirates"
                case .deutschDeutschland:
                    return "Vereinigte Arabische Emirate"
                }
            case .موريتانيا:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Mauritania"
                case .deutschDeutschland:
                    return "Mauretanien"
                }
            case .عمان:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Oman"
                }
            case .الكويت:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Kuwait"
                }
            case .تشاد:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Chad"
                case .deutschDeutschland:
                    return "Tschad"
                }
            case .قطر:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Qatar"
                case .deutschDeutschland:
                    return "Katar"
                }
            case .البحرين:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Bahrain"
                }
            case .جيبوتي:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Djibouti"
                case .deutschDeutschland:
                    return "Dschibuti"
                }
            case .جزر_القمر:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Comoros"
                case .deutschDeutschland:
                    return "Komoren"
                }

            case .भारत:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "India"
                case .deutschDeutschland:
                    return "Indien"
                }

            case .portugal:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Portugal"
                }
            case .brasil:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Brazil"
                case .deutschDeutschland:
                    return "Brasilien"
                }
            case .angola:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Angola"
                }
            case .moçambique:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Mozambique"
                case .deutschDeutschland:
                    return "Mosambik"
                }
            case .sãoToméEPríncipe:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "São Tomé & Príncipe"
                case .deutschDeutschland:
                    return "São Tomé und Príncipe"
                }
            case .timorLeste:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "East Timor"
                case .deutschDeutschland:
                    return "Osttimor"
                }
            case .caboVerde:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Cape Verde"
                case .deutschDeutschland:
                    return "Kap Verde"
                }
            case .guinéBissau:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Guinea‐Bissau"
                }

            case .россия:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Russia"
                case .deutschDeutschland:
                    return "Russland"
                }
            case .беларусь:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Belarus"
                case .deutschDeutschland:
                    return "Weißrussland"
                }
            case .казахстан:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Kazakhstan"
                case .deutschDeutschland:
                    return "Kasachstan"
                }
            case .киргизия:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Kyrgyzstan"
                case .deutschDeutschland:
                    return "Kirgisistan"
                }

            case .日本国:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Japan"
                }

            case .deutschland:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Germany"
                case .deutschDeutschland:
                    return "Deustchland"
                }
            case .österreich:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Austria"
                case .deutschDeutschland:
                    return "Österreich"
                }
            case .schweiz:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Switzerland"
                case .deutschDeutschland:
                    return "Schweiz"
                }
            case .liechtenstein:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Liechtenstein"
                }
            case .luxemburg:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Luxembourg"
                case .deutschDeutschland:
                    return "Luxemburg"
                }

            case .việtNam:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Vietnam"
                }

            case .한국:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "South Korea"
                case .deutschDeutschland:
                    return "Südkorea"
                }
            case .조선:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "North Korea"
                case .deutschDeutschland:
                    return "Nordkorea"
                }

            case .france:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "France"
                case .deutschDeutschland:
                    return "Frankreich"
                }
            case .burkinaFaso:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Burkina Faso"
                }
            case .sénégal:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Senegal"
                }
            case .maurice:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Mauritius"
                }
            case .gabon:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Gabon"
                case .deutschDeutschland:
                    return "Gabun"
                }
            case .congoBrazzaville:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Congo‐Brazzaville"
                case .deutschDeutschland:
                    return "Kongo‐Brazzaville"
                }
            case .madagascar:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Madagascar"
                case .deutschDeutschland:
                    return "Madagaskar"
                }
            case .côteDIvoire:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Ivory Coast"
                case .deutschDeutschland:
                    return "Elfenbeinküste"
                }
            case .bénin:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Benin"
                }
            case .monaco:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Monaco"
                }
            case .centrafrique:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Central African Republic"
                case .deutschDeutschland:
                    return "Zentralafrikanische Republik"
                }
            case .mali:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Mali"
                case .deutschDeutschland:
                    return "Mali"
                }
            case .niger:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Niger"
                }
            case .togo:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Togo"
                }
            case .burundi:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Burundi"
                }
            case .vanuatu:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Vanuatu"
                }
            case .seychelles:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Seychelles"
                case .deutschDeutschland:
                    return "Seychellen"
                }
            case .cameroun:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Cameroon"
                case .deutschDeutschland:
                    return "Kamerun"
                }
            case .congoKinshasa:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Congo‐Kinshasa"
                case .deutschDeutschland:
                    return "Kongo‐Kinshasa"
                }
            case .guinée:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Guinea"
                }
            case .haïti:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Haiti"
                }

            case .türkiye:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Turkey"
                case .deutschDeutschland:
                    return "Türkei"
                }

            case .italia:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Italy"
                case .deutschDeutschland:
                    return "Italien"
                }
            case .sanMarino:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "San Marino"
                }
            case .cittàDiVaticano:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Vatican City"
                case .deutschDeutschland:
                    return "Vatikanstadt"
                }

            case .polska:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Poland"
                case .deutschDeutschland:
                    return "Polen"
                }

            case .україна:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Ukraine"
                }

            case .nederland:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Netherlands"
                case .deutschDeutschland:
                    return "Niederlande"
                }
            case .belgië:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Belgium"
                case .deutschDeutschland:
                    return "Belgien"
                }
            case .suriname:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Suriname"
                }

            case .malaysia:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Malaysia"
                }
            case .singapura:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Singapore"
                case .deutschDeutschland:
                    return "Singapur"
                }
            case .brunei:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Brunei"
                }

            case .românia:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Romania"
                case .deutschDeutschland:
                    return "Rumänien"
                }
            case .moldova:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Moldova"
                case .deutschDeutschland:
                    return "Moldawien"
                }

            case .ไทย:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Thailand"
                }

            case .ελλάδα:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Greece"
                case .deutschDeutschland:
                    return "Griechenland"
                }
            case .κύπρης:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Cyprus"
                case .deutschDeutschland:
                    return "Zypern"
                }

            case .česko:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Czechia"
                case .deutschDeutschland:
                    return "Tschechien"
                }

            case .magyarország:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Hungary"
                case .deutschDeutschland:
                    return "Ungarn"
                }

            case .sverige:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Sweden"
                case .deutschDeutschland:
                    return "Schweden"
                }

            case .indonesia:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Indonesia"
                case .deutschDeutschland:
                    return "Indonesien"
                }

            case .danmark:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Denmark"
                case .deutschDeutschland:
                    return "Dänemark"
                }

            case .suomi:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Finland"
                case .deutschDeutschland:
                    return "Finnland"
                }

            case .slovensko:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Slovakia"
                case .deutschDeutschland:
                    return "Slowakei"
                }

            case .ישראל:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Israel"
                }

            case .norge:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Norway"
                case .deutschDeutschland:
                    return "Norwegen"
                }

            case .hrvatska:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Croatia"
                case .deutschDeutschland:
                    return "Kroatien"
                }

            case .andorra:
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                     .deutschDeutschland:
                    return "Andorra"
                }
            }
        })
    }
}

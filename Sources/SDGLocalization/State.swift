
import SDGMathematics
import SDGText

internal enum State : String {

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

    // MARK: - Description

    private static let flagOffset: UInt32 = 0x1F1A5
    internal var flag: StrictString {
        return StrictString(rawValue.scalars.map({ UnicodeScalar($0.value + State.flagOffset)! }))
    }

    internal init?(flag: StrictString) {
        self.init(rawValue: String(String.ScalarView(flag.scalars.map({
            if $0.value > State.flagOffset {
                return UnicodeScalar($0.value − State.flagOffset)!
            } else {
                return UnicodeScalar(0)
            }
        }))))
    }

    func isolatedEnglishName() -> StrictString {
        switch self {
        case .中国:
            return "China‐Beijing"
        case .中國:
            return "China‐Taipei"

        case .españa:
            return "Spain"
        case .méxico:
            return "Mexico"
        case .colombia:
            return "Colombia"
        case .argentina:
            return "Argentina"
        case .venezuela:
            return "Venezuela"
        case .perú:
            return "Peru"
        case .chile:
            return "Chile"
        case .ecuador:
            return "Ecuador"
        case .cuba:
            return "Cuba"
        case .repúblicaDominicana:
            return "Dominican Republic"
        case .guatamala:
            return "Guatamala"
        case .honduras:
            return "Honduras"
        case .salvador:
            return "El Salvador"
        case .nicaragua:
            return "Nicaragua"
        case .bolivia:
            return "Bolivia"
        case .costaRica:
            return "Costa Rica"
        case .uruguay:
            return "Uruguay"
        case .panamá:
            return "Panama"
        case .paraguay:
            return "Paraguay"
        case .guineaEcuatorial:
            return "Equatorial Guinea"

        case .unitedKingdom:
            return "United Kingdom"
        case .unitedStates:
            return "United States"
        case .canada:
            return "Canada"
        case .australia:
            return "Australia"
        case .southAfrica:
            return "South Africa"
        case .ireland:
            return "Ireland"
        case .newZealand:
            return "New Zealand"
        case .trinidadAndTobago:
            return "Trinidad & Tobago"
        case .guyana:
            return "Guyana"
        case .liberia:
            return "Liberia"
        case .sierraLeone:
            return "Sierra Leone"
        case .barbados:
            return "Barbados"
        case .bahamas:
            return "Bahamas"
        case .zimbabwe:
            return "Zimbabwe"
        case .belize:
            return "Belize"
        case .papuaNewGuinea:
            return "Papua New Guinea"
        case .saintVincentAndGrenadines:
            return "Saint Vincent & the Grenadines"
        case .zambia:
            return "Zambia"
        case .grenada:
            return "Grenada"
        case .antiguaAndBarbuda:
            return "Antigua & Barbuda"
        case .jamaica:
            return "Jamaica"
        case .saintKittsAndNevis:
            return "Saint Kitts & Nevis"
        case .sriLanka:
            return "Sri Lanka"
        case .philippines:
            return "Philippines"
        case .saintLucia:
            return "Saint Lucia"
        case .namibia:
            return "Namibia"
        case .solomonIslands:
            return "Solomon Islands"
        case .nauru:
            return "Nauru"
        case .fiji:
            return "Fiji"
        case .micronesia:
            return "Micronesia"
        case .dominica:
            return "Dominica"
        case .samoa:
            return "Samoa"
        case .palau:
            return "Palau"
        case .malawi:
            return "Malawi"
        case .botswana:
            return "Botswana"
        case .ethiopia:
            return "Ethiopia"
        case .gambia:
            return "Gambia"
        case .ghana:
            return "Ghana"
        case .kenya:
            return "Kenya"
        case .kiribati:
            return "Kiribati"
        case .lesotho:
            return "Lesotho"
        case .malta:
            return "Malta"
        case .marshallIslands:
            return "Marshall Islands"
        case .nigeria:
            return "Nigeria"
        case .pakistan:
            return "Pakistan"
        case .rwanda:
            return "Rwanda"
        case .southSudan:
            return "South Sudan"
        case .swaziland:
            return "Swaziland"
        case .tanzania:
            return "Tanzania"
        case .tongo:
            return "Tongo"
        case .tuvalu:
            return "Tuvalu"
        case .uganda:
            return "Uganda"

        case .السعودية:
            return "Saudi Arabia"
        case .مصر:
            return "Egypt"
        case .الجزائر:
            return "Algeria"
        case .السودان:
            return "Sudan"
        case .المغرب:
            return "Morocco"
        case .العراق:
            return "Iraq"
        case .سوريا:
            return "Syria"
        case .اليمن:
            return "Yemen"
        case .تونس:
            return "Tunisia"
        case .الأردن:
            return "Jordan"
        case .ليبيا:
            return "Libya"
        case .لبنان:
            return "Lebanon"
        case .الصومال:
            return "Somalia"
        case .الإمارات_العربية_المتحدة:
            return "United Arab Emirates"
        case .موريتانيا:
            return "Mauritania"
        case .عمان:
            return "Oman"
        case .الكويت:
            return "Kuwait"
        case .تشاد:
            return "Chad"
        case .قطر:
            return "Qatar"
        case .البحرين:
            return "Bahrain"
        case .جيبوتي:
            return "Djibouti"
        case .جزر_القمر:
            return "Comoros"

        case .भारत:
            return "India"

        case .portugal:
            return "Portugal"
        case .brasil:
            return "Brasil"
        case .angola:
            return "Angola"
        case .moçambique:
            return "Mozambique"
        case .sãoToméEPríncipe:
            return "São Tomé & Príncipe"
        case .timorLeste:
            return "East Timor"
        case .caboVerde:
            return "Cape Verde"
        case .guinéBissau:
            return "Guinea‐Bissau"

        case .россия:
            return "Russia"
        case .беларусь:
            return "Belarus"
        case .казахстан:
            return "Kazakhstan"
        case .киргизия:
            return "Kyrgyzstan"

        case .日本国:
            return "Japan"

        case .deutschland:
            return "Germany"
        case .österreich:
            return "Austria"
        case .schweiz:
            return "Switzerland"
        case .liechtenstein:
            return "Liechtenstein"
        case .luxemburg:
            return "Luxembourg"

        case .việtNam:
            return "Vietnam"

        case .한국:
            return "South Korea"
        case .조선:
            return "North Korea"

        case .france:
            return "France"
        case .burkinaFaso:
            return "Burkina Faso"
        case .sénégal:
            return "Senegal"
        case .maurice:
            return "Mauritius"
        case .gabon:
            return "Gabon"
        case .congoBrazzaville:
            return "Congo‐Brazzaville"
        case .madagascar:
            return "Madagascar"
        case .côteDIvoire:
            return "Ivory Coast"
        case .bénin:
            return "Benin"
        case .monaco:
            return "Monaco"
        case .centrafrique:
            return "Central African Republic"
        case .mali:
            return "Mali"
        case .niger:
            return "Niger"
        case .togo:
            return "togo"
        case .burundi:
            return "Burundi"
        case .vanuatu:
            return "Vanuatu"
        case .seychelles:
            return "Seychelles"
        case .cameroun:
            return "Cameroon"
        case .congoKinshasa:
            return "Congo‐Kinshasa"
        case .guinée:
            return "Guinea"
        case .haïti:
            return "Haiti"

        case .türkiye:
            return "Turkey"

        case .italia:
            return "Italy"
        case .sanMarino:
            return "San Marino"
        case .cittàDiVaticano:
            return "Vatican City"

        case .polska:
            return "Poland"

        case .україна:
            return "Ukraine"

        case .nederland:
            return "Netherlands"
        case .belgië:
            return "Belgium"
        case .suriname:
            return "Suriname"

        case .malaysia:
            return "Malaysia"
        case .singapura:
            return "Singapore"
        case .brunei:
            return "Brunei"

        case .românia:
            return "Romania"
        case .moldova:
            return "Moldova"

        case .ไทย:
            return "Thailand"

        case .ελλάδα:
            return "Greece"
        case .κύπρης:
            return "Cyprus"

        case .česko:
            return "Czechia"

        case .magyarország:
            return "Hungary"

        case .sverige:
            return "Sweden"

        case .indonesia:
            return "Indonesia"

        case .danmark:
            return "Denmark"

        case .suomi:
            return "Finland"

        case .slovensko:
            return "Slovakia"

        case .ישראל:
            return "Israel"

        case .norge:
            return "Norway"

        case .hrvatska:
            return "Croatia"

        case .andorra:
            return "Andorra"
        }
    }

    internal func localizedIsolatedName() -> StrictString {
        return UserFacingText({ (localization: _InterfaceLocalization) in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return self.isolatedEnglishName()
            }
        }).resolved()
    }
}

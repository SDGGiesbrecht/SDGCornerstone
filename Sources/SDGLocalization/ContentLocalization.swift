/*
 ContentLocalization.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

internal enum ContentLocalization : String, Localization {

    // MARK: - Cases

    case 普通话中国 = "cmn\u{2D}Hans\u{2D}CN"
    case 华语新加坡 = "cmn\u{2D}Hans\u{2D}SG"
    case 國語中國 = "cmn\u{2D}Hant\u{2D}TW"

    case españolEspaña = "es\u{2D}ES"
    case españolMéxico = "es\u{2D}MX"
    case españolColombia = "es\u{2D}CO"
    case españolArgentina = "es\u{2D}AR"
    case españolVenezuela = "es\u{2D}VE"
    case españolPerú = "es\u{2D}PE"
    case españolChile = "es\u{2D}CL"
    case españolEcuador = "es\u{2D}EC"
    case españolCuba = "es\u{2D}CU"
    case españolRepúblicaDominicana = "es\u{2D}DO"
    case españolGuatamala = "es\u{2D}GT"
    case españolHonduras = "es\u{2D}HN"
    case españolSalvador = "es\u{2D}SV"
    case españolNicaragua = "es\u{2D}NI"
    case españolBolivia = "es\u{2D}BO"
    case españolCostaRica = "es\u{2D}CR"
    case españolUruguay = "es\u{2D}UY"
    case españolPanamá = "es\u{2D}PA"
    case españolParaguay = "es\u{2D}PY"
    case españolGuineaEcuatorial = "es\u{2D}GQ"

    case englishUnitedKingdom = "en\u{2D}GB"
    case englishUnitedStates = "en\u{2D}US"
    case englishCanada = "en\u{2D}CA"
    case englishAustralia = "en\u{2D}AU"
    case englishSouthAfrica = "en\u{2D}ZA"
    case englishIreland = "en\u{2D}IE"
    case englishNewZealand = "en\u{2D}NZ"
    case englishSingapore = "en\u{2D}SG"
    case englishTrinidadAndTobago = "en\u{2D}TT"
    case englishGuyana = "en\u{2D}GY"
    case englishLiberia = "en\u{2D}LR"
    case englishSierraLeone = "en\u{2D}SL"
    case englishMalaysia = "en\u{2D}MY"
    case englishBarbados = "en\u{2D}BB"
    case englishBahamas = "en\u{2D}BS"
    case englishZimbabwe = "en\u{2D}ZW"
    case englishIndia = "en\u{2D}IN"
    case englishBelize = "en\u{2D}BZ"
    case englishPapuaNewGuinea = "en\u{2D}PG"
    case englishSaintVincentAndGrenadines = "en\u{2D}VC"
    case englishZambia = "en\u{2D}ZM"
    case englishGrenada = "en\u{2D}GD"
    case englishAntiguaAndBarbuda = "en\u{2D}AG"
    case englishVanuatu = "en\u{2D}VU"
    case englishJamaica = "en\u{2D}JM"
    case englishSaintKittsAndNevis = "en\u{2D}KN"
    case englishSriLanka = "en\u{2D}LK"
    case englishPhilippines = "en\u{2D}PH"
    case englishSaintLucia = "en\u{2D}LC"
    case englishNamibia = "en\u{2D}NA"
    case englishBrunei = "en\u{2D}BN"
    case englishSolomonIslands = "en\u{2D}SB"
    case englishNauru = "en\u{2D}NR"
    case englishFiji = "en\u{2D}FJ"
    case englishMicronesia = "en\u{2D}FM"
    case englishDominica = "en\u{2D}DM"
    case englishSeychelles = "en\u{2D}SC"
    case englishMauritius = "en\u{2D}MU"
    case englishSamoa = "en\u{2D}WS"
    case englishPalau = "en\u{2D}PW"
    case englishMalawi = "en\u{2D}MW"
    case englishBotswana = "en\u{2D}BW"
    case englishBurundi = "en\u{2D}BI"
    case englishCameroon = "en\u{2D}CM"
    case englishEthiopia = "en\u{2D}ET"
    case englishGambia = "en\u{2D}GM"
    case englishGhana = "en\u{2D}GH"
    case englishKenya = "en\u{2D}KE"
    case englishKiribati = "en\u{2D}KI"
    case englishLesotho = "en\u{2D}LS"
    case englishMalta = "en\u{2D}MT"
    case englishMarshallIslands = "en\u{2D}MH"
    case englishNigeria = "en\u{2D}NG"
    case englishPakistan = "en\u{2D}PK"
    case englishRwanda = "en\u{2D}RW"
    case englishSouthSudan = "en\u{2D}SS"
    case englishSudan = "en\u{2D}SD"
    case englishSwaziland = "en\u{2D}SZ"
    case englishTanzania = "en\u{2D}TZ"
    case englishTongo = "en\u{2D}TO"
    case englishTuvalu = "en\u{2D}TV"
    case englishUganda = "en\u{2D}UG"

    case العربية_السعودية = "arb\u{2D}SA"
    case العربية_مصر = "arb\u{2D}EG"
    case العربية_الجزائر = "arb\u{2D}DZ"
    case العربية_السودان = "arb\u{2D}SD"
    case العربية_المغرب = "arb\u{2D}MA"
    case العربية_العراق = "arb\u{2D}IQ"
    case العربية_سوريا = "arb\u{2D}SY"
    case العربية_اليمن = "arb\u{2D}YE"
    case العربية_تونس = "arb\u{2D}TN"
    case العربية_الأردن = "arb\u{2D}JO"
    case العربية_ليبيا = "arb\u{2D}LY"
    case العربية_لبنان = "arb\u{2D}LB"
    case العربية_الصومال = "arb\u{2D}SO"
    case العربية_الإمارات_العربية_المتحدة = "arb\u{2D}AE"
    case العربية_موريتانيا = "arb\u{2D}MR"
    case العربية_عمان = "arb\u{2D}OM"
    case العربية_إسرائيل = "arb\u{2D}IL"
    case العربية_الكويت = "arb\u{2D}KW"
    case العربية_تشاد = "arb\u{2D}TD"
    case العربية_قطر = "arb\u{2D}QA"
    case العربية_البحرين = "arb\u{2D}BH"
    case العربية_جيبوتي = "arb\u{2D}DJ"
    case العربية_جزر_القمر = "arb\u{2D}KM"

    case portuguêsPortugal = "pt\u{2D}PT"
    case portuguêsBrasil = "pt\u{2D}BR"
    case portuguêsAngola = "pt\u{2D}AO"
    case portuguêsMoçambique = "pt\u{2D}MZ"
    case portuguêsSãoToméEPríncipe = "pt\u{2D}ST"
    case portuguêsTimorLeste = "pt\u{2D}TL"
    case portuguêsCaboVerde = "pt\u{2D}CV"
    case portuguêsGuinéEquatorial = "pt\u{2D}GQ"
    case portuguêsGuinéBissau = "pt\u{2D}GW"

    case русскийРоссия = "ru\u{2D}RU"
    case русскийБеларусь = "ru\u{2D}BY"
    case русскийКазахстан = "ru\u{2D}KZ"
    case русскийКиргизия = "ru\u{2D}KG"

    case 日本語日本国 = "ja\u{2D}JP"

    case deutschDeutschland = "de\u{2D}DE"
    case deutschÖsterreich = "de\u{2D}AT"
    case deutschSchweiz = "de\u{2D}CH"
    case deutschBelgien = "de\u{2D}BE"
    case deutschLiechtenstein = "de\u{2D}LI"
    case deutschLuxemburg = "de\u{2D}LU"

    case tiếngViệtViệtNam = "vi\u{2D}VN"

    case 한국어한국 = "ko\u{2D}KR"
    case 조선말조선 = "ko\u{2D}KP"

    case françaisFrance = "fr\u{2D}FR"
    case françaisCanada = "fr\u{2D}CA"
    case françaisBelgique = "fr\u{2D}BE"
    case françaisSuisse = "fr\u{2D}CH"
    case françaisBurkinaFaso = "fr\u{2D}BF"
    case françaisLuxembourg = "fr\u{2D}LU"
    case françaisSénégal = "fr\u{2D}SN"
    case françaisMaurice = "fr\u{2D}MU"
    case françaisGabon = "fr\u{2D}GA"
    case françaisCongoBrazzaville = "fr\u{2D}CG"
    case françaisMadagascar = "fr\u{2D}MG"
    case françaisCôteDIvoire = "fr\u{2D}CI"
    case françaisBénin = "fr\u{2D}BJ"
    case françaisMonaco = "fr\u{2D}MC"
    case françaisDjibouti = "fr\u{2D}DJ"
    case françaisCentrafrique = "fr\u{2D}CF"
    case françaisMali = "fr\u{2D}ML"
    case françaisNiger = "fr\u{2D}NE"
    case françaisTchad = "fr\u{2D}TD"
    case françaisTogo = "fr\u{2D}TG"
    case françaisRwanda = "fr\u{2D}RW"
    case françaisBurundi = "fr\u{2D}BI"
    case françaisComores = "fr\u{2D}KM"
    case françaisVanuatu = "fr\u{2D}VU"
    case françaisSeychelles = "fr\u{2D}SC"
    case françaisCameroun = "fr\u{2D}CM"
    case françaisCongoKinshasa = "fr\u{2D}CD"
    case françaisGuinée = "fr\u{2D}GN"
    case françaisGuinéeEquatorial = "fr\u{2D}GQ"
    case françaisHaïti = "fr\u{2D}HT"

    case türkçeTürkiye = "tr\u{2D}TR"
    case türkçeKıbrıs = "tr\u{2D}CY"

    case italianoItalia = "it\u{2D}IT"
    case italianoSvizzera = "it\u{2D}CH"
    case italianoSanMarino = "it\u{2D}SM"
    case italianoCittàDiVaticano = "it\u{2D}VA"

    case polskiPolska = "pl\u{2D}PL"

    case українськаУкраїна = "uk\u{2D}UA"

    case nederlandsNederland = "nl\u{2D}NL"
    case nederlandsBelgië = "nl\u{2D}BE"
    case nederlandsSuriname = "nl\u{2D}SR"

    case malaysiaMalaysia = "zsm\u{2D}MY"
    case malaysiaSingapura = "zsm\u{2D}SG"
    case malaysiaBrunei = "zsm\u{2D}BN"

    case românăRomânia = "ro\u{2D}RO"
    case românăMoldova = "ro\u{2D}MD"

    case ไทยไทย = "th\u{2D}TH"

    case ελληνικάΕλλάδα = "el\u{2D}GR"
    case ελληνικάΚύπρης = "el\u{2D}CY"

    case češtinaČesko = "cs\u{2D}CZ"

    case magyarMagyarország = "hu\u{2D}HU"

    case svenskaSverige = "sv\u{2D}SE"
    case svenskaFinland = "sv\u{2D}FI"

    case indonesiaIndonesia = "id\u{2D}ID"

    case danskDanmark = "da\u{2D}DK"

    case suomiSuomi = "fi\u{2D}FI"

    case slovenčinaSlovensko = "sk\u{2D}SK"

    case עברית־ישראל = "he\u{2D}IL"

    case norskNorge = "nb\u{2D}NO"

    case hrvatskiHrvatska = "hr\u{2D}HR"

    case catalàEspanya = "ca\u{2D}ES"
    case catalàAndorra = "ca\u{2D}AD"

    internal static let cases: [ContentLocalization] = [

        .普通话中国,
        .华语新加坡,
        .國語中國,

        .españolEspaña,
        .españolMéxico,
        .españolColombia,
        .españolArgentina,
        .españolVenezuela,
        .españolPerú,
        .españolChile,
        .españolEcuador,
        .españolCuba,
        .españolRepúblicaDominicana,
        .españolGuatamala,
        .españolHonduras,
        .españolSalvador,
        .españolNicaragua,
        .españolBolivia,
        .españolCostaRica,
        .españolUruguay,
        .españolPanamá,
        .españolParaguay,
        .españolGuineaEcuatorial,

        .englishUnitedKingdom,
        .englishUnitedStates,
        .englishCanada,
        .englishAustralia,
        .englishSouthAfrica,
        .englishIreland,
        .englishNewZealand,
        .englishSingapore,
        .englishTrinidadAndTobago,
        .englishGuyana,
        .englishLiberia,
        .englishSierraLeone,
        .englishMalaysia,
        .englishBarbados,
        .englishBahamas,
        .englishZimbabwe,
        .englishIndia,
        .englishBelize,
        .englishPapuaNewGuinea,
        .englishSaintVincentAndGrenadines,
        .englishZambia,
        .englishGrenada,
        .englishAntiguaAndBarbuda,
        .englishVanuatu,
        .englishJamaica,
        .englishSaintKittsAndNevis,
        .englishSriLanka,
        .englishPhilippines,
        .englishSaintLucia,
        .englishNamibia,
        .englishBrunei,
        .englishSolomonIslands,
        .englishNauru,
        .englishFiji,
        .englishMicronesia,
        .englishDominica,
        .englishSeychelles,
        .englishMauritius,
        .englishSamoa,
        .englishPalau,
        .englishMalawi,
        .englishBotswana,
        .englishBurundi,
        .englishCameroon,
        .englishEthiopia,
        .englishGambia,
        .englishGhana,
        .englishKenya,
        .englishKiribati,
        .englishLesotho,
        .englishMalta,
        .englishMarshallIslands,
        .englishNigeria,
        .englishPakistan,
        .englishRwanda,
        .englishSouthSudan,
        .englishSudan,
        .englishSwaziland,
        .englishTanzania,
        .englishTongo,
        .englishTuvalu,
        .englishUganda,

        .العربية_السعودية,
        .العربية_مصر,
        .العربية_الجزائر,
        .العربية_السودان,
        .العربية_المغرب,
        .العربية_العراق,
        .العربية_سوريا,
        .العربية_اليمن,
        .العربية_تونس,
        .العربية_الأردن,
        .العربية_ليبيا,
        .العربية_لبنان,
        .العربية_الصومال,
        .العربية_الإمارات_العربية_المتحدة,
        .العربية_موريتانيا,
        .العربية_عمان,
        .العربية_إسرائيل,
        .العربية_الكويت,
        .العربية_تشاد,
        .العربية_قطر,
        .العربية_البحرين,
        .العربية_جيبوتي,
        .العربية_جزر_القمر,

        .portuguêsPortugal,
        .portuguêsBrasil,
        .portuguêsAngola,
        .portuguêsMoçambique,
        .portuguêsSãoToméEPríncipe,
        .portuguêsTimorLeste,
        .portuguêsCaboVerde,
        .portuguêsGuinéEquatorial,
        .portuguêsGuinéBissau,

        .русскийРоссия,
        .русскийБеларусь,
        .русскийКазахстан,
        .русскийКиргизия,

        .日本語日本国,

        .deutschDeutschland,
        .deutschÖsterreich,
        .deutschSchweiz,
        .deutschBelgien,
        .deutschLiechtenstein,
        .deutschLuxemburg,

        .tiếngViệtViệtNam,

        .한국어한국,
        .조선말조선,

        .françaisFrance,
        .françaisCanada,
        .françaisBelgique,
        .françaisSuisse,
        .françaisBurkinaFaso,
        .françaisLuxembourg,
        .françaisSénégal,
        .françaisMaurice,
        .françaisGabon,
        .françaisCongoBrazzaville,
        .françaisMadagascar,
        .françaisCôteDIvoire,
        .françaisBénin,
        .françaisMonaco,
        .françaisDjibouti,
        .françaisCentrafrique,
        .françaisMali,
        .françaisNiger,
        .françaisTchad,
        .françaisTogo,
        .françaisRwanda,
        .françaisBurundi,
        .françaisComores,
        .françaisVanuatu,
        .françaisSeychelles,
        .françaisCameroun,
        .françaisCongoKinshasa,
        .françaisGuinée,
        .françaisGuinéeEquatorial,
        .françaisHaïti,

        .türkçeTürkiye,
        .türkçeKıbrıs,

        .italianoItalia,
        .italianoSvizzera,
        .italianoSanMarino,
        .italianoCittàDiVaticano,

        .polskiPolska,

        .українськаУкраїна,

        .nederlandsNederland,
        .nederlandsBelgië,
        .nederlandsSuriname,

        .malaysiaMalaysia,
        .malaysiaSingapura,
        .malaysiaBrunei,

        .românăRomânia,
        .românăMoldova,

        .ไทยไทย,

        .ελληνικάΕλλάδα,
        .ελληνικάΚύπρης,

        .češtinaČesko,

        .magyarMagyarország,

        .svenskaSverige,
        .svenskaFinland,

        .indonesiaIndonesia,

        .danskDanmark,

        .suomiSuomi,

        .slovenčinaSlovensko,

        .עברית־ישראל,

        .norskNorge,

        .hrvatskiHrvatska,

        .catalàEspanya,
        .catalàAndorra
    ]

    internal static let macrolanguages = [
        // [_Define Example: Macrolanguages_]
        "zh": ["cmn"],
        "ar": ["arb"],
        "no": ["nb"],
        "ms": ["zsm"]
        // [_End_]
    ]

    internal static let groups: [String: [(script: String, countries: [String])]] = [
        // [_Define Example: Localization Groups_]
        "cmn": [
            ("Hans", ["CN", "SG"]),
            ("Hant", ["TW"])],
        "es": [("Latn", ["ES", "419", "MX", "CO", "AR", "VE", "PE", "CL", "EC", "CU", "DO", "GT", "HN", "SV", "NI", "BO", "CR", "UY", "PA", "PY", "GQ"])],
        "en": [("Latn", ["GB", "US", "CA", "AU", "ZA", "IE", "NZ", "SG", "TT", "GY", "LR", "SL", "MY", "BB", "BS", "ZW", "IN", "BZ", "PG", "VC", "ZM", "GD", "AG", "VU", "JM", "KN", "LK", "PH", "LC", "NA", "BN", "SB", "NR", "FJ", "FM", "DM", "SC", "MU", "WS", "PW", "MW", "BW", "BI", "CM", "ET", "GM", "GH", "KE", "KI", "LS", "MT", "MH", "NG", "PK", "RW", "SS", "SD", "SZ", "TZ", "TO", "TV", "UG"])],
        "arb": [("Arab", ["SA", "EG", "DZ", "SD", "MA", "IQ", "SY", "YE", "TN", "JO", "LY", "LB", "SO", "AE", "MR", "OM", "IL", "KW", "TD", "QA", "BH", "DJ", "KM"])],
        "pt": [("Latn", ["PT", "BR", "AO", "MZ", "ST", "TL", "CV", "GQ", "GW"])],
        "ru": [("Cyrl", ["RU", "BY", "KZ", "KG"])],
        "ja": [("Jpan", ["JP"])],
        "de": [("Latn", ["DE", "AT", "CH", "BE", "LI", "LU"])],
        "vi": [("Latn", ["VN"])],
        "ko": [("Kore", ["KR", "KP"])],
        "fr": [("Latn", ["FR", "CA", "BE", "CH", "BF", "LU", "SN", "MU", "GA", "CG", "MG", "CI", "BJ", "MC", "DJ", "CF", "ML", "NE", "TD", "TG", "RW", "BI", "KM", "VU", "SC", "CM", "CD", "GN", "GQ", "HT"])],
        "tr": [("Latn", ["TR", "CY"])],
        "it": [("Latn", ["IT", "CH", "SM", "VA"])],
        "pl": [("Latn", ["PL"])],
        "uk": [("Cyrl", ["UA"])],
        "nl": [("Latn", ["NL", "BE", "SR"])],
        "zsm": [("Latn", ["MY", "SG", "BN"])],
        "ro": [("Latn", ["RO", "MD"])],
        "th": [("Thai", ["TH"])],
        "el": [("Grek", ["GR", "CY"])],
        "cs": [("Latn", ["CZ"])],
        "hu": [("Latn", ["HU"])],
        "sv": [("Latn", ["SE", "FI"])],
        "id": [("Latn", ["ID"])],
        "da": [("Latn", ["DK"])],
        "fi": [("Latn", ["FI"])],
        "sk": [("Latn", ["SK"])],
        "he": [("Hebr", ["IL"])],
        "nb": [("Latn", ["NO"])],
        "hr": [("Latn", ["HR"])],
        "ca": [("Latn", ["ES", "AD"])]
        // [_End_]
    ]

    internal static let macrolanguageMembership: [String: String] = {
        var result: [String: String] = [:]
        for (macrolanguage, languages) in macrolanguages {
            for language in languages {
                result[language] = macrolanguage
            }
        }
        return result
    }()

    private static let flagOffset: UInt32 = 0x1F1A5
    private var flag: StrictString {
        let country = (rawValue.components(separatedBy: "\u{2D}") as [String]).last!
        return StrictString(country.scalars.map({ UnicodeScalar($0.value + ContentLocalization.flagOffset)! }))
    }

    private static func code(for flag: StrictString) -> String {
        return String(String.ScalarView(flag.scalars.map({
            if $0.value > flagOffset {
                return UnicodeScalar($0.value − flagOffset)!
            } else {
                return UnicodeScalar(0)
            }
        })))
    }

    private static let codeToAbbreviation: [String: StrictString] = [
        "cmn\u{2D}Hans": "普",
        "cmn\u{2D}Hant": "國",
        "es": "ES",
        "en": "EN",
        "arb": "عر",
        "pt": "PT",
        "ru": "РУ",
        "ja": "日",
        "de": "DE",
        "vi": "VI",
        "ko": "한",
        "fr": "FR",
        "tr": "TR",
        "it": "IT",
        "pl": "PL",
        "uk": "УК",
        "nl": "NL",
        "zsm": "MS",
        "ro": "RO",
        "th": "ไท",
        "el": "ΕΛ",
        "cs": "ČŠ",
        "hu": "MA", // Unassigned in ISO
        "sv": "SV",
        "id": "ID",
        "da": "DA",
        "fi": "SI", // ISO: SU → Sunda ✗, SO → Soomaali ✗, SM → Sāmoa ✗, SI → සිංහල (code: සිං) ✓
        "sk": "SČ",
        "he": "עב",
        "nb": "NB", // Norsk – Bokmål
        "hr": "HR",
        "ca": "CA"
    ]
    private static let abbreviationToCode: [StrictString: String] = {
        var result: [StrictString: String] = [:]
        for (code, abbreviation) in codeToAbbreviation {
            result[abbreviation] = code
        }

        result["华"] = "cmn\u{2D}Hans"
        result["조"] = "ko"

        return result
    }()

    private var abbreviation: StrictString {
        switch self {
        case .华语新加坡:
            return "华"
        case .조선말조선:
            return "조"
        default:
            return ContentLocalization.codeToAbbreviation[code.components(separatedBy: "\u{2D}").dropLast().joined(separator: "\u{2D}")]!
        }
    }

    internal var definedIcon: StrictString {
        return flag + abbreviation
    }

    internal init?(definedIcon: StrictString) {
        guard definedIcon.scalars.count > 2 else {
            return nil
        }

        var abbreviation = definedIcon
        var flag = StrictString()
        flag.append(abbreviation.removeFirst())
        flag.append(abbreviation.removeFirst())

        let country = ContentLocalization.code(for: flag)
        guard let language = ContentLocalization.abbreviationToCode[abbreviation] else {
            return nil
        }

        self.init(exactly: language + "\u{2D}" + country)
    }

    // MARK: - Localization

    internal static let fallbackLocalization: ContentLocalization = .עברית־ישראל
}

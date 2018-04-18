
import SDGText

internal enum Language : String {

    // MARK: - Cases

    case 普通话 = "cmn"
    case español = "es"
    case english = "en"
    case العربية = "arb"
    case हिन्दी = "hi"
    case português = "pt"
    case русский = "ru"
    case 日本語 = "ja"
    case deutsch = "de"
    case tiếngViệt = "vi"
    case 한국어 = "ko"
    case français = "fr"
    case türkçe = "tr"
    case italiano = "it"
    case polski = "pl"
    case українська = "uk"
    case nederlands = "nl"
    case malaysia = "zsm"
    case română = "ro"
    case ไทย = "th"
    case ελληνικά = "el"
    case čeština = "cs"
    case magyar = "hu"
    case svenska = "sv"
    case indonesia = "id"
    case dansk = "da"
    case suomi = "fi"
    case slovenčina = "sk"
    case עברית = "he"
    case norskBokmål = "nb"
    case hrvatski = "hr"
    case català = "ca"

    // MARK: - Description

    func isolatedEnglishName() -> StrictString {
        switch self {
        case .普通话:
            return "Mandarin"
        case .español:
            return "Spanish"
        case .english:
            return "English"
        case .العربية:
            return "Arabic"
        case .हिन्दी:
            return "Hindi"
        case .português:
            return "Portuguese"
        case .русский:
            return "Russian"
        case .日本語:
            return "Japanese"
        case .deutsch:
            return "German"
        case .tiếngViệt:
            return "Vietnamese"
        case .한국어:
            return "Korean"
        case .français:
            return "French"
        case .türkçe:
            return "Turkish"
        case .italiano:
            return "Italian"
        case .polski:
            return "Polish"
        case .українська:
            return "Ukrainian"
        case .nederlands:
            return "Dutch"
        case .malaysia:
            return "Malaysian"
        case .română:
            return "Romanian"
        case .ไทย:
            return "Thai"
        case .ελληνικά:
            return "Greek"
        case .čeština:
            return "Czech"
        case .magyar:
            return "Hungarian"
        case .svenska:
            return "Swedish"
        case .indonesia:
            return "Indonesian"
        case .dansk:
            return "Danish"
        case .suomi:
            return "Finnish"
        case .slovenčina:
            return "Slovak"
        case .עברית:
            return "Hebrew"
        case .norskBokmål:
            return "Norwegian Bokmål"
        case .hrvatski:
            return "Croatian"
        case .català:
            return "Catalan"
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

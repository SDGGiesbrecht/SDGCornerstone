
internal enum Script : String {

    // MARK: - Cases

    case 简化字 = "Hans"
    case 正體字 = "Hant"

    // MARK: - Description

    func isolatedEnglishName() -> StrictString {
        switch self {
        case .简化字:
            return "Simplified Chinese"
        case .正體字:
            return "Traditional Chinese"
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

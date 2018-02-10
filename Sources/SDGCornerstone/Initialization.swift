/*
 Initialization.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

// MARK: - Initialization

private var initialized = false
/// Initializes SDGCornerstone. Call this before calling anything else from SDGCornerstone.
///
/// - Parameters:
///     - applicationIdentifier: An identifier for the application. If the application has a main bundle, this should match its identifier.
///     - applicationPreferencesClass: A subclass of `Preferences` to use for the application preferences. Defaults to the `Preferences` class itself.
///     - mode: The `Mode` SDGCornerstone should follow.
public func initialize(mode: Mode, applicationPreferencesClass: Preferences.Type = Preferences.self) {

    assert(initialized == false, UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
        switch localization {
        case .englishCanada: // [_Exempt from Test Coverage_]
            return StrictString("Detected attempted to re‐initialize. SDGCornerstone is only designed to be initialized once.")
        }
    }))
    defer { initialized = true }

    Application.currentApplicationModeInitializer = mode
    Preferences.subclassForApplicationPreferencesInitializer = applicationPreferencesClass

    warnAboutSecondLanguages()
}

internal func preconditionFailureNotInitialized() -> Never {
    // This cannot be localized the normal way because of circularity.
    let message = APILocalization.cases.map({ // [_Exempt from Test Coverage_]
        switch $0 {
        case .englishCanada: // [_Exempt from Test Coverage_]
            return "SDGCornerstone has not been initialized. Did you forget to call SDGCornerstone.initialize(...)?"
        }
    }).joined(separator: "\n\n")

    preconditionFailure("\n\n" + message + "\n\n")
}

private func warnAboutSecondLanguages() {
    if BuildConfiguration.current == .debug {
        if LocalizationSetting.current.value.resolved() as InterfaceLocalization ∉ Set<InterfaceLocalization>([
            .englishUnitedKingdom,
            .englishUnitedStates,
            .englishCanada]) { // [_Exempt from Test Coverage_]
            let warning = UserFacingText({ (localization: InterfaceLocalization, _: Void) -> StrictString in // [_Exempt from Test Coverage_]
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    unreachable()
                case .deutschDeutschland: // [_Exempt from Test Coverage_]
                    return "Achtung: Das Deutsch von SDGCornerstone ist noch von keinem Muttersprachler geprüft worden. Falls Sie dabei helfen möchten, melden Sie sich unter:"
                case .françaisFrance: // [_Exempt from Test Coverage_]
                    return "Attention : Le français de SDGCornerstone n’a pas été vérifié par un locuteur natif. Si vous voudriez nous aider, inscrivez‐vous par ici :"
                case .ελληνικάΕλλάδα: // [_Exempt from Test Coverage_]
                    return "Προειδοποίηση: Τα ελληνικά του SDGCornerstone δεν ελέγχεται από ενός φυσικού ομιλητή. Αν θέλετε να μας βοηθήσετε, εγγράψτε εδώ:"
                case .עברית־ישראל: // [_Exempt from Test Coverage_]
                    /*א*/ return "זהירות: העברית של SDGCornerstone לא נבדקה אל יד של דובר שפת אם. אם אתה/את רוצה לעזור לנו, הירשם/הירשמי כאן:"
                }
            })
            let issueTitle = UserFacingText({ (localization: InterfaceLocalization, _: Void) -> StrictString in // [_Exempt from Test Coverage_]
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    unreachable()
                case .deutschDeutschland: // [_Exempt from Test Coverage_]
                    return "Deutsch prüfen"
                case .françaisFrance: // [_Exempt from Test Coverage_]
                    return "Vérifier le français"
                case .ελληνικάΕλλάδα: // [_Exempt from Test Coverage_]
                    return "Έλεγχος των ελληνικών"
                case .עברית־ישראל: // [_Exempt from Test Coverage_]
                    return "בדיקה של העברית"
                }
            })
            let issueBody = UserFacingText({ (localization: InterfaceLocalization, _: Void) -> StrictString in // [_Exempt from Test Coverage_]
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    unreachable()
                case .deutschDeutschland: // [_Exempt from Test Coverage_]
                    return "Ich würde gern helfen. Bitte erklären Sie mir wie."
                case .françaisFrance: // [_Exempt from Test Coverage_]
                    return "Je voudrais assister. S’il vous plaît, expliquez‐moi comment."
                case .ελληνικάΕλλάδα: // [_Exempt from Test Coverage_]
                    return "Θα ήθελα να βοηθήσω. Παρακαλώ, εξηγήστε πώς."
                case .עברית־ישראל: // [_Exempt from Test Coverage_]
                    return "אני רוצה לעזור. נא הסבר איך."
                }
            })
            var message: StrictString = "⚠ "
            message += warning.resolved()
            message += "\n"
            message += "https://github.com/SDGGiesbrecht/SDGCornerstone/issues/new?title="
            message += StrictString(String(issueTitle.resolved()).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
            message += "&body="
            message += StrictString(String(issueBody.resolved()).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
            print(message)
        }
    }
}

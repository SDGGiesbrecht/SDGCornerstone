
import SDGMathematics

extension Angle : CustomStringConvertible {

    // MARK: - CustomStringConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomStringConvertible.description_]
    public var description: String {
        return String(UserFacingText({ (localization: _InterfaceLocalization) in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return self.inRadians.inDigits(maximumDecimalPlaces: 3, radixCharacter: ".") + " rad"
            }
        }).resolved())
    }
}

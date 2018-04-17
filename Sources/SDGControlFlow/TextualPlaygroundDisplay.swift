
/// A type which displays its textual description in playgrounds.
///
/// Conformance Requirements:
///     - `CustomStringConvertible`
public protocol TextualPlaygroundDisplay : CustomPlaygroundDisplayConvertible, CustomStringConvertible {

}

extension TextualPlaygroundDisplay {

    // MARK: - CustomPlaygroundDisplayConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomPlaygroundDisplayConvertible.playgroundDescription_]
    @_inlineable public var playgroundDescription: Any {
        return String(describing: self)
    }
}


/// A wrapper which should be transparent when logging or displaying in a playground.
public protocol TransparentWrapper : CustomDebugStringConvertible, CustomPlaygroundDisplayConvertible, CustomStringConvertible {

    /// The wrapped type.
    associatedtype Wrapped

    // [_Define Documentation: SDGCornerstone.TransparentWrapper.wrapped_]
    /// The wrapped instance.
    var wrappedInstance: Wrapped { get }
}

extension TransparentWrapper {

    // MARK: - CustomDebugStringConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomDebugStringConvertible.debugDescription_]
    @_inlineable public var debugDescription: String {
        return String(reflecting: wrappedInstance)
    }

    // MARK: - CustomPlaygroundDisplayConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomPlaygroundDisplayConvertible.playgroundDescription_]
    @_inlineable public var playgroundDescription: Any {
        return wrappedInstance
    }

    // MARK: - CustomStringConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomStringConvertible.description_]
    @_inlineable public var description: String {
        return String(describing: wrappedInstance)
    }
}


extension LocalizationSetting {

    /// A stabilization mode for when multiple languages are active.
    public enum StabilizationMode {

        /// No stabilization will be performed.
        ///
        /// This is the standard mode.
        case none

        /// Stabilization will be performed.
        ///
        /// In this mode the localization will be cached and the same value returned for a longer period of time. This mode can be useful to prevent interface elements with a high refresh rate from bouncing rapidly between localizations when several are active at once.
        ///
        /// - Warning: As a side effect, this mode reduces the effect of mixing localizations. It should only be used where it is actually needed.
        case stabilized
    }
}

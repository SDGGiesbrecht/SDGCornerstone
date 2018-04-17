
#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
// `NSBezierPath` or `UIBezierPath`.
public typealias BézierPath = NSBezierPath
#elseif canImport(UIKit)
// `NSBezierPath` or `UIBezierPath`.
public typealias BézierPath = UIBezierPath
#endif

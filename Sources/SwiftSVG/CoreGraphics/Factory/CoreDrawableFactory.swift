//
//  Created by Kurlovich Vitali on 8/16/26.
//

import struct CoreGraphics.CGAffineTransform
import class CoreGraphics.CGPath
import struct SwiftUI.Path

extension CGPath: @unchecked @retroactive Sendable {}

public struct CoreDrawableFactory: DrawableFactory {
    var options: Options

    public init(options: Options = [.cgPath, .path]) {
        self.options = options
    }

    public func pathDrawable(commands: some Sequence<PathCommand>, style: Style, transform: CGAffineTransform?) -> Drawable {
        var drawable = Drawable.path(
            style: style,
            transform: transform,
        )

        if options.contains(.cgPath),
           let path = CGPath.path(with: commands),
           path.isEmpty == false
        {
            drawable[CGPath.self] = path
        }

        if options.contains(.path) {
            let path = Path(commands)

            if path.isEmpty == false {
                drawable[Path.self] = path
            }
        }

        return drawable
    }

    public func circleDrawable(_ circle: Circle, style: Style, transform: CGAffineTransform?) -> Drawable {
        var drawable = Drawable.circle(
            style: style,
            transform: transform,
        )

        drawable[Circle.self] = circle

        return drawable
    }
}

public extension CoreDrawableFactory {
    struct Options: OptionSet, Sendable {
        public let rawValue: UInt8

        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }

        ///  SwiftUI.Path
        public static var path: Self {
            .init(rawValue: 1 << 0)
        }

        ///  CoreGraphics.CGPath
        public static var cgPath: Self {
            .init(rawValue: 1 << 1)
        }
    }
}

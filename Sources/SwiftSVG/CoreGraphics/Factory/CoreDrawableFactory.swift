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

    public func useDrawable(id: String?, _ use: Use, style: Style, transform: CGAffineTransform?) -> Drawable {
        var drawable = Drawable.use(style: style, transform: transform)
        drawable[Use.self] = use
        drawable.id = id
        return drawable
    }

    public func pathDrawable(id: String?, commands: some Sequence<PathCommand>, style: Style, transform: CGAffineTransform?) -> Drawable {
        var drawable = Drawable.path(
            style: style,
            transform: transform,
        )

        drawable.id = id

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

    public func rectDrawable(id: String?, _ rect: Rect, style: Style, transform: CGAffineTransform?) -> Drawable {
        var drawable = Drawable.rect(
            style: style,
            transform: transform,
        )
        drawable.id = id
        drawable[Rect.self] = rect

        return drawable
    }

    public func circleDrawable(id: String?, _ circle: Circle, style: Style, transform: CGAffineTransform?) -> Drawable {
        var drawable = Drawable.circle(
            style: style,
            transform: transform,
        )
        drawable.id = id
        drawable[Circle.self] = circle

        return drawable
    }

    public func ellipseDrawable(id: String?, _ ellipse: Ellipse, style: Style, transform: CGAffineTransform?) -> Drawable {
        var drawable = Drawable.circle(
            style: style,
            transform: transform,
        )

        drawable.id = id
        drawable[Ellipse.self] = ellipse

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

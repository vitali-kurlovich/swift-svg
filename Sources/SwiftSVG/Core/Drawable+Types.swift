//
//  Created by Kurlovich Vitali on 8/14/26.
//

import CoreGraphics

public enum DrawableGroup: Equatable, Sendable {}

public enum DrawablePath: Equatable, Sendable {}

public enum DrawableCircle: Equatable, Sendable {}

public extension Drawable {
    var isGroup: Bool {
        isTypeOf(DrawableGroup.self)
    }

    static func group(style: Style,
                      transform: CGAffineTransform? = nil,
                      childs: [Drawable] = []) -> Self
    {
        .init(DrawableGroup.self, style: style, transform: transform, childs: childs)
    }
}

public extension Drawable {
    var isPath: Bool {
        isTypeOf(DrawablePath.self)
    }

    static func path(style: Style,
                     transform: CGAffineTransform? = nil,
                     childs: [Drawable] = []) -> Self
    {
        .init(DrawablePath.self, style: style, transform: transform, childs: childs)
    }
}

public extension Drawable {
    var isCircle: Bool {
        isTypeOf(DrawableCircle.self)
    }

    static func circle(style: Style,
                       transform: CGAffineTransform? = nil,
                       childs: [Drawable] = []) -> Self
    {
        .init(DrawableCircle.self, style: style, transform: transform, childs: childs)
    }
}

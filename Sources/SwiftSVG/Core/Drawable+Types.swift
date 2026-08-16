//
//  Created by Kurlovich Vitali on 8/14/26.
//

public enum DrawableGroup: Equatable, Sendable {}

public enum DrawablePath: Equatable, Sendable {}

public extension Drawable {
    var isGroup: Bool {
        isTypeOf(DrawableGroup.self)
    }

    static func group(style: Style,
                      transform: Transform? = nil,
                      childs: [Drawable<Transform>] = []) -> Self
    {
        .init(DrawableGroup.self, style: style, transform: transform, childs: childs)
    }
}

public extension Drawable {
    var isPath: Bool {
        isTypeOf(DrawablePath.self)
    }

    static func path(style: Style,
                     transform: Transform? = nil,
                     childs: [Drawable<Transform>] = []) -> Self
    {
        .init(DrawablePath.self, style: style, transform: transform, childs: childs)
    }
}

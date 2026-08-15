//
//  Created by Kurlovich Vitali on 8/14/26.
//

public enum DrawableGroup: Equatable, Sendable {}

public extension Drawable {
    var isGroup: Bool {
        isTypeOf(DrawableGroup.self)
    }

    static func group(style: Style,
                      transform: Transform? = nil,
                      childs: [Drawable<Transform>] = []) -> Self
    {
        Self(DrawableGroup.self, style: style, transform: transform, childs: childs)
    }
}

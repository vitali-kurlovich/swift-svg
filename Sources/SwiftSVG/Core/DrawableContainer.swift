//
//  Created by Kurlovich Vitali on 8/15/26.
//

public struct DrawableContainer<Transform: Equatable & Sendable, Rect: Equatable & Sendable> {
    public var viewBox: Rect
    public var drawable: Drawable<Transform>

    public init(viewBox: Rect, drawable: Drawable<Transform>) {
        self.viewBox = viewBox
        self.drawable = drawable
    }
}

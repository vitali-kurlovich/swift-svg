//
//  Created by Kurlovich Vitali on 8/15/26.
//

import CoreGraphics

public struct DrawableContainer: Equatable, Sendable {
    public var viewBox: CGRect
    public var drawable: Drawable

    public init(viewBox: CGRect, drawable: Drawable) {
        self.viewBox = viewBox
        self.drawable = drawable
    }
}

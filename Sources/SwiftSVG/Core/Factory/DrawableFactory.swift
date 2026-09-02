//
//  Created by Kurlovich Vitali on 8/15/26.
//

import CoreGraphics

public protocol DrawableFactory {
    func pathDrawable(commands: some Sequence<PathCommand>, style: Style, transform: CGAffineTransform?) -> Drawable
    func groupDrawable(style: Style, transform: CGAffineTransform?) -> Drawable
}

public extension DrawableFactory {
    func groupDrawable(style: Style, transform: CGAffineTransform?) -> Drawable {
        .group(style: style, transform: transform)
    }
}

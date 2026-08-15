
//
//  Created by Kurlovich Vitali on 8/15/26.
//

import struct CoreGraphics.CGAffineTransform
import struct SwiftUI.Path

public struct SwiftUIDrawableFactory: DrawableFactory {
    public init() {}

    public func pathDrawable(commands: some Sequence<PathCommand>, style: Style, transform: CGAffineTransform?) -> Drawable<CGAffineTransform> {
        let path = Path(commands)

        return .init(path, style: style, transform: transform)
    }
}

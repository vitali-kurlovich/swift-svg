//
//  Created by Kurlovich Vitali on 8/16/26.
//

import struct CoreGraphics.CGAffineTransform
import class CoreGraphics.CGPath

extension CGPath: @unchecked @retroactive Sendable {}

public struct CoreGraphicsDrawableFactory: DrawableFactory {
    public init() {}

    public func pathDrawable(commands: some Sequence<PathCommand>, style: Style, transform: CGAffineTransform?) -> Drawable<CGAffineTransform> {
        guard let path = CGPath.path(with: commands) else {
            return .init(CGPath.self, style: style, transform: transform)
        }
        return .init(path, style: style, transform: transform)
    }
}

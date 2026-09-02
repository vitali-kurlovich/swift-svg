//
//  Created by Kurlovich Vitali on 8/16/26.
//

import struct CoreGraphics.CGAffineTransform
import struct CoreGraphics.CGRect
import struct CoreGraphics.CGSize
import struct SwiftUI.FillStyle
import struct SwiftUI.GraphicsContext
import struct SwiftUI.Path

public extension GraphicsContext {
    func draw(_ drawable: Drawable) {
        withCGContext { context in
            context.draw(drawable)
        }
    }
}

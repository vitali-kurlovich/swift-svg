//
//  Created by Kurlovich Vitali on 8/16/26.
//

import class CoreGraphics.CGColor
import struct CoreGraphics.CGFloat

public extension CGColor {
    static func color(from color: SolidColor) -> CGColor {
        CGColor(
            red: CGFloat(color.red),
            green: CGFloat(color.green),
            blue: CGFloat(color.blue),
            alpha: CGFloat(color.alpha),
        )
    }
}

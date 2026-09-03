//
//  Created by Kurlovich Vitali on 9/3/26.
//

import struct CoreGraphics.CGFloat
import struct CoreGraphics.CGRect
import struct CoreGraphics.CGSize

public extension CGSize {
    var normalizedDiagonal: CGFloat {
        (width * width + height * height).squareRoot() / 2.0.squareRoot()
    }
}

public extension CGRect {
    var normalizedDiagonal: CGFloat {
        size.normalizedDiagonal
    }
}

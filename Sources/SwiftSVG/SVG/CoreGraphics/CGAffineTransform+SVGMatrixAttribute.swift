//
//  Created by Kurlovich Vitali on 8/7/26.
//

import struct CoreGraphics.CGAffineTransform
import struct Foundation.CGFloat

extension CGAffineTransform {
    init(_ attr: SVGMatrixAttribute) {
        self.init(CGFloat(attr.a), CGFloat(attr.b), CGFloat(attr.c), CGFloat(attr.d), CGFloat(attr.tx), CGFloat(attr.ty))
    }
}

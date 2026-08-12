//
//  Created by Kurlovich Vitali on 8/5/26.
//

import struct CoreGraphics.CGFloat
import struct CoreGraphics.CGPoint

public extension Point {
    @inlinable
    init(_ p: CGPoint) {
        self.init(x: p.x, y: p.y)
    }
}

public extension CGPoint {
    @inlinable
    init(_ p: Point) {
        self.init(x: CGFloat(p.x), y: CGFloat(p.y))
    }
}

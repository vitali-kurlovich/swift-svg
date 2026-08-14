//
//  Created by Kurlovich Vitali on 8/9/26.
//

import Playgrounds

public extension Stroke {
    /// The stroke-miterlimit attribute is a presentation attribute defining a limit on the ratio of the miter length to the stroke-width used to draw a miter join. When the limit is exceeded, the join is converted from a miter to a bevel.
    ///
    /// See: [stroke-miterlimit](https://developer.mozilla.org/en-US/docs/Web/SVG/Reference/Attribute/stroke-miterlimit)
    struct MiterLimit: Hashable, Sendable {
        public var value: Float32 {
            didSet {
                assert(value >= 1.0)
            }
        }

        public init(value: Float32 = 4.0) {
            assert(value >= 1.0)
            self.value = value
        }
    }
}

public extension Stroke.MiterLimit {
    static var `default`: Self {
        .init()
    }
}

extension Stroke.MiterLimit: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Float32) {
        self.init(value: value)
    }
}


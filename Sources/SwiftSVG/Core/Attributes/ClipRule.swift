//
//  Created by Kurlovich Vitali on 8/9/26.
//

/// The clip-rule CSS property determines, when parts of the path overlap other parts, which pixels in a mask's box are inside the clipping shape defined by a clip path and which are outside.
///
/// See:  [clip-rule](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Properties/clip-rule)
public enum ClipRule: UInt8, Hashable, Sendable {
    /**
     For every point in the clipping mask's box, a ray is drawn in a random direction. Every time the ray intersects with any part of the clipping path, a tally is increased by one if the clipping path's part is moving from left to right across the ray, whereas it is decreased by one if the path part is moving right to left across the ray. If the final total of the tally is zero, the point is outside the path's shape. Otherwise, it's inside the path's shape.
     */
    case nonzero = 0

    /**
     For every point in the clipping mask's box, a ray is drawn in a random direction. Every time the ray intersects with any part of the clipping path, a tally is increased by one. If the final total of the tally is even, the point is outside the path's shape; otherwise, it's inside the path's shape. Zero is taken to be even.
     */
    case evenodd
}

public extension ClipRule {
    static var `default`: Self {
        .nonzero
    }
}

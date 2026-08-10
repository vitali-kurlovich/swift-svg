//
//  Created by Kurlovich Vitali on 8/9/26.
//

public extension Fill {
    /// The fill-rule clarifies which areas of a shape should be considered "inside" the shape.
    ///
    /// See:  [fill-rule](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Properties/fill-rule)
    enum Rule: UInt8, Hashable, Sendable {
        /**
         For every point in the shape, a ray is drawn in a random direction to beyond the shape's outer edges. Each ray is examined to determine the places where the ray crosses the shape. Starting with a count of zero, add one each time a path segment crosses the ray from left to right and subtract one each time a path segment crosses the ray from right to left. After counting the crossings, if the result is zero then the point is outside the path. Otherwise, it is inside.
         */
        case nonzero = 0

        /**
         For every point in the fill rule's box, a ray is drawn in a random direction. The number of path segments from the given shape that the ray crosses are counted. If this number is odd, the point is inside; if even, the point is outside. Zero is taken to be even.
         */
        case evenodd
    }
}

public extension Fill.Rule {
    static var `default`: Self {
        .nonzero
    }
}

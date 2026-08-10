//
//  Created by Kurlovich Vitali on 8/9/26.
//

public extension Stroke {
    /// The stroke-linecap attribute is a presentation attribute defining the shape to be used at the end of open subpaths when they are stroked.
    ///
    /// See:  [stroke-linecap](https://developer.mozilla.org/en-US/docs/Web/SVG/Reference/Attribute/stroke-linecap)
    enum LineCap: UInt8, Hashable, Sendable {
        /// The butt value indicates that the stroke for each subpath does not extend beyond its two endpoints. On a zero length subpath, the path will not be rendered at all.
        case butt = 0

        /// The round value indicates that at the end of each subpath the stroke will be extended by a half circle with a diameter equal to the stroke width. On a zero length subpath, the stroke consists of a full circle centered at the subpath's point.
        case round

        /// The square value indicates that at the end of each subpath the stroke will be extended by a rectangle with a width equal to half the width of the stroke and a height equal to the width of the stroke. On a zero length subpath, the stroke consists of a square with its width equal to the stroke width, centered at the subpath's point.
        case square
    }
}

public extension Stroke.LineCap {
    static var `default`: Self {
        .butt
    }
}

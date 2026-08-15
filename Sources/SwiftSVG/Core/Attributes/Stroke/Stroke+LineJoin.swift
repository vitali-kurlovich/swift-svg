//
//  Created by Kurlovich Vitali on 8/9/26.
//

public extension Stroke {
    /// The stroke-linejoin CSS property defines the shape to be used at the corners of an SVG element's stroked paths. If present, it overrides the element's stroke-linejoin attribute.
    ///
    ///  See: [stroke-linejoin](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Properties/stroke-linejoin)
    enum LineJoin: UInt8, Hashable, Sendable {
        /// Indicates that a sharp corner is to be used to join path segments. The corner is formed by extending the outer edges of the stroke at the tangents of the path segments until they intersect. This is the default value.
        case miter = 0
        ///  Indicates the corner should extend past the join point by the minimum amount necessary to form a convex corner. This is functionally equivalent to miter (see above) with a stroke-miterlimit value of 1.
        case crop
        /// Indicates that an arcs corner is to be used to join path segments. The arc's shape is formed by extending the outer edges of the stroke at the join point with arcs that have the same curvature as the outer edges at the join point.
        case arcs
        /// Indicates that a bevelled corner is to be used to join path segments. The bevel is formed by truncating the corner by a line perpendicular to a line that bisects the difference in the subpath angles where they meet the join point.
        case bevel
        /// Indicates that a round corner is to be used to join path segments. This is accomplished by cropping the join as per bevel, and then appending a filled arc tangent in order to round the corner.
        case round
        /// Behaves identically to crop bevel when the stroke-miterlimit value is exceeded.
        case fallback
    }
}

public extension Stroke.LineJoin {
    static var `default`: Self {
        .miter
    }
}

public struct SVGLineJoinResolver {
    public init() {}

    public func lineJoin(from string: some StringProtocol) -> Stroke.LineJoin {
        switch string {
        case "miter":
            .miter

        case "crop":
            .crop

        case "arcs":
            .arcs

        case "bevel":
            .bevel

        case "round":
            .round

        case "fallback":
            .fallback

        default:
            .default
        }
    }
}

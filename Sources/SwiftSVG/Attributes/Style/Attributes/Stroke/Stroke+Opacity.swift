//
//  Created by Kurlovich Vitali on 8/9/26.
//

public extension Stroke {
    /// The stroke-opacity attribute is a presentation attribute defining the opacity of the paint server (color, gradient, pattern, etc.) applied to the stroke of a shape.
    ///
    /// See: [stroke-opacity](https://developer.mozilla.org/en-US/docs/Web/SVG/Reference/Attribute/stroke-opacity)
    struct Opacity: Hashable, Sendable {
        public var value: Float16

        public init(value: Float16 = 1.0) {
            self.value = value
        }
    }
}

public extension Stroke.Opacity {
    static var `default`: Self {
        .init()
    }
}

extension Stroke.Opacity: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Float16) {
        self.init(value: value)
    }
}

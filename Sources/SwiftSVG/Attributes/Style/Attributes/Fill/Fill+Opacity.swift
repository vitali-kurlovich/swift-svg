//
//  Created by Kurlovich Vitali on 8/10/26.
//

public extension Fill {
    /// The fill-opacity attribute is a presentation attribute defining the opacity of the paint server (color, gradient, pattern, etc.) applied to a shape.
    ///
    /// See: [fill-opacity](https://developer.mozilla.org/en-US/docs/Web/SVG/Reference/Attribute/fill-opacity)
    struct Opacity: Hashable, Sendable {
        public var value: Float16

        public init(value: Float16 = 1.0) {
            self.value = value
        }
    }
}

public extension Fill.Opacity {
    static var `default`: Self {
        .init()
    }
}

extension Fill.Opacity: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Float16) {
        self.init(value: value)
    }
}

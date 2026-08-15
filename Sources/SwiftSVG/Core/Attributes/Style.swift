//
//  Created by Kurlovich Vitali on 8/14/26.
//

public struct Style: Hashable, Sendable {
    public var fill: Fill
    public var stroke: Stroke

    @inlinable
    public init(fill: Fill = .default, stroke: Stroke = .default) {
        self.fill = fill
        self.stroke = stroke
    }
}

public extension Style {
    static var `default`: Self {
        .init()
    }
}

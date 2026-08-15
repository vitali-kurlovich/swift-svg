//
//  Created by Kurlovich Vitali on 8/9/26.
//

public struct Fill: Hashable, Sendable {
    public var opacity: Opacity
    public var shading: Shading
    public var rule: Rule

    public init(opacity: Opacity, shading: Shading, rule: Rule) {
        self.opacity = opacity
        self.shading = shading
        self.rule = rule
    }
}

public extension Fill {
    static var `default`: Self {
        .init(opacity: .default, shading: .default, rule: .default)
    }
}

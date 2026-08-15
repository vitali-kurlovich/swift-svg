//
//  Created by Kurlovich Vitali on 8/9/26.
//

public struct Stroke: Hashable, Sendable {
    public var opacity: Opacity = .default
    public var shading: Shading = .default

    public var linecap: LineCap = .default
    public var lineJoin: LineJoin = .default

    public var miterLimit: MiterLimit = .default

    public var width: Width = .default

    public var dashArray: DashArray = .default
    public var dashOffset: DashOffset = .default

    public init(
        opacity: Opacity = .default,
        shading: Shading = .default,
        linecap: LineCap = .default,
        lineJoin: LineJoin = .default,
        miterLimit: MiterLimit = .default,
        width: Width = .default,
        dashArray: DashArray = .default,
        dashOffset: DashOffset = .default,
    ) {
        self.opacity = opacity
        self.shading = shading
        self.linecap = linecap
        self.lineJoin = lineJoin
        self.miterLimit = miterLimit
        self.width = width
        self.dashArray = dashArray
        self.dashOffset = dashOffset
    }
}

public extension Stroke {
    static var `default`: Self {
        .init()
    }
}

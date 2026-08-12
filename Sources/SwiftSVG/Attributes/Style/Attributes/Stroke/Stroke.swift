//
//  Created by Kurlovich Vitali on 8/9/26.
//

public struct Stroke: Hashable, Sendable {
    public var miterLimit: MiterLimit = .default

    public var opacity: Opacity = .default

    public var linecap: LineCap = .default
    public var lineJoin: LineJoin = .default

    public var shading: Shading = .default
}

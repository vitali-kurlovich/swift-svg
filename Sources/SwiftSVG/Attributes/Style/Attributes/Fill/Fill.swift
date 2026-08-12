//
//  Created by Kurlovich Vitali on 8/9/26.
//

public struct Fill: Hashable, Sendable {
    public var opacity: Opacity = .default
    public var rule: Rule = .default

    public var shading: Shading = .default
}

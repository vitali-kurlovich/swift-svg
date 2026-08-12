//
//  Created by Kurlovich Vitali on 8/11/26.
//

public enum Shading: Hashable, Sendable {
    case color(SolidColor)
}

public extension Shading {
    static var `default`: Self {
        .color(.black)
    }
}

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

public extension Shading {
    var isOpaque: Bool {
        switch self {
        case let .color(color):
            color.isOpaque
        }
    }

    var isСlear: Bool {
        switch self {
        case let .color(color):
            color.isСlear
        }
    }
}

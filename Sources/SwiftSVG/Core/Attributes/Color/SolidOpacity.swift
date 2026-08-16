//
//  Created by Kurlovich Vitali on 8/14/26.
//

public struct SolidOpacity: Hashable, Sendable {
    public var value: Float16

    public init(value: Float16 = 1.0) {
        self.value = value
    }
}

public extension SolidOpacity {
    static var `default`: Self {
        .init()
    }
}

extension SolidOpacity: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Float16) {
        self.init(value: value)
    }
}

public extension SolidOpacity {
    var isOpaque: Bool {
        UInt8(truncatingIfNeeded: Int(value * 255)) == 255
    }

    var isСlear: Bool {
        UInt8(truncatingIfNeeded: Int(value * 255)) == 0
    }
}

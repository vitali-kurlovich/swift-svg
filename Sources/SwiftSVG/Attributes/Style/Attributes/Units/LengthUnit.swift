//
//  Created by Kurlovich Vitali on 8/14/26.
//

public enum LengthUnit: Hashable, Sendable {
    case pixel(Double)
    case percent(Double)
}

public extension LengthUnit {
    static var zero: Self {
        .pixel(0)
    }

    static var `default`: Self {
        .pixel(1)
    }
}

extension LengthUnit: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .pixel(value)
    }
}

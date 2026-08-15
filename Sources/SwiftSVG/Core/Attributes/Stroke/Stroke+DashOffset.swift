//
//  Created by Kurlovich Vitali on 8/14/26.
//

public extension Stroke {
    struct DashOffset: Hashable, Sendable {
        public var offset: LengthUnit

        public init(offset: LengthUnit = .zero) {
            self.offset = offset
        }
    }
}

public extension Stroke.DashOffset {
    static var `default`: Self {
        .init()
    }
}

extension Stroke.DashOffset: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self.init(offset: .pixel(value))
    }
}

//
//  Created by Kurlovich Vitali on 8/14/26.
//

public extension Stroke {
    struct DashArray: Hashable, Sendable {
        public var dashes: [LengthUnit]

        public init(dashes: [LengthUnit]) {
            self.dashes = dashes
        }
    }
}

public extension Stroke.DashArray {
    static var `default`: Self {
        .init(dashes: [])
    }
}

extension Stroke.DashArray: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: LengthUnit...) {
        dashes = elements
    }
}

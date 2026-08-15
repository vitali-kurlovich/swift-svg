//
//  Created by Kurlovich Vitali on 8/14/26.
//

public extension Stroke {
    struct Width: Hashable, Sendable {
        public let value: LengthUnit

        public init(_ value: LengthUnit = .default) {
            self.value = value
        }
    }
}

public extension Stroke.Width {
    static var `default`: Self {
        .init()
    }
}

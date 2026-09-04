//
//  Created by Kurlovich Vitali on 9/3/26.
//

import struct CoreGraphics.CGFloat
import struct CoreGraphics.CGRect

public struct LengthUnitResolver {
    public let bounds: CGRect

    public init(bounds: CGRect) {
        self.bounds = bounds
    }
}

public extension LengthUnitResolver {
    func resolve(_ value: LengthUnit) -> CGFloat {
        switch value {
        case let .pixel(value):
            value

        case let .percent(value):
            bounds.normalizedDiagonal * value / 100.0
        }
    }

    func resolve(x: LengthUnit) -> CGFloat {
        switch x {
        case let .pixel(value):
            bounds.minX + value
        case let .percent(value):
            bounds.minX + bounds.width * value / 100.0
        }
    }

    func resolve(y: LengthUnit) -> CGFloat {
        switch y {
        case let .pixel(value):
            bounds.minY + value
        case let .percent(value):
            bounds.minY + bounds.height * value / 100.0
        }
    }

    func resolve(width: LengthUnit) -> CGFloat {
        switch width {
        case let .pixel(value):
            value
        case let .percent(value):
            bounds.width * value / 100.0
        }
    }

    func resolve(height: LengthUnit) -> CGFloat {
        switch height {
        case let .pixel(value):
            value
        case let .percent(value):
            bounds.height * value / 100.0
        }
    }

    func resolve(x: LengthUnit, y: LengthUnit) -> (x: CGFloat, y: CGFloat) {
        (x: resolve(x: x), y: resolve(y: y))
    }

    func resolve(width: LengthUnit, height: LengthUnit) -> (width: CGFloat, height: CGFloat) {
        (width: resolve(width: width), height: resolve(height: height))
    }
}

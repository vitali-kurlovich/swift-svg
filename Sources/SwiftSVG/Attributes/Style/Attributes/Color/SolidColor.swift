//
//  Created by Kurlovich Vitali on 8/10/26.
//

public struct SolidColor: Hashable, Sendable {
    public var red: Float16
    public var green: Float16
    public var blue: Float16
    public var alpha: Float16

    public init(red: Float16 = 0.0, green: Float16 = 0.0, blue: Float16 = 0.0, alpha: Float16 = 1.0) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
}

public extension SolidColor {
    init(
        red: UInt8 = 0,
        green: UInt8 = 0,
        blue: UInt8 = 0,
        alpha: UInt8 = 255,
    ) {
        self.init(red: Float16(red) / Float16(255),
                  green: Float16(green) / Float16(255),
                  blue: Float16(blue) / Float16(255),
                  alpha: Float16(alpha) / Float16(255))
    }
}

public extension SolidColor {
    init(_ hex: UInt32, alpha: Float16 = 1.0) {
        let blue = Float16(hex & 0x0000_00FF) / Float16(255)
        let green = Float16((hex & 0x0000_FF00) >> 8) / Float16(255)
        let red = Float16((hex & 0x00FF_0000) >> 16) / Float16(255)

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

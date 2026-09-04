//
//  Created by Kurlovich Vitali on 9/4/26.
//

public struct Rect: Sendable, Hashable {
    public var x: LengthUnit
    public var y: LengthUnit
    public var width: LengthUnit
    public var height: LengthUnit

    public var rx: LengthUnit
    public var ry: LengthUnit

    public init(
        x: LengthUnit,
        y: LengthUnit,
        width: LengthUnit,
        height: LengthUnit,
        rx: LengthUnit,
        ry: LengthUnit,
    ) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.rx = rx
        self.ry = ry
    }
}

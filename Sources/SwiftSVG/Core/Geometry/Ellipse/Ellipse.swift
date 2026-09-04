//
//  Created by Kurlovich Vitali on 9/3/26.
//

public struct Ellipse: Sendable, Hashable {
    public var cx: LengthUnit
    public var cy: LengthUnit
    public var rx: LengthUnit
    public var ry: LengthUnit

    public init(
        cx: LengthUnit = .zero,
        cy: LengthUnit = .zero,
        rx: LengthUnit = .zero,
        ry: LengthUnit = .zero,
    ) {
        self.cx = cx
        self.cy = cy
        self.rx = rx
        self.ry = ry
    }
}

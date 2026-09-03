//
//  Created by Kurlovich Vitali on 9/3/26.
//

public struct Circle: Sendable, Hashable {
    public var cx: LengthUnit
    public var cy: LengthUnit
    public var r: LengthUnit

    public init(
        cx: LengthUnit = .zero,
        cy: LengthUnit = .zero,
        r: LengthUnit = .zero,
    ) {
        self.cx = cx
        self.cy = cy
        self.r = r
    }
}

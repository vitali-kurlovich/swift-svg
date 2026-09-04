//
//  Created by Kurlovich Vitali on 9/4/26.
//

public struct Use: Sendable, Hashable {
    public var href: String
    public var x: LengthUnit
    public var y: LengthUnit

    public init(href: String, x: LengthUnit, y: LengthUnit) {
        self.href = href
        self.x = x
        self.y = y
    }
}

//
//  Created by Kurlovich Vitali on 8/16/26.
//

import enum CoreGraphics.CGPathFillRule

public extension CGPathFillRule {
    static func rule(from fill: Fill) -> CGPathFillRule {
        rule(from: fill.rule)
    }

    static func rule(from rule: Fill.Rule) -> CGPathFillRule {
        switch rule {
        case .nonzero:
            .winding
        case .evenodd:
            .evenOdd
        }
    }
}

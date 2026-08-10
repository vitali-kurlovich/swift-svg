//
//  Created by Kurlovich Vitali on 8/9/26.
//

public extension SVGStyle {
    var fillRule: Fill.Rule {
        if self["fill-rule"] == "evenodd" {
            return .evenodd
        }
        return .nonzero
    }
}

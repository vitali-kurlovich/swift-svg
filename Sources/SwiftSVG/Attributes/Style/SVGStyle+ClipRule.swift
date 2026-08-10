//
//  Created by Kurlovich Vitali on 8/9/26.
//

public extension SVGStyle {
    var clipRule: ClipRule {
        if self["clip-rule"] == "evenodd" {
            return .evenodd
        }
        return .nonzero
    }
}

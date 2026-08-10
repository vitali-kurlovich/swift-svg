//
//  Created by Kurlovich Vitali on 8/9/26.
//

public extension SVGElement {
    var style: SVGStyle? {
        guard let style = attributes["style"] else {
            return nil
        }

        return SVGStyle(style)
    }
}

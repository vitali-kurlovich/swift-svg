//
//  Created by Kurlovich Vitali on 8/3/26.
//

public extension SVGElement {
    var transform: SVGMatrixAttribute? {
        guard let transform = attributes["transform"] else {
            return nil
        }

        return SVGMatrixAttribute(transform)
    }
}

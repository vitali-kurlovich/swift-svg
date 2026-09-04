//
//  Created by Kurlovich Vitali on 8/16/26.
//

import struct SwiftUI.Color
import struct SwiftUI.GraphicsContext

public extension GraphicsContext.Shading {
    init(stroke: Stroke) {
        self.init(stroke.shading)
    }

    init(fill: Fill) {
        self.init(fill.shading)
    }

    init(_ shading: Shading) {
        switch shading {
        case .none:
            self = .color(Color.clear)
        case let .color(color):
            let color = Color(color)
            self = .color(color)
        }
    }
}

//
//  Created by Kurlovich Vitali on 8/15/26.
//

import struct SwiftUI.Color
import struct SwiftUI.GraphicsContext

extension Color {
    init(_ color: SolidColor) {
        self.init(
            red: Double(color.red),
            green: Double(color.green),
            blue: Double(color.blue),
            opacity: Double(color.alpha),
        )
    }
}

extension GraphicsContext.Shading {
    init(_ shading: Shading) {
        switch shading {
        case let .color(color):
            let color = Color(color)
            self = .color(color)
        }
    }
}

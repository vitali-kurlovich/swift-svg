//
//  Created by Kurlovich Vitali on 8/15/26.
//

import struct SwiftUI.Color

public extension Color {
    init(_ color: SolidColor) {
        self.init(
            red: Double(color.red),
            green: Double(color.green),
            blue: Double(color.blue),
            opacity: Double(color.alpha),
        )
    }
}

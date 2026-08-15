//
//  Created by Kurlovich Vitali on 8/16/26.
//

import struct SwiftUI.FillStyle

public extension FillStyle {
    init(_ rule: Fill.Rule, antialiased: Bool = true) {
        self.init(eoFill: rule == .evenodd, antialiased: antialiased)
    }
}

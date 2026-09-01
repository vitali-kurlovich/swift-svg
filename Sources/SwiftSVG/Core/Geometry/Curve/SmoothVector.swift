//
//  Created by Kurlovich Vitali on 8/13/26.
//

import CoreGraphics

public struct SmoothVector: Sendable, Hashable {
    public var target: CGVector
    public var control2: CGVector

    @inlinable
    public init(to target: CGVector, control2: CGVector) {
        self.target = target
        self.control2 = control2
    }
}

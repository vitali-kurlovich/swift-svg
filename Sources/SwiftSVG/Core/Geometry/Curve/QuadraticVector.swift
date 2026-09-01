//
//  Created by Kurlovich Vitali on 8/13/26.
//

import CoreGraphics

public struct QuadraticVector: Sendable, Hashable {
    public var control1: CGVector
    public var target: CGVector

    @inlinable
    public init(to target: CGVector, control1: CGVector) {
        self.target = target
        self.control1 = control1
    }
}

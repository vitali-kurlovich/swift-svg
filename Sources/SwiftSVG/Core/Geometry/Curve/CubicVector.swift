//
//  Created by Kurlovich Vitali on 8/13/26.
//

import CoreGraphics

public struct CubicVector: Sendable, Hashable {
    public var target: CGVector
    public var control1: CGVector
    public var control2: CGVector

    @inlinable
    public init(to target: CGVector, control1: CGVector, control2: CGVector) {
        self.target = target
        self.control1 = control1
        self.control2 = control2
    }
}

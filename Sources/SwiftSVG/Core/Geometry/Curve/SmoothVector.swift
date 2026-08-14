//
//  Created by Kurlovich Vitali on 8/13/26.
//

public struct SmoothVector: Sendable, Hashable {
    public var control2: Vector
    public var v: Vector

    @inlinable
    public init(control2: Vector, v: Vector) {
        self.control2 = control2
        self.v = v
    }
}

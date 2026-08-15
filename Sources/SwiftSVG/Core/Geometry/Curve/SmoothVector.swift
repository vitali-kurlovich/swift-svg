//
//  Created by Kurlovich Vitali on 8/13/26.
//

public struct SmoothVector: Sendable, Hashable {
    public var target: Vector
    public var control2: Vector

    @inlinable
    public init(to target: Vector, control2: Vector) {
        self.target = target
        self.control2 = control2
    }
}

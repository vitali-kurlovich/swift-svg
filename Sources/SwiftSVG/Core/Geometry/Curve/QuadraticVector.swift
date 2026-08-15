//
//  Created by Kurlovich Vitali on 8/13/26.
//

public struct QuadraticVector: Sendable, Hashable {
    public var control1: Vector
    public var target: Vector

    @inlinable
    public init(to target: Vector, control1: Vector) {
        self.target = target
        self.control1 = control1
    }
}

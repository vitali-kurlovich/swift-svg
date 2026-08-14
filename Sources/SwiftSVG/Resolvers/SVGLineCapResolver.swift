//
//  Created by Kurlovich Vitali on 8/14/26.
//

public struct SVGLineCapResolver {
    public init() {}

    public func lineCap(from string: some StringProtocol) -> Stroke.LineCap {
        switch string.trimmingCharacters(in: .whitespacesAndNewlines) {
        case "butt":
            .butt
        case "round":
            .round
        case "square":
            .square
        default:
            .default
        }
    }
}

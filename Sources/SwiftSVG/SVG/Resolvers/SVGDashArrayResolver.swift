//
//  Created by Kurlovich Vitali on 8/14/26.
//

public struct SVGDashArrayResolver {
    public init() {}

    public func dashArray(from string: some StringProtocol) -> Stroke.DashArray {
        let resolver = SVGLengthUnitResolver()

        let dashes = string.split(characters: .whitespacesNewlinesAndCommma)
            .compactMap {
                resolver.unit(from: $0)
            }

        return Stroke.DashArray(dashes: dashes)
    }
}

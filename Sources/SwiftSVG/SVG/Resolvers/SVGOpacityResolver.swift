//
//  Created by Kurlovich Vitali on 8/14/26.
//

public struct SVGOpacityResolver {
    public init() {}

    public func opacity(from string: some StringProtocol) -> SolidOpacity? {
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmed.hasSuffix("%"), let value = Float16(trimmed.dropLast(1)) {
            return SolidOpacity(value: value / 100.0)
        }

        guard let value = Float16(trimmed) else {
            return nil
        }
        return SolidOpacity(value: value)
    }
}

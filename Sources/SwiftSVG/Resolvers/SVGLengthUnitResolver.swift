//
//  Created by Kurlovich Vitali on 8/14/26.
//

public struct SVGLengthUnitResolver {
    public init() {}

    public func unit(from string: some StringProtocol) -> LengthUnit? {
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmed.hasSuffix("%"), let value = Double(trimmed.dropLast(1)) {
            return .percent(value)
        }

        guard let value = Double(trimmed) else {
            return nil
        }

        return .pixel(value)
    }
}

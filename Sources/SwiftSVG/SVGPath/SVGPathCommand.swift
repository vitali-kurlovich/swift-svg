//
//  Created by Kurlovich Vitali on 8/4/26.
//

public enum SVGPathCommand {
    case move(Point)
    case moveRelative(Vector)

    case line([Point])
    case lineRelative([Vector])

    case horizontal(HorizontalPoint)
    case horizontalRelative(HorizontalVector)

    case vertical(VerticalPoint)
    case verticalRelative(VerticalVector)

    case cubic([CubicPoint])
    case cubicRelative([CubicVector])

    case smooth([SmoothPoint])
    case smoothRelative([SmoothVector])

    case quadratic([QuadraticPoint])
    case quadraticRelative([QuadraticVector])

    case smoothQuadratic([Point])
    case smoothQuadraticRelative([Vector])

    case arc([ArcCurve])
    case arcRelative([ArcOffsetCurve])

    case closePath
}

public struct SVGPathCommands: Sequence {
    public typealias Element = SVGPathCommand
    public typealias Iterator = SVGPathCommandIterator<String>

    public let d: String

    public init(_ string: String) {
        d = string
    }

    public func makeIterator() -> Iterator {
        Iterator(d)
    }
}

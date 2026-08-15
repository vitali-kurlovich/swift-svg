//
//  Created by Kurlovich Vitali on 8/4/26.
//

public enum PathCommand {
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

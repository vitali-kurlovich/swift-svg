//
//  Created by Kurlovich Vitali on 8/4/26.
//

import CoreGraphics

public enum PathCommand {
    case move(CGPoint)
    case moveRelative(CGVector)

    case line([CGPoint])
    case lineRelative([CGVector])

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

    case smoothQuadratic([CGPoint])
    case smoothQuadraticRelative([CGVector])

    case arc([ArcCurve])
    case arcRelative([ArcOffsetCurve])

    case closePath
}

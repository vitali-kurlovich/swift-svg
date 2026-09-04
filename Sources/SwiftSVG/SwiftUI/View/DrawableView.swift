//
//  Created by Kurlovich Vitali on 8/15/26.
//

import MathKit
import SwiftUI

public struct DrawableView: View, Equatable {
    let container: DrawableContainer
    let mode: ViewMode

    public init(
        _ container: DrawableContainer,
        mode: ViewMode = .aspectFit,
    ) {
        self.container = container
        self.mode = mode
    }

    public var body: some View {
        Canvas { context, size in
            var context = context

            context.transform = viewTransform(with: size)
                .concatenating(context.transform)

            context.draw(drawable, bounds: viewBox)

        }.frame(idealWidth: viewBox.width,
                idealHeight: viewBox.height)
    }
}

public enum ViewMode: Hashable, Sendable {
    case center
    case aspectFit
    case aspectFill
    case fill
}

extension DrawableView {
    var viewBox: CGRect {
        container.viewBox
    }

    var drawable: Drawable {
        container.drawable
    }
}

private extension DrawableView {
    func viewTransform(with size: CGSize) -> CGAffineTransform {
        switch mode {
        case .center:
            CGAffineTransform.transform(
                for: viewBox,
                center: CGRect(origin: .zero, size: size),
            )
        case .aspectFill:
            CGAffineTransform.transform(
                for: viewBox,
                aspectFill: CGRect(origin: .zero, size: size),
            )
        case .aspectFit:
            CGAffineTransform.transform(
                for: viewBox,
                aspectFit: CGRect(origin: .zero, size: size),
            )
        case .fill:
            CGAffineTransform.transform(
                for: viewBox,
                fill: CGRect(origin: .zero, size: size),
            )
        }
    }
}

#Preview {
    @Previewable @GestureState
    var scaleFactor: CGFloat = 1.0

    ScrollView([.horizontal, .vertical]) {
        DrawableView(SVGMOCData.rectContainer)
            .frame(width: 800 * scaleFactor, height: 800 * scaleFactor)

    }.frame(width: 800, height: 600).gesture(
        MagnifyGesture()
            .updating($scaleFactor) { value, gestureState, _ in
                gestureState = value.magnification
            },
    )
}

//
//  Created by Kurlovich Vitali on 8/15/26.
//

import SwiftUI

public struct DrawableView: View, Equatable {
    let container: DrawableContainer<CGAffineTransform, CGRect>

    public init(_ container: DrawableContainer<CGAffineTransform, CGRect>) {
        self.container = container
    }

    public var body: some View {
        Canvas { context, size in
            let transform = CGAffineTransform
                .fit(from: viewBox, to: CGRect(origin: .zero, size: size))

            var context = context

            context.transform = transform
                .concatenating(context.transform)

            context.draw(drawable)

        }.frame(idealWidth: viewBox.width,
                idealHeight: viewBox.height)
    }
}

extension DrawableView {
    var viewBox: CGRect {
        container.viewBox
    }

    var drawable: Drawable<CGAffineTransform> {
        container.drawable
    }
}

#Preview {
    ScrollView([.horizontal, .vertical]) {
        DrawableView(SVGMOCData.bunnyContainer)
    }
}

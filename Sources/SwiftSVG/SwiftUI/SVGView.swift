//
//  Created by Kurlovich Vitali on 8/5/26.
//

import SwiftUI

struct CanvasSvgVisitor: SvgVisitor {
    let context: GraphicsContext
    let size: CGSize

    func visit(with context: inout GraphicsContext, tag: PathTag) {
        let path = Path(tag.commands)

        context.fill(path, with: .color(.red))
    }
}

struct SVGView: View {
    let document: SvgDocument

    var viewBox: CGRect {
        document.svg.viewBox
    }

    var body: some View {
        Canvas { context, size in
            let visitor = SvgDocumentVisitor(visitor: CanvasSvgVisitor(context: context, size: size),
                                             document: document)

            visitor.visit()

        }.frame(idealWidth: viewBox.width, idealHeight: viewBox.height)
    }
}

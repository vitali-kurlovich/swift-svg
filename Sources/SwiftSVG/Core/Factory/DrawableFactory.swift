//
//  Created by Kurlovich Vitali on 8/15/26.
//

public protocol DrawableFactory {
    associatedtype Transform: Equatable & Sendable

    func pathDrawable(commands: some Sequence<PathCommand>, style: Style, transform: Transform?) -> Drawable<Transform>
    func groupDrawable(style: Style, transform: Transform?) -> Drawable<Transform>
}

public extension DrawableFactory {
    func groupDrawable(style: Style, transform: Transform?) -> Drawable<Transform> {
        .group(style: style, transform: transform)
    }
}

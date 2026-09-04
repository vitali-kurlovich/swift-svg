//
//  ContentView.swift
//  SVGViewer
//
//  Created by Kurlovich Vitali on 9/4/26.
//

import SwiftSVG
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            DrawableView(SVGMOCData.circleContainer)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

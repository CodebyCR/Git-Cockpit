//
//  MainRectangleView.swift
//  GraphenAutomator
//
//  Created by Christoph Rohde on 29.05.23.
//

import SwiftUI

let gradientColors: [Color] = [.purple, .indigo, .blue, .cyan]

struct MainRectangleView: View {
    let width: CGFloat
    let height: CGFloat
    let gradientColors: [Color]

    @State
    private var isPresented: Bool = false

//    @Environment(\.isPresented) private var isPresented

    var body: some View {
        ZStack {
//            Color.black
//                .opacity(0.6)
//                .ignoresSafeArea()

            RepoGridView()
        }
        .inspector(isPresented: $isPresented) {
            Text("Show details here...")
                .onAppear(perform: {
                    withAnimation(.easeIn(duration: 1.0)) {
                        print("animated")
                    }
                })
        }
        .inspectorColumnWidth(min: 80, ideal: 200, max: 380)
        .toolbar {
            ToolbarView(detailsAreVisible: $isPresented)
        }
    }
}

#Preview("MainRectangleView") {
    MainRectangleView(width: 0.9, height: 0.9, gradientColors: gradientColors)
        .frame(width: 600)
}

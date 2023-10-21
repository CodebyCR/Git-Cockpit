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

    var body: some View {
        ZStack {
            Color.black
                .opacity(0.6)
                .ignoresSafeArea()

            RepoGridView()
                .onAppear(perform: {
                    withAnimation(.easeIn(duration: 1.0)) {
                        print("animated")
                    }
                })

//            SettingsBarView(testList:
//                ["Setting 1", "Setting 2", "Setting 3"])
        }
    }
}

#Preview("MainRectangleView") {
    MainRectangleView(width: 0.9, height: 0.9, gradientColors: gradientColors)
        .frame(width: 600)
}

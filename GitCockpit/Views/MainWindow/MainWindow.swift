//
//  MainWindow.swift
//  GraphenAutomator
//
//  Created by Christoph Rohde on 28.05.23.
//

import SwiftUI

struct CStack<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                content

                Spacer()
            }
            Spacer()
        }
    }
}

struct MainWindow: View {
    let gradientColors: [Color] = [.purple, .indigo, .blue, .cyan]

    var body: some View {
//        ZStack {
//            Color.white

//        CStack {
            MainRectangleView(width: 0.9, height: 0.9, gradientColors: gradientColors)
//        }
//        }
    }
}

struct MainWindow_Previews: PreviewProvider {
    static var previews: some View {
        MainWindow()
    }
}

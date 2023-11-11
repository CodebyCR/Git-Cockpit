//
//  ContentView.swift
//  GraphenAutomator
//
//  Created by Christoph Rohde on 28.05.23.
//

import SwiftUI

struct ContentView: View {
    @State
    private var showSplashScreen = true
    var body: some View {
        ZStack {
            if showSplashScreen {
                SplashScreenView()
                    .transition(.opacity)
                    .animation(
                        .easeOut(duration: 2)
                    )
            }
            else {
                NavigationManagerView()
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            DispatchQueue
                .main
                .asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        self.showSplashScreen = false
                    }
                }
        }
    }
}

#Preview("ContentView") {
    ContentView()
}

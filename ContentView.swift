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
            NavigationManagerView()
                .ignoresSafeArea()
            if showSplashScreen {
                SplashScreenView()
                    .transition(.opacity)
            }
        }
        .onAppear {
            DispatchQueue
                .main
                .asyncAfter(deadline: .now() + 1.2) {
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

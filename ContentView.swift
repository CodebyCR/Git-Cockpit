//
//  ContentView.swift
//  GraphenAutomator
//
//  Created by Christoph Rohde on 28.05.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationManagerView()
            .ignoresSafeArea()
            .onAppear(perform: {
                withAnimation(.easeIn(duration: 1.0)) {
                    print("animated")
                }
            })
    }
}

#Preview("ContentView") {
    ContentView()
}

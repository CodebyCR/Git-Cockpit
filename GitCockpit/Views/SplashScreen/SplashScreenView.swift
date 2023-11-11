//
//  SplashScreenView.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 11.11.23.
//

import Foundation
import SwiftUI

struct SplashScreenView: View {
    @State private var animated = true

    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()

            Image(systemName: "globe") // SFSymbol.gitCockpit
                .font(.largeTitle)
                .colorInvert()
                .frame(width: 140, height: 140)
                .symbolEffect(.bounce, options: .repeat(2).speed(2), value: animated)
                .onAppear {
                    // Starte die Animation zweimal mit einer Verzögerung von 0.5 Sekunden
                    for _ in 0 ..< 2 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            animated.toggle()
                        }
                    }
                }
        }
    }
}

#Preview("SpashScreenView") {
    SplashScreenView()
        .frame(width: 600, height: 400)
}

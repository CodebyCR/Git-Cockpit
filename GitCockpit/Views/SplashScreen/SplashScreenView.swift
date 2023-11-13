//
//  SplashScreenView.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 11.11.23.
//

import Foundation
import SwiftUI

struct SplashScreenView: View {
    @State private var animated = 1

    var body: some View {
        ZStack {
            Color.gray
                .opacity(0.2)
                .shadow(color: .black.opacity(0.6), radius: 30)
                .blur(radius: 30)
                .ignoresSafeArea()

            Image(systemName: "globe") // SFSymbols.gitCockpit
                .resizable()
                .scaledToFit()
                .font(.largeTitle)
                .frame(width: 140, height: 140)
                .symbolEffect(.bounce.up.wholeSymbol,
                              options: .repeat(2).speed(5),
                              value: animated)
        }
        .onAppear {
            animated += 1
        }
    }
}

#Preview("SpashScreenView") {
    SplashScreenView()
        .frame(width: 600, height: 400)
}

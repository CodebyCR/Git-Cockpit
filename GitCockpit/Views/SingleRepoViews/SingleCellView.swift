//
//  SingleCellView.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 23.10.23.
//

import Foundation
import SwiftUI

struct SingleCellView: View {
    @State
    var repo: RepositoryModel

    var body: some View {
        ZStack {
            getGradient()
                .frame(width: 440, height: 200)
                .cornerRadius(30)
            Text("\(repo.name)")
                .foregroundColor(.white)
                .font(.system(size: 30,
                              weight: .medium,
                              design: .rounded))
            VStack {
                Spacer()
                HStack {
                    Button("Show",
                           systemImage: "folder",
                           action: { repo.showLocal() })
                        .buttonStyle(.borderless)
                        .foregroundColor(Color.white)
                        .padding()

                    if repo.remote != nil {
                        Button("Remote",
                               systemImage: "network",
                               action: { repo.showRemote() })
                            .buttonStyle(.borderless)
                            .foregroundColor(Color.white)
                            .padding()
                    }
                }
            }

            HamburgerMenuView(repo: repo)
                .frame(width: 440)
        }
    }

    func getGradient() -> LinearGradient {
        return LinearGradient(
            gradient: Gradient(colors: gradientColors),
            startPoint: .bottomLeading,
            endPoint: .topTrailing
        )
    }
}

#Preview("SingleCellView") {
    SingleCellView(repo: RepositoryModel.getDemoRepos().first!)
        .frame(width: 440, height: 200)
}

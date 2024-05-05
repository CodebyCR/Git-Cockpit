//
//  SingleCellView.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 23.10.23.
//

import Foundation
import SwiftUI

struct SingleRepositoryView: View {
    @State
    var repository: RepositoryModel

    var body: some View {
        ZStack {
            getGradient()
                .frame(width: 440, height: 200)
                .cornerRadius(30)
            VStack {
                Text(repository.getName())
                    .foregroundColor(.white)
                    .font(.system(size: 30,
                                  weight: .medium,
                                  design: .rounded))
                HStack {
                    Text(repository.getCurrentBranchName() ?? "—")
                        .foregroundColor(.white)
                        .font(.system(size: 18,
                                      weight: .medium,
                                      design: .rounded))
                }
            }
            VStack {
                Spacer()
                HStack {
                    Button(LocalizedStringKey("Show"),
                           systemImage: "folder",
                           action: { repository.showLocal() })
                        .buttonStyle(.borderless)
                        .foregroundColor(Color.white)
                        .padding()

                    if repository.remote != nil {
                        Button("Remote",
                               systemImage: "network",
                               action: { repository.showRemote() })
                            .buttonStyle(.borderless)
                            .foregroundColor(Color.white)
                            .padding()
                    }
                }
            }

            /// Todo:
            /// Add RepositoryWrapper Model
            /// With list of selegted tags as observable state

            HamburgerMenuView(repo: repository)
                .frame(width: 440)
        }
//        .modifier(highlightRepo(ifSelected: isSelected))
    }

    func getGradient() -> LinearGradient {
        let gradientColors: [Color] = [.purple, .indigo, .blue, .cyan]
        return LinearGradient(
            gradient: Gradient(colors: gradientColors),
            startPoint: .bottomLeading,
            endPoint: .topTrailing
        )
    }
}

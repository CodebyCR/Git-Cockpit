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
    @State
    var isSelected: Bool

    var body: some View {
        ZStack {
            getGradient()
                .frame(width: 440, height: 200)
                .border(isSelected
                    ? Color.white
                    : Color.clear,
                    width: 2)
                .cornerRadius(30)
            VStack {
                Text(repo.getName())
                    .foregroundColor(.white)
                    .font(.system(size: 30,
                                  weight: .medium,
                                  design: .rounded))
                HStack {
                    Text(repo.getCurrentBranchName() ?? "—")
                        .foregroundColor(.white)
                        .font(.system(size: 18,
                                      weight: .medium,
                                      design: .rounded))
                }
            }
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

// struct highlightRepo: ViewModifier {
//    let isSelected: Bool // Boolean-Eigenschaft für die Modifikation
//
//    init(ifSelected isSelected: Bool) {
//        self.isSelected = isSelected
//    }
//
//    func body(content: Content) -> some View {
//        if isSelected {
//            content
//                .border(Color.white)
//                .cornerRadius(30)
//        }
//    }
// }

// #Preview("SingleCellView") {
//    SingleCellView(
//        repo: RepositoryModel.getDemoRepos().first!,
//        isSelected: true
//    )
//    .frame(width: 440, height: 200)
// }

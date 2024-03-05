//
//  HamburgerMenuView.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 23.10.23.
//

import Foundation
import SwiftUI

struct HamburgerMenuView: View {
    @State
    var repo: RepositoryModel

    @State
    private var isExpanded = false

    var body: some View {
        VStack {
            HStack {
                Menu(content: {
                         Text(LocalizedStringKey("Last access: \(repo.lastAccessDate ?? "-")"))
                     },
                     label: {
                         Image(systemName: "line.3.horizontal")

                     })
                     .colorInvert()
                     .menuStyle(.borderlessButton)
                     .menuIndicator(.hidden)
                     .padding()
            }
            Spacer()
        }
    }
}

// #Preview("HamburgerMenuView") {
//    ZStack {
//        Color.gray
//        HamburgerMenuView(repo: RepositoryModel.getDemoRepos().first!)
//            .frame(width: 440)
//    }
// }

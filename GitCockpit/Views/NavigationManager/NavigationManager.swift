//
//  NavigationManager.swift
//  GraphenAutomator
//
//  Created by Christoph Rohde on 19.10.23.
//

import Foundation
import SwiftUI

struct NavigationManagerView: View {
    @State
    var sideBarVisibility: NavigationSplitViewVisibility = .detailOnly

    @State
    var selectedSidebarItem: SidebarItem = .repositories

    var body: some View {
        NavigationSplitView(columnVisibility: $sideBarVisibility) {
            SidebarView(selectedSidebarItem: $selectedSidebarItem)
//                .onChange(of: selectedSidebarItem) { _ in
//                    // TODO:
//                }
        }
        detail: {
            switch selectedSidebarItem {
            case .repositories:

                MainRectangleView(width: 0.9, height: 0.9, gradientColors: gradientColors)
                    .frame(minWidth: 400, idealWidth: 484)

            default:
                Text("\(selectedSidebarItem.displayName)")
            }
        }
    }
}

#Preview("NavigationManagerView") {
    NavigationManagerView()
}

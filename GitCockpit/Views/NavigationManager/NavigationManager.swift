//
//  NavigationManager.swift
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
                .onChange(of: selectedSidebarItem) { _ in
                    print("SelectedSidebarItem: \(selectedSidebarItem)")
                }
        }
        detail: {
            switch selectedSidebarItem {
            case .repositories:
                MainRectangleView(width: 0.9, height: 0.9, gradientColors: gradientColors)
                    .frame(minWidth: 600, idealWidth: 600)
            case .paths:
                SearchPathsView()
                    .frame(minWidth: 600, idealWidth: 600)

            default:
                Text("\(selectedSidebarItem.displayName)")
            }
        }
    }
}

#Preview("NavigationManagerView") {
    NavigationManagerView()
}

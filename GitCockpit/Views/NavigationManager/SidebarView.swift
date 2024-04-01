//
//  Sidebar.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 21.10.23.
//

import Foundation
import SwiftUI

struct SidebarView: View {
    @Binding
    var selectedSidebarItem: SidebarItem

    var body: some View {
        // TODO: Add more sections and Entries for the SearchPaths
        List(selection: $selectedSidebarItem) {
            Section(
                LocalizedStringKey("Repositorys")
            ) {
                ForEach(SidebarItem.allCases) { selection in
                    Label(selection.displayName, systemImage: selection.icon)
                        .tag(selection)
                }
            }
        }
    }
}

#Preview("SidebarView") {
    SidebarView(selectedSidebarItem: .constant(SidebarItem.repositorys))
        .listStyle(.sidebar)
}

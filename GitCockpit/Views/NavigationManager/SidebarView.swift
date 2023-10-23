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
        List(selection: $selectedSidebarItem) {
            Section("Repositories") {
                ForEach(SidebarItem.allCases) { selection in
                    Label(selection.displayName, systemImage: selection.icon)
                        .tag(selection)
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Image(systemName: "plus.rectangle.on.folder")
                    .foregroundColor(.accentColor)

                Button("Add Path",
                       action: {
                           if let dirPath = chosePath() {
                               GitRepoHandler.listGitDirectories(from: dirPath)
                           }
                           else {
                               print("No path chosen")
                           }
                       })
                       .buttonStyle(.borderless)
                       .frame(maxWidth: .infinity, alignment: .leading)

            }.padding()
        }
    }

    func chosePath() -> String? {
        let dialog = NSOpenPanel()

        dialog.title = "Choose an image | Our Code World"
        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false
        dialog.allowsMultipleSelection = false
        dialog.canChooseDirectories = true
        dialog.canChooseFiles = false

        if dialog.runModal() == NSApplication.ModalResponse.OK {
            if let result = dialog.url { // Pathname of the file
                return result.path

                // path contains the file path e.g
                // /Users/ourcodeworld/Desktop/tiger.jpeg
            }
        }
        return nil
    }
}

#Preview("SidebarView") {
    SidebarView(selectedSidebarItem: .constant(SidebarItem.repositories))
        .listStyle(.sidebar)
}

//
//  GraphenAutomatorApp.swift
//  GraphenAutomator
//
//  Created by Christoph Rohde on 28.05.23.
//

import SwiftUI

@main
struct GitCockpitApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 800, minHeight: 600)
        }
        .commands {
            MyCommandMenu()

            CommandGroup(before: .newItem) {
                Button("Add Path", action: {
                    if let dirPath = chosePath() {
                        GitRepoHandler.listGitDirectories(from: dirPath)
                    }
                    else {
                        print("No path chosen")
                    }
                })
                .keyboardShortcut("n", modifiers: [.command, .shift])
            }
        }
//        .windowStyle(HiddenTitleBarWindowStyle())
    }

    func chosePath() -> String? {
        let dialog = NSOpenPanel()

        dialog.title = "Choose a Folder"
        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false
        dialog.allowsMultipleSelection = false
        dialog.canChooseDirectories = true
        dialog.canChooseFiles = false

        if dialog.runModal() == NSApplication.ModalResponse.OK {
            if let result = dialog.url { // Pathname of the file
                return result.path
            }
        }
        return nil
    }
}

struct MyCommandMenu: Commands {
    var body: some Commands {
        CommandMenu("File", content: {
            Button("Add Path",
                   action: {
                       if let dirPath = chosePath() {
                           GitRepoHandler.listGitDirectories(from: dirPath)
                       }
                       else {
                           print("No path chosen")
                       }
                   })
                   .keyboardShortcut("n", modifiers: [.command, .shift])
                   .buttonStyle(.borderless)
                   .frame(maxWidth: .infinity, alignment: .leading)

//            CommandMenu("Help", content: {
//                Button("Help", action: { print("help") })
//
//                Section("More", content: {
//                    Button("Help2", action: { print("help") })
//                    Button("Help3", action: { print("help") })
//                })
        })
    }

    func chosePath() -> String? {
        let dialog = NSOpenPanel()

        dialog.title = "Choose a Folder"
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

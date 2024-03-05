//
//  DirectoryPicker.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 16.11.23.
//

import SwiftUI

struct DirectoryPicker {
    func chosePath(withDialogTitle dialogTitle: String = String(localized: "Choose a Directory")) -> String? {
        let dialog = NSOpenPanel()

        dialog.title = dialogTitle
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

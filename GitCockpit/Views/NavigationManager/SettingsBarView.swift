//
//  SettingsBarView.swift
//  GraphenAutomator
//
//  Created by Christoph Rohde on 18.10.23.
//

import Foundation
import SwiftUI

import SwiftUI

struct SettingsBarView: View {
    let testList: [String]
    @State
    var selected: String? = nil

    var body: some View {
        ZStack {
            // List view
            List(testList, id: \.self, selection: $selected) { testStr in
                Text(testStr)
                    .onTapGesture {
                        print(testStr)
                        selected = testStr
                    }
            }
            Spacer()

            Button("Profile",
                   systemImage: "person.circle",
                   action: {
                       print("profile")

                   })

            Button("Add Path",
                   systemImage: "plus.rectangle.on.folder",
                   action: {
                       if let dirPath = chosePath() {
                           print(dirPath)
                       }
                       else {
                           print("No path chosen")
                       }
                   })
            
        }.frame(width: 140)
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

#Preview("SettingsBarView") {
    SettingsBarView(testList: ["Setting 1", "Setting 2", "Setting 3"])
}

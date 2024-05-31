//
//  SettingsBarView.swift
//
//  Created by Christoph Rohde on 18.10.23.
//

import Foundation
import SwiftUI

struct SettingsBarView: View {
    let testList: [String]
    @State
    private var selected: String?

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
                   })

        }.frame(minWidth: 180)
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
            }
        }
        return nil
    }
}

#Preview("SettingsBarView") {
    SettingsBarView(testList: ["Setting 1", "Setting 2", "Setting 3"])
}

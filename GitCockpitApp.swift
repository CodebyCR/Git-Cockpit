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
            MenuView()
                .modelContainer(for: SearchPathModel.self)
        }
        .commands {
            CommandMenuView()

            CommandGroup(before: .newItem) {
                AddPathButtonView()
            }
        }
//        .windowStyle(HiddenTitleBarWindowStyle())
    }
}

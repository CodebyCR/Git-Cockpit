//
//  GraphenAutomatorApp.swift
//  GraphenAutomator
//
//  Created by Christoph Rohde on 28.05.23.
//

import SwiftUI

@main
struct GraphenAutomatorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

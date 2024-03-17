////
////  Created by Christoph Rohde on 28.05.23.
////
//
import SwiftData
import SwiftUI

@main
struct GitCockpitApp: App {
    @AppStorage("themeMode") private var themeMode: ThemeMode = .system

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(themeMode == .dark ? .dark : .light)
                .frame(minWidth: 960, minHeight: 600)
                .modelContainer(for: [SearchPathModel.self, TagModel.self])
        }
        .commands {
            CommandMenuView(themeMode: themeMode) { newThemeMode in
                themeMode = newThemeMode
            }

            CommandGroup(before: .newItem) {
                AddPathButtonView()
            }
        }
    }
}

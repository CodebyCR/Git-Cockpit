////
////  Created by Christoph Rohde on 28.05.23.
////
//
import SwiftData
import SwiftUI

@main
struct GitCockpitApp: App {
    @AppStorage("themeMode") private var themeMode: ThemeMode = .system
//    @AppStorage("language") private var language: Language = .english

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(themeMode == .dark ? .dark : .light)
//                .environment(\.locale, language.locale)
                .frame(minWidth: 960, minHeight: 600)
                .modelContainer(for: [
                    RepositoryModel.self,
                    GitConfig.self,
                    RepositoryWrapper.self,
                    SearchPathModel.self,
                    TagModel.self
                ])
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

//
//  MenuCommands.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 16.11.23.
//

import SwiftUI

struct CommandMenuView: Commands {
    private let themeMode: ThemeMode
    private let onThemeChange: (ThemeMode) -> Void

    init(themeMode: ThemeMode, onThemeChange: @escaping (ThemeMode) -> Void) {
        self.themeMode = themeMode
        self.onThemeChange = onThemeChange
        print("Current Theme: \(themeMode)")
    }

    var body: some Commands {
        CommandMenu("File", content: {
            AddPathButtonView()
                .buttonStyle(.borderless)
                .frame(maxWidth: .infinity, alignment: .leading)
        })

        CommandMenu("View", content: {
            Section("Theme") {
                Button {
                    onThemeChange(.dark)
                } label: {
                    Text(String(localized: "Dark"))

                    if themeMode == .dark {
                        Image(systemName: "checkmark")
                    }
                }
                .tag(ThemeMode.dark)
                .foregroundColor(themeMode == .dark ? .white : .primary)
                .background(themeMode == .dark ? Color.primary : Color.clear)

                Button {
                    onThemeChange(.light)
                } label: {
                    if themeMode == .light {
                        Image(systemName: "checkmark")
                    }
                    Text(String(localized: "Light"))
                }
                .tag(ThemeMode.light)
                .foregroundColor(themeMode == .light ? .white : .primary)
                .background(themeMode == .light ? Color.primary : Color.clear)

                Button {
                    onThemeChange(.system)
                } label: {
                    if themeMode == .system {
                        Image(systemName: "checkmark")
                    }
                    Text(String(localized: "System"))
                }
                .tag(ThemeMode.system)
                .foregroundColor(themeMode == .system ? .white : .primary)
                .background(themeMode == .system ? Color.primary : Color.clear)
            }
        })
    }
}

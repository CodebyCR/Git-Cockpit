//
//  MenuCommands.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 16.11.23.
//

import SwiftUI

struct CommandMenuView: Commands {
    @Environment(\.modelContext)
    private var modelContext
    private let dictionaryPicker = DirectoryPicker()
    private var themeMode: ThemeMode = .system

    var body: some Commands {
        CommandMenu("File", content: {
            AddPathButtonView()
                .buttonStyle(.borderless)
                .frame(maxWidth: .infinity, alignment: .leading)

    }
}

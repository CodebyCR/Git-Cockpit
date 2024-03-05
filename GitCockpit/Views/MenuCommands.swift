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

    var body: some Commands {
        CommandMenu("File", content: {
            AddPathButtonView()
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
}

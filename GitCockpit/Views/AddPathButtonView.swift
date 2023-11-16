//
//  AddPathButtonView.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 16.11.23.
//

import SwiftUI

struct AddPathButtonView: View {
    private let dictionaryPicker = DirectoryPicker()
    @Environment(\.modelContext)
    private var modelContext

    var body: some View {
        Button("Add Path", action: {
            if let dirPath = dictionaryPicker.chosePath() {
                let newSearchPathModel = SearchPathModel(path: dirPath)
                modelContext.insert(newSearchPathModel)

                let gitDirectories = GitRepoHandler.listGitDirectories(from: dirPath)
                let gitRepos = GitRepoHandler.createRepositoryModels(FromDirectories: gitDirectories)

                for repo in gitRepos {
                    print("Test: \(repo.name)")
                }
                // TODO: add to Env list
            }
        })
        .keyboardShortcut("n", modifiers: [.command, .shift])
    }
}

#Preview {
    AddPathButtonView()
}

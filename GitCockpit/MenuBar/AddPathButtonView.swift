//
//  AddPathButtonView.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 16.11.23.
//

import SwiftData
import SwiftUI

struct AddPathButtonView: View {
    private let dictionaryPicker = DirectoryPicker()
    @Environment(\.modelContext)
    private var modelContext

    var body: some View {
        Button("", systemImage: "folder.badge.plus", action: {
            if let dirPath = dictionaryPicker.chosePath() {
                let newSearchPath = SearchPathModel(path: dirPath)

                AddPathButtonView.add(SearchPath: newSearchPath, toContext: modelContext)

                let gitRepos = GitRepoHandler.getGitRepositories(from: [newSearchPath])

                for repo in gitRepos {
                    print("Test: \(repo.name)")
                }

            }
        })
        .keyboardShortcut("n", modifiers: [.command, .shift])
    }

    static func add(SearchPath newSearchPathModel: SearchPathModel, toContext modelContext: ModelContext) {
        print("SearchPath: \(newSearchPathModel.path)")
        print("ModelContext: \(modelContext.insertedModelsArray)")

        modelContext.insert(newSearchPathModel)
    }
}

#Preview {
    AddPathButtonView()
}

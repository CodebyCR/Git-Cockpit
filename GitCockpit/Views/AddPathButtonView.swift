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
        Button(String(localized: "Add Path"), action: {
            if let dirPath = dictionaryPicker.chosePath() {
                let newSearchPathModel = SearchPathModel(path: dirPath)
                AddPathButtonView.add(SearchPath: newSearchPathModel, toContext: modelContext)

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

    static func add(SearchPath newSearchPathModel: SearchPathModel, toContext modelContext: ModelContext) {
        print("SearchPath: \(newSearchPathModel.path)")
        print("ModelContext: \(modelContext.insertedModelsArray)")

        modelContext.insert(newSearchPathModel)
    }
}

#Preview {
    AddPathButtonView()
}

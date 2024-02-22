//
//  MainRectangleView.swift
//
//  Created by Christoph Rohde on 29.05.23.
//

import SwiftData
import SwiftUI

struct MainRectangleView: View {
    let width: CGFloat
    let height: CGFloat

    @Query(sort: \SearchPathModel.path)
    private var searchPaths: [SearchPathModel]

    private var repositories: [RepositoryModel] {
        GitRepoHandler.getGitRepositories(ForSeachPaths: searchPaths)
    }

    @State
    private var isPresented: Bool = false

    @State
    private var selectedRepo: RepositoryModel?

    var body: some View {
        ZStack {
            RepoGridView(repos: repositories, selectedRepo: selectedRepo)
        }
        .inspector(isPresented: $isPresented) {
            RepoInspectorView()
        }
        .inspectorColumnWidth(min: 80, ideal: 200, max: 380)
        .toolbar {
            ToolbarView(detailsAreVisible: $isPresented)
        }
    }

//    .onAppear {
//      self.isPresented = selectedRepo != nil
//    }

//    // Aktualisierung des Wrappers, wenn sich selectedObject ändert
//    .onChange(of: selectedObject) { _ in
//      self.isPresented = selectedRepo != nil
//    }
}

#Preview("MainRectangleView") {
    MainRectangleView(width: 0.9, height: 0.9)
        .frame(width: 600)
}

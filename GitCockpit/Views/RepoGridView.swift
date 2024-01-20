//
//  RepoGridView.swift
//
//  Created by Christoph Rohde on 19.10.23.
//

import Foundation
import SwiftData
import SwiftUI

struct RepoGridView: View {
    @State
    private var selectedRepo: RepositoryModel?
//    @Environment(\.modelContext)
//    private var modelContext

    private var repos: [RepositoryModel]
//    = GitRepoHandler.getGitRepositories(ForSeachPaths: searchPaths)
    let gradientColors: [Color] = [.purple, .indigo, .blue, .cyan]

    private let adaptiveColumns = [
        // should be the same like frame width
        GridItem(.adaptive(minimum: 440))
    ]

    init(searchPaths: [SearchPathModel]) {
        self.repos = GitRepoHandler.getGitRepositories(ForSeachPaths: searchPaths)
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                ForEach(repos) { repo in
                    let isSelected = repo == selectedRepo
                    SingleCellView(repo: repo, isSelected: isSelected)
                        .tag(repo)
                }
            }
        }
        .padding()
    }
}

// #Preview("RepoGridView") {
//    RepoGridView()
//        .frame(width: 600)
// }

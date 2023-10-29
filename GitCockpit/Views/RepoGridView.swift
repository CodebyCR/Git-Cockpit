//
//  RepoGridView.swift
//  GraphenAutomator
//
//  Created by Christoph Rohde on 19.10.23.
//

import Foundation
import SwiftUI

struct RepoGridView: View {
    @State
    var selectedRepo: RepositoryModel? = nil
    var repos: [RepositoryModel] = RepositoryModel.getDemoRepos()
    let gradientColors: [Color] = [.purple, .indigo, .blue, .cyan]

    private let adaptiveColumns = [
        // should be the same like frame width
        GridItem(.adaptive(minimum: 440))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                ForEach(RepositoryModel.getDemoRepos()) { repo in
                    let isSelected = repo == selectedRepo
                    SingleCellView(repo: repo, isSelected: isSelected)
                        .tag(repo)
                }
            }
        }
        .padding()
    }
}

#Preview("RepoGridView") {
    RepoGridView()
        .frame(width: 600)
}

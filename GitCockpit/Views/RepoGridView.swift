//
//  RepoGridView.swift
//
//  Created by Christoph Rohde on 19.10.23.
//

import Foundation
import SwiftData
import SwiftUI

struct RepoGridView: View {
    var repos: [RepositoryModel]
    var selectedRepo: RepositoryModel?

    private let adaptiveColumns = [
        // should be the same like frame width
        GridItem(.adaptive(minimum: 440))
    ]

    var body: some View {
        Text("test")
//        ScrollView {
//            LazyVGrid(columns: adaptiveColumns, spacing: 16) {
//                ForEach(repos) { repo in
//                    let isSelected = repo == selectedRepo
//                    SingleCellView(repo: repo, isSelected: isSelected)
//                        .tag(repo)
//                }
//            }
//        }
    }
}

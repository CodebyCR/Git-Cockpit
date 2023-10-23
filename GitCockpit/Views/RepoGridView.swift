//
//  RepoGridView.swift
//  GraphenAutomator
//
//  Created by Christoph Rohde on 19.10.23.
//

import Foundation
import SwiftUI

struct RepoGridView: View {
    var repos: [RepositoryModel] = RepositoryModel.getDemoRepos()
    let gradientColors: [Color] = [.purple, .indigo, .blue, .cyan]

    private let adaptiveColumns = [
        // should be the same like frame width
        GridItem(.adaptive(minimum: 440))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: adaptiveColumns,
                      spacing: 20)
            {
                ForEach(repos, id: \.self) { repo in
                    SingleCellView(repo: repo)
                        .onAppear(perform: {
                            withAnimation(.easeIn(duration: 1.0)) {
                                print("SingleCellView animated")
                            }
                        })
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

//
//  MultiRepositoryView.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 23.03.24.
//

import SwiftData
import SwiftUI

struct MultiRepositoryView: View {
    @Query(sort: \SearchPathModel.path)
    private var searchPaths: [SearchPathModel]

    private let width: CGFloat
    private let height: CGFloat

    var repositorys: [RepositoryWrapper] {
        var repositorys: [RepositoryWrapper] = []

        for repo in GitRepoHandler.getGitRepositories(from: searchPaths) {
            repositorys.append(RepositoryWrapper(model: repo))
        }

        return repositorys
    }

    @State
    var selectedRepository: RepositoryWrapper?

    @State
    private var isPresented: Bool = false

    public init(width: CGFloat = 1.0, height: CGFloat = 1.0) {
        self.width = width
        self.height = height
    }

    private let adaptiveColumns = [
        // should be the same like frame width
        GridItem(.adaptive(minimum: 440))
    ]

    var body: some View {

        ZStack {
            ScrollView {
                LazyVGrid(columns: adaptiveColumns, spacing: 16) {
                    ForEach(repositorys, id: \.self) { repo in
                        if selectedRepository == repo {
                            SingleRepositoryView(repository: repo.model)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 32)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .onTapGesture {
                                    selectedRepository = nil
                                    isPresented = false
                                }
                        }
                        else {
                            SingleRepositoryView(repository: repo.model)
                                .onTapGesture {
                                    selectedRepository = repo
                                    isPresented = true
                                }
                        }
                    }
                }
            }
        }
        .navigationTitle(SidebarRegister.allRepositorys.displayedName)
        .inspector(isPresented: $isPresented) {
            RepoInspectorView(currentRepository: $selectedRepository,
                              tags: getTagsAsBinding(repository: selectedRepository))
        }
        .inspectorColumnWidth(min: 80, ideal: 200, max: 380)
        .toolbar {
            ToolbarView(detailsAreVisible: $isPresented)
        }
    }

    func getTagsAsBinding(repository: RepositoryWrapper?) -> Binding<[TagModel]?> {
        return Binding(get: {
            repository?.tags
        }, set: { newValue in
            repository?.tags = newValue ?? []
        })
    }
}

#Preview {
    MultiRepositoryView()
        .frame(width: 600)
//        .modelContainer(<#T##container: ModelContainer##ModelContainer#>)
}

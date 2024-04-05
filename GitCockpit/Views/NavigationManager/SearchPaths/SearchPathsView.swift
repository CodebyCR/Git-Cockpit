////
////  SearchPathsView.swift
////  Git Cockpit
////
////  Created by Christoph Rohde on 16.11.23.
////

import SwiftData
import SwiftUI

struct SearchPathsView: View {
    @Environment(\.modelContext)
    private var modelContext

    @Query(sort: \SearchPathModel.path, animation: .easeIn)
    var searchPaths: [SearchPathModel]

    var body: some View {
        NavigationStack {
            ScrollView {
                if searchPaths.isEmpty {
                    Spacer()
                    EmptyListView(message: "Add search path",
                                  command: "⇧ ⌘ N")

                } else {
                    ForEach(searchPaths) { searchPath in
                        SingleSearchPathView(searchPathModel: searchPath)
                    }
                }
            }

            .navigationTitle(SidebarRegister.paths.displayedName)
            .toolbar {
                Spacer()
                AddPathButtonView()
            }
        }
    }
}

#Preview {
    SearchPathsView()
        .frame(minHeight: 200)
}

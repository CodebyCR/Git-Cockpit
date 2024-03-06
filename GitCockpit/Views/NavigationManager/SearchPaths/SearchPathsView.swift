//
//  SearchPathsView.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 16.11.23.
//

import SwiftData
import SwiftUI

struct SearchPathsView: View {
    @Environment(\.modelContext)
    private var modelContext

    @Query(sort: \SearchPathModel.path, animation: .easeIn)
    var searchPaths: [SearchPathModel]

    var body: some View {
//        Button {
//            let changelog = GitChangelog()
//            changelog.printAll()
//        } label: {
//            Text("press")
//        }

        ZStack {
            if searchPaths.isEmpty {
                EmptyListView(
                    message: LocalizedStringKey("No search paths chosen"),
                    command: "⇧ ⌘ N")
            } else {
                List(searchPaths) { searchPathModel in
                    HStack {
                        Text(searchPathModel.path)

                        Spacer()

                        Button(action: {
                            modelContext.delete(searchPathModel)
                        }, label: {
                            Text(LocalizedStringKey("Delete"))
                        })
                    }.frame(height: 30)
                }
            }
        }
        .navigationTitle(SidebarItem.paths.displayName)
        .toolbar {
            Spacer()
            AddPathButtonView()
        }
    }
}

#Preview {
    SearchPathsView()
        .frame(minHeight: 200)
}

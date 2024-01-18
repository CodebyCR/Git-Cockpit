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
        ZStack {
            if searchPaths.isEmpty {
                EmptyListView(
                    message: "No search paths chosen",
                    command: "⇧ ⌘ N")
            } else {
                List(searchPaths) { searchPathModel in
                    HStack {
                        Text(searchPathModel.path)

                        Button(action: {
                            modelContext.delete(searchPathModel)
                        }, label: {
                            Text("Delete")
                        })
                    }
                }
            }
        }
        .toolbar {
            Spacer()
            AddPathButtonView()
        }

    }
}

#Preview {
    SearchPathsView()
}

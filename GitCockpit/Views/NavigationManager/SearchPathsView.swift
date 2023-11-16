//
//  SearchPathsView.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 16.11.23.
//

import SwiftData
import SwiftUI

struct SearchPathsView: View {
    @Query(sort: \SearchPathModel.path, animation: .easeIn)
    var searchPaths: [SearchPathModel]

    var body: some View {
        if searchPaths.isEmpty {
            EmptyListView(
                message: "No search paths chosen",
                command: "⇧ ⌘ N")
        } else {
            List(searchPaths) { searchPathModel in
                Text(searchPathModel.path)
            }
        }
//        .onDelete(
//            perform: deleteItems(with: <#T##[ItemIdentifierType]#>)
//        )
    }
}

#Preview {
    SearchPathsView()
}

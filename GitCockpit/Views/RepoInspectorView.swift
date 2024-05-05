//
//  RepoInspectorView.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 10.02.24.
//

import SwiftUI

struct RepoInspectorView: View {
    @Binding
    var currentRepository: RepositoryWrapper?

    @Binding
    var tags: [TagModel]?

    var body: some View {
        if currentRepository == nil {
            Text(LocalizedStringKey("Show details here..."))
                .onAppear(perform: {
                    withAnimation(.easeIn(duration: 1.0)) {
                        print("animated")
                    }
                })
        }
        else {
            Text("More Information about \(currentRepository!.model.getName())")

            MultiTagView(tags: $tags)
        }
    }
}

// #Preview {
//    RepoInspectorView()
// }

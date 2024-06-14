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
        if let currentRepository = currentRepository {
//            Text("More Information about \(String(describing: currentRepository.model?.getName()))")

            ScrollView {
                if let readMe = ReadMe(from: currentRepository.pathToRoot) {
                    ReadMeView(readMe: readMe)
                }

                MultiTagView(tags: $tags)
            }
        }
        else {
            Text(LocalizedStringKey("Show details here..."))
                .onAppear {
                    withAnimation(.easeIn(duration: 1.0)) {
                        print("animated")
                    }
                }

        }
    }
}

// #Preview {
//    RepoInspectorView()
// }

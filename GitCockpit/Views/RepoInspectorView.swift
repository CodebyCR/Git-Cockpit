//
//  RepoInspectorView.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 10.02.24.
//

import SwiftUI

struct RepoInspectorView: View {
    var body: some View {
        Text(LocalizedStringKey("Show details here..."))
            .onAppear(perform: {
                withAnimation(.easeIn(duration: 1.0)) {
                    print("animated")
                }
            })
    }
}

#Preview {
    RepoInspectorView()
}

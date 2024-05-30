//
//  MainRectangleView.swift
//
//  Created by Christoph Rohde on 29.05.23.
//

import SwiftData
import SwiftUI

// deprecated
struct MainRectangleView: View {
    private let width: CGFloat
    private let height: CGFloat

    @Query() // sort: \RepositoryModel
    private var repositories: [RepositoryModel]

    @State
    private var isPresented: Bool = false

    @State
    private var selectedRepo: RepositoryModel?

    public init(width: CGFloat = 1.0, height: CGFloat = 1.0) {
        self.width = width
        self.height = height
    }

    var body: some View {
        ZStack {
            RepoGridView(repos: repositories, selectedRepo: selectedRepo)
        }
        .navigationTitle(SidebarRegister.allRepositorys.displayedName)
        .inspector(isPresented: $isPresented) {
//            RepoInspectorView($)
        }
        .inspectorColumnWidth(min: 80, ideal: 200, max: 380)
        .toolbar {
            ToolbarView(detailsAreVisible: $isPresented)
        }
    }

//    .onAppear {
//      self.isPresented = selectedRepo != nil
//    }

//    // Aktualisierung des Wrappers, wenn sich selectedObject ändert
//    .onChange(of: selectedObject) { _ in
//      self.isPresented = selectedRepo != nil
//    }
}

#Preview("MainRectangleView") {
    MainRectangleView(width: 0.9, height: 0.9)
        .frame(width: 600)
}

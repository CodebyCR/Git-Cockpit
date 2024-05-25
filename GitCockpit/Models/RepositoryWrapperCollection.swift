//
//  RepositoryWrapperCollection.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 05.04.24.
//

import Foundation

class RepositoryWrapperCollection: Identifiable {
    let id: UUID
    let displayedName: String
    var repositoryWrappers: [RepositoryWrapper]

    init(displayedName: String, repositoryWrappers: [RepositoryWrapper]) {
        self.id = UUID()
        self.displayedName = displayedName
        self.repositoryWrappers = repositoryWrappers
    }
}

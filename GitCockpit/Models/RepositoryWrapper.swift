//
//  RepositoryWrapper.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 23.03.24

import Foundation
import SwiftData

//@Model
class RepositoryWrapper: Identifiable, Equatable, Hashable {
    let id: UUID

//    @Relationship(deleteRule: .noAction)
    var tags: [TagModel]

//    @Relationship(deleteRule: .cascade)
    var model: RepositoryModel

    // new RepositoryWrapper
    init(model: RepositoryModel) {
        self.id = UUID()
        self.model = model
        self.tags = []
    }

//    func isValid() -> Bool {
//        let modelPath = model.pathToRoot
//        // chech if path to repo still exists
//        // ...
//    }

    static func == (lhs: RepositoryWrapper, rhs: RepositoryWrapper) -> Bool {
        lhs.model.pathToRoot == rhs.model.pathToRoot
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(model.pathToRoot)
    }
}

//
//  RepositoryWrapper.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 23.03.24

import Foundation
import SwiftData

@Model
class RepositoryWrapper: Identifiable, Equatable, Hashable {
    let id: UUID

    @Relationship(deleteRule: .noAction)
    var tags: [TagModel]

    @Relationship(deleteRule: .cascade)
    var pathToRoot: String

    public var model: RepositoryModel? {
        get{
            RepositoryModel(from: pathToRoot)
        }
    }

    // new RepositoryWrapper
    init(pathToRoot: String) {
        self.id = UUID()
        self.pathToRoot = pathToRoot
        self.tags = []
    }

//    func isValid() -> Bool {
//        let modelPath = model.pathToRoot
//        // chech if path to repo still exists
//        // ...
//    }

    static func == (lhs: RepositoryWrapper, rhs: RepositoryWrapper) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

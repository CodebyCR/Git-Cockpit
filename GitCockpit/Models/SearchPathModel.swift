//
//  SearchPathModel.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 14.11.23.
//

import Foundation
import SwiftData

@Model
class SearchPathModel: Identifiable, Hashable {
    let path: String

    init(path: String) {
        self.path = path
    }

    static func == (lhs: SearchPathModel, rhs: SearchPathModel) -> Bool {
        return lhs.path == rhs.path
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(path)
    }
}

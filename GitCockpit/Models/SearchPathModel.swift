//
//  SearchPathModel.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 14.11.23.
//

import Foundation
import SwiftData

@Model
class SearchPathModel: Equatable {
    @Attribute(.unique)
    let path: String
    let displayName: String

    init(path: String) {
        self.path = path
        self.displayName = URL(fileURLWithPath: path).lastPathComponent
    }

    static func == (lhs: SearchPathModel, rhs: SearchPathModel) -> Bool {
        return lhs.path == rhs.path
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(path)
    }

    var sidebarRegister: SidebarRegister {
        return SidebarRegister(displayedName: displayName, icon: "folder")
    }
}

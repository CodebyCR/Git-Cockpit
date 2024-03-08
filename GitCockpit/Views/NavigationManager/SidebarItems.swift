//
//  SidebarItems.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 21.10.23.
//

import SwiftUI

struct SidebarItem: Identifiable, CaseIterable, Hashable {
    let id: UUID = .init()
    let icon: String
    let displayName: LocalizedStringKey

    private init(icon: String, displayName: LocalizedStringKey) {
        self.icon = icon
        self.displayName = displayName
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static let repositorys = SidebarItem(icon: "star", displayName: "Repositorys")
    static let paths = SidebarItem(icon: "folder", displayName: "Search Paths")
    static let gitConfig = SidebarItem(icon: "person.text.rectangle", displayName: "Git Configuration")

    static var allCases: [SidebarItem] {
        return [repositorys, paths, gitConfig]
    }

    static func == (lhs: SidebarItem, rhs: SidebarItem) -> Bool {
        return lhs.id == rhs.id
    }
}

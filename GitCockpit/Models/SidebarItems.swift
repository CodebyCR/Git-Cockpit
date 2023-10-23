//
//  SidebarItems.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 21.10.23.
//

import Foundation


struct SidebarItem: Identifiable, CaseIterable, Hashable {
    let id: UUID = .init()
    let icon: String
    let displayName: String

    private init(icon: String, displayName: String) {
        self.icon = icon
        self.displayName = displayName
    }

    static let repositories = SidebarItem(icon: "star", displayName: "My Repositories")
    static let paths = SidebarItem(icon: "folder", displayName: "Paths")

    static var allCases: [SidebarItem] {
        return [repositories, paths]
    }

    static func == (lhs: SidebarItem, rhs: SidebarItem) -> Bool {
        return lhs.id == rhs.id
    }
}
//
//  SidebarRegister.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 05.04.24.
//

import Foundation
import SwiftData

class SidebarRegister: Identifiable, Hashable {
    var id: String
    var displayedName: String
    var icon: String
    var path: String?

    init(displayedName: String, icon: String) {
        self.id = UUID().uuidString
        self.displayedName = String(displayedName)
        self.icon = icon
    }

    convenience init(path: String) {
        self.init(displayedName: URL(fileURLWithPath: path).lastPathComponent, icon: "folder")
        self.path = path
    }

    static func == (lhs: SidebarRegister, rhs: SidebarRegister) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension SidebarRegister {
    static let allRepositorys = SidebarRegister(
        displayedName: String(localized: "All Repositorys"),
        icon: "folder")

    static let paths = SidebarRegister(
        displayedName: String(localized: "Search Paths"),
        icon: "folder")

    static let tags = SidebarRegister(
        displayedName: String(localized: "Tags"),
        icon: "tag")

    static let gitConfig = SidebarRegister(
        displayedName: String(localized: "Git Configuration"),
        icon: "person.text.rectangle")

    private static var allCases: [SidebarRegister] = []
    private static var searchPathRegister: [SidebarRegister] = []

    static func allRepositoryCases() -> [SidebarRegister] {
        allCases.append(.allRepositorys)

        allCases.append(contentsOf: searchPathRegister)
        print("Use all cases")
        return allCases
    }

    public static func addSearchPathRegister(_ path: String) {
        let searchRegister = SidebarRegister(path: path)
        searchPathRegister.append(searchRegister)
        searchPathRegister.sort(by: { $0.displayedName < $1.displayedName })
        print("Count \(searchPathRegister.count)")
    }

//    static func allRepositoryCase(searchPaths: [SearchPathModel]) -> [SidebarRegister] {
//        var allCases: [SidebarRegister] = []
//
//        return allCases
//    }

    static func allOtherCases() -> [SidebarRegister] {
        [.paths, .tags, .gitConfig]
    }
}

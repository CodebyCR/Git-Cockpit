//
//  Sidebar.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 21.10.23.
//

import SwiftData
import SwiftUI

struct SidebarView: View {
    @Query(sort: \SearchPathModel.path)
    var searchPaths: [SearchPathModel]

    @State
    var repositorySidebarRegister = SidebarRegister.allRepositoryCases(additionalCases: []) // TODO: Add folder from searchPaths

    @State
    var sidebarConfigurationRegisters = SidebarRegister.allOtherCases()

    @Binding
    var selectedSidebarRegister: SidebarRegister

    var body: some View {
        List(selection: $selectedSidebarRegister) {
            Section(String(localized: "Repositorys")) {
                ForEach(repositorySidebarRegister, id: \.id) { register in
                    Label(register.displayedName, systemImage: register.icon)
                        .tag(register)
                }
            }

            Section(String(localized: "Configuartion")) {
                ForEach(sidebarConfigurationRegisters) { sidebarItem in
                    Label(sidebarItem.displayedName, systemImage: sidebarItem.icon)
                        .tag(sidebarItem)
                }
            }
        }
    }
}

#Preview("SidebarView") {
    SidebarView(selectedSidebarRegister: .constant(SidebarRegister.tags))
        .listStyle(.sidebar)
}

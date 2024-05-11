//
//  NavigationManager.swift
//
//  Created by Christoph Rohde on 19.10.23.
//

import SwiftData
import SwiftUI

struct NavigationManagerView: View {
//    @Environment(TagModel.self)
//    private var tagModel

    @State
    private var sideBarVisibility: NavigationSplitViewVisibility = .detailOnly

    @State
    private var selectedTag: String = SidebarRegister.allRepositorys.displayedName

    @State
    private var repositorySidebarRegister = SidebarRegister.allRepositoryCases()

    @State
    private var sidebarConfigurationRegisters = SidebarRegister.allOtherCases()

    @Query(animation: .snappy)
    private var searchPaths: [SearchPathModel] // sort: \SearchPathModel.path,

    var body: some View {
        NavigationSplitView(columnVisibility: $sideBarVisibility) {
            List(selection: $selectedTag) {
                Section(String(localized: "Repositorys")) {
                    ForEach(repositorySidebarRegister, id: \.self) { register in
                        Label(register.displayedName, systemImage: register.icon)
                            .foregroundStyle(selectedTag == register.displayedName ? Color.primary : .gray)
                            .tag(register.displayedName)
                    }
                }

//                Section(String(localized: "Search Paths")) {
//                    ForEach(searchPaths) {
//                        Label($0.displayedName, systemImage: "folder")
//                            .foregroundStyle(selectedTag == $0.displayedName ? Color.primary : .gray)
//                            .tag($0.displayedName)
//                        }
//                    }

                Section(String(localized: "Configuartion")) {
                    ForEach(sidebarConfigurationRegisters, id: \.self) { sidebarItem in
                        Label(sidebarItem.displayedName, systemImage: sidebarItem.icon)
                            .foregroundStyle(selectedTag == sidebarItem.displayedName ? Color.primary : .gray)
                            .tag(sidebarItem.displayedName)
                    }
                }
            }
            .onChange(of: selectedTag, initial: true) {
                print("SelectedSidebarItem: \(selectedTag)")
            }
        }
        detail: {
            switch selectedTag {
            case SidebarRegister.allRepositorys.displayedName:
                MultiRepositoryView()
                    .frame(minWidth: 600, idealWidth: 600)

            case SidebarRegister.paths.displayedName:
                SearchPathsView()
                    .frame(minWidth: 600, idealWidth: 600)

            case SidebarRegister.gitConfig.displayedName:
                GitConfigView()
                    .frame(minWidth: 600, idealWidth: 600)

            case SidebarRegister.tags.displayedName:
                TagConfigView()
                    .frame(minWidth: 600, idealWidth: 600)

            default:
                Text(selectedTag)
            }
        }
    }
}

#Preview("NavigationManagerView") {
    NavigationManagerView()
}

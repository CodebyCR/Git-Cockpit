//
//  NavigationManager.swift
//  GraphenAutomator
//
//  Created by Christoph Rohde on 19.10.23.
//

import Foundation
import SwiftUI

enum SideBarItem: String, Identifiable, CaseIterable {
    var id: String { rawValue }
    case repositories
//    case animals
//    case food
}

struct NavigationManagerView: View {
    @State
    var sideBarVisibility: NavigationSplitViewVisibility = .detailOnly

    @State
    var selectedSideBarItem: SideBarItem = .repositories

    var body: some View {
        NavigationSplitView(columnVisibility: $sideBarVisibility) {
            List(SideBarItem.allCases, selection: $selectedSideBarItem) { item in
                NavigationLink(
                    item.rawValue.localizedCapitalized,
                    value: item
                )
            }
            .onChange(of: selectedSideBarItem) { _ in
                // TODO:
            }
        }

        detail: {
            switch selectedSideBarItem {
            case .repositories:
                MainRectangleView(width: 0.9, height: 0.9, gradientColors: gradientColors)
                    .onAppear(perform: {
                        withAnimation(.easeIn(duration: 1.0)) {
                            print("animated")
                        }
                    })
            }

            //            if let detailItem = selectedDetailItem {
            //                switch detailItem {
            //                case .user(let user):
            //                    UserDetailsView(user: user)
            //                case .animal(let animal):
            //                    AnimalDetailsView(animal: animal)
            //                case .food(let food):
            //                    FoodDetailsView(food: food)
            //                }
            //            }
        }
    }
}

#Preview("NavigationManagerView") {
    NavigationManagerView()
}

//
//  NavigationManager.swift
//  GraphenAutomator
//
//  Created by Christoph Rohde on 19.10.23.
//

import Foundation
import SwiftUI

struct NavigationManagerView: View {
    @State
    var sideBarVisibility: NavigationSplitViewVisibility = .detailOnly

    @State
    var selectedSidebarItem: SidebarItem = .repositories

    var body: some View {
        NavigationSplitView(columnVisibility: $sideBarVisibility) {
            SidebarView(selectedSidebarItem: $selectedSidebarItem)
                .onChange(of: selectedSidebarItem) { _ in
                    // TODO:
                }
        }

        detail: {
            switch selectedSidebarItem {
            case .repositories:
                MainRectangleView(width: 0.9, height: 0.9, gradientColors: gradientColors)
                    .onAppear(perform: {
                        withAnimation(.easeIn(duration: 1.0)) {
                            print("animated")
                        }
                    })
            default:
                Text("default")
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

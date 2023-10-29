//
//  ToolbarView.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 29.10.23.
//

import Foundation
import SwiftUI

struct ToolbarView: View {
    @Binding
    var detailsAreVisible: Bool

    var body: some View {
        Spacer()

        Button {
            detailsAreVisible.toggle()
        }
        label: {
            Label("Info", systemImage: "info.circle")
        }
    }
}

//
//  EmptyListView.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 16.11.23.
//

import SwiftUI

struct EmptyListView: View {
    let message: String
    let command: String

    var body: some View {
        Spacer()
        HStack {
            Spacer()
            Text(message)
                .font(.title)
            Text(command)
                .foregroundStyle(.gray)
            Spacer()
        }
        Spacer()
    }
}

#Preview {
    EmptyListView(message: "No search paths chosen", command: "⇧ ⌘ N")
}

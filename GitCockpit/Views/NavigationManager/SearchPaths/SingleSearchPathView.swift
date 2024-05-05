//
//  SingleSearchPathView.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 08.03.24.
//

import SwiftUI

enum PathActions: CaseIterable {
    case cloneGitRepo
    case remove

    static var allCases: [PathActions] {
        return [.cloneGitRepo, .remove]
    }
}

struct SingleSearchPathView: View {
    @Environment(\.modelContext) private var modelContext
    @State var searchPathModel: SearchPathModel

    var body: some View {
        VStack {
            HStack {
                Text(searchPathModel.path)
                Spacer()
                HStack {
                    Menu("Path Action") {
                        Button {
                            // Implement actual cloning logic here
                        } label: {
                            Text("Clone into Path")
                            Image(systemName: "plus")
                                .foregroundColor(.green)
                        }

                        Divider()

                        Button {
                            modelContext.delete(searchPathModel)
                        } label: {
                            Text("Remove")
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                    .menuStyle(.borderedButton)
                }.frame(width: 200)
            }
            Divider()
        }
        .padding()
    }
}

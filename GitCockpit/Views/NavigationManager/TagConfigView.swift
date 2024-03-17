//
//  TagConfigView.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 17.03.24.
//

import SwiftData
import SwiftUI

struct TagConfigView: View {
    @Query(sort: \TagModel.name, animation: .easeIn)
    var createdTags: [TagModel]

    @State
    var newTagName: String = ""

    @State
    var newTagColor: Color = .random()

    var body: some View {
        VStack {
            HStack {
                Text(String(localized: "Tag Name"))
                    .padding(.leading, 8)
                    .padding(.trailing, -4)

                TextField(
                    String(localized: "Tag Name"),
                    text: $newTagName)
                    .textFieldStyle(.roundedBorder)
//                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)

                Spacer()
            }
            HStack {
                ColorPicker(
                    String(localized: "Tag Color"),
                    selection: $newTagColor)
                    .padding(.horizontal, 8)

                Spacer()

                CreateTagView(
                    newTagName: $newTagName,
                    newTagColor: $newTagColor,
                    createdTags: createdTags)
            }
        }.padding(.horizontal, 8)
        List {
            ForEach(createdTags) { tag in
                HStack {
                    SingleTagView(tag: tag)

                    Spacer()

                    DeleteTagView(tagToDelete: tag)
                }
            }
        }
    }
}

#Preview {
    TagConfigView()
        .modelContainer(for: TagModel.self, inMemory: true)
}

struct DeleteTagView: View {
    let tagToDelete: TagModel

    @Environment(\.modelContext)
    private var modelContext

    var body: some View {
        Button(
            String(localized: "Delete"),
            action: {
                modelContext.delete(tagToDelete)
            })
    }
}

struct CreateTagView: View {
    @Binding var newTagName: String
    @Binding var newTagColor: Color
    var createdTags: [TagModel]

    @Environment(\.modelContext)
    private var modelContext

    var body: some View {
        Button(
            String(localized: "Create Tag"),
            action: createTag)
            .padding(.horizontal, 8)
    }

    func createTag() {
        let newTag = TagModel(
            name: newTagName,
            color: newTagColor)

        // TODO: Check for not empty

        if nameAlreadyExists(name: newTagName, in: createdTags) {
            // shack animation
            return
        }

        modelContext.insert(newTag)
    }

    func nameAlreadyExists(name: String, in tags: [TagModel]) -> Bool {
        return tags.filter { $0.name == name }.count > 0
    }
}

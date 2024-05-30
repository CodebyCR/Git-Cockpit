//
//  TagConfigView.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 17.03.24.
//

import SwiftData
import SwiftUI

struct Shake: GeometryEffect {
    var amount: CGFloat = 8
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)), y: 0))
    }
}

struct TagConfigView: View {
    @Query(sort: \TagModel.name, animation: .easeIn)
    var createdTags: [TagModel]

    @State
    var newTagName: String = ""

    @State
    var newTagColor: Color = .random()

    @State
    var shake: Int = 0

    @Environment(\.modelContext)
    private var modelContext

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
                    .padding(.vertical, 4)
                    .modifier(Shake(animatableData: CGFloat(shake)))
                    .onSubmit {
                        if !createTag() {
                            withAnimation(.default) {
                                shake += 1
                            }
                        }
                    }

                Spacer()
            }
            HStack {
                ColorPicker(
                    String(localized: "Tag Color"),
                    selection: $newTagColor)
                    .padding(.horizontal, 8)

                Spacer()

                Button(String(localized: "Create Tag")) {
                    if !createTag() {
                        withAnimation(.default) {
                            shake += 1
                        }
                    }
                }
                .padding(.horizontal, 8)
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
        .navigationTitle(SidebarRegister.tags.displayedName)
    }

    func createTag() -> Bool {
        let newTag = TagModel(
            name: newTagName,
            color: newTagColor)

        if newTagName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }

        if nameAlreadyExists(name: newTagName, in: createdTags) {
            // shack animation
            return false
        }

        modelContext.insert(newTag)

        return true
    }

    func nameAlreadyExists(name: String, in tags: [TagModel]) -> Bool {
        return tags.filter { $0.name == name }.count > 0
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

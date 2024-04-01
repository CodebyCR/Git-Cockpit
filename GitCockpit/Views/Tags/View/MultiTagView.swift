import SwiftUI

struct MultiTagView: View {
    @Binding
    var tags: [TagModel]?

    @State private var showingPopover = false

    var body: some View {
        HStack {
            ForEach(tags ?? []) { tag in
                SingleTagView(tag: tag)
            }

            Image(systemName: "plus")
                .font(.title3)
                .foregroundColor(.blue)
                .padding(6)
                .background(.blue.opacity(0.3))
                .cornerRadius(40)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(.blue, lineWidth: 1)
                )
                .padding(4)
                .onTapGesture {
                    addTag()
                }
                .popover(isPresented: $showingPopover) {
                    SelectTagPopupView(selectedTags: getTagsAsBinding(tags: tags))
                }
        }
    }

    func addTag() {
        withAnimation(.spring) {
            print("Open Popup")
            showingPopover = true
        }
    }

    func getTagsAsBinding(tags: [TagModel]?) -> Binding<[TagModel]> {
        return Binding(get: {
            tags ?? []
        }, set: { newValue in
            self.tags = newValue
        })
    }
}

// #Preview("Multi Tags") {
//    MultiTagView(tags:
//        [TagModel(name: "Bugfix"),
//         TagModel(name: "C++"),
//         TagModel(name: "GitHub"),
//         TagModel(name: "Feature"),
//         TagModel(name: "Java")]
//    )
// }

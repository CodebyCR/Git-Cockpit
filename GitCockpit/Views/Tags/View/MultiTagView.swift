import SwiftUI

struct MultiTagView: View {
    var tags: [TagModel]

    public init(tags: [TagModel]) {
        self.tags = tags
    }

    var body: some View {
        HStack {
            ForEach(tags) { tag in
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
                        .stroke(.blue, lineWidth: 2)
                )
                .padding(4)
                .onTapGesture {
                    addTag()
                }
        }
    }

    func addTag() {
        print("Add tag")
    }
}

#Preview("Multi Tags") {
    MultiTagView(tags:
        [TagModel(name: "Bugfix"),
         TagModel(name: "C++"),
         TagModel(name: "GitHub"),
         TagModel(name: "Feature"),
         TagModel(name: "Java", color: .orange)]
    )
}

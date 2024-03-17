import SwiftUI

struct MultiTagView: View {
    var tags: [TagModel]

    public init(tags: [TagModel]) {
        self.tags = tags
    }

    var body: some View {
        HStack {
            ForEach(tags) { tag in
                Text(tag.name)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(tag.color)
                    .cornerRadius(10)
            }
            Spacer()
        }
    }
}

#Preview("Multi Tags") {
    MultiTagView(tags:
        [TagModel(name: "Bugfix"),
         TagModel(name: "C++"),
         TagModel(name: "GitHub"),
         TagModel(name: "Feature")]
    )
}

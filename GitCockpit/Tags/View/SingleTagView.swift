import SwiftUI

struct SingleTagView: View {
    var tag: TagModel
    var body: some View {
        HStack {
            Text(tag.name)
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(tag.color)
                .cornerRadius(10)
            Spacer()
        }
    }
}

#Preview("Single Tag") {
    SingleTagView(tag: TagModel(name: "Bugfix"))
}

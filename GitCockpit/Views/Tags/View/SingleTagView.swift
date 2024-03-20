import SwiftUI

struct SingleTagView: View {
    var tag: TagModel

    var body: some View {
        Text(tag.name)
            .font(.title3)
            .foregroundColor(tag.color.color)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(tag.color.color.opacity(0.2))
            .cornerRadius(32)
            .overlay(
                RoundedRectangle(cornerRadius: 32)
                    .stroke(tag.color.color.opacity(0.85), lineWidth: 2)
            )
            .padding(4)
    }
}

#Preview("Single Tag") {
    SingleTagView(tag:
        TagModel(name: "Bugfix")
    )
}

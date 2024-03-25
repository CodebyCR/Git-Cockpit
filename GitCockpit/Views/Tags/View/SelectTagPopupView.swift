//
//  SelectTagPopupView.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 20.03.24.
//

import SwiftData
import SwiftUI

struct SelectTagPopupView: View {
    @Query(sort: \TagModel.name, animation: .easeInOut)
    private let allTags: [TagModel]

    @Binding
    var selectedTags: [TagModel]

    var body: some View {
        List(allTags) { tag in
            HStack {
                SingleTagView(tag: tag)
                Spacer()
                if selectedTags.contains(tag) {
                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                } else {
                    Image(systemName: "xmark")
                        .foregroundColor(.red)
                }
            }
            .onTapGesture {
                withAnimation(.spring(duration: 0.4)) {
                    if selectedTags.contains(tag) {
                        selectedTags.removeAll(where: { $0 == tag })
                    } else {
                        selectedTags.append(tag)
                    }
                }
            }
        }
    }
}

//#Preview {
//    SelectTagPopupView(selectedTags: $[])
//        .modelContainer(for: TagModel.self, inMemory: true)
//}

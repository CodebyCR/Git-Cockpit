//
//  ReadMeView.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 13.06.24.
//

import SwiftUI
import MarkdownUI

struct ReadMeView: View {
    public let readMe: ReadMe

    var body: some View {

        if let readMeContent = readMe.getContent() {
            Markdown(readMeContent)
                .markdownTheme(.gitHub)
        }
        else {
            Text("ReadMe content anavailable.")
        }

    }
}

//#Preview {
//    ReadMeView()
//}

//
//  ReadMeView.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 13.06.24.
//

import SwiftUI

struct ReadMeView: View {
    public let readMe: ReadMe

    var body: some View {

        if let readMeContent = readMe.getContent() {
            Text(readMeContent)
        }
        else {
            Text("ReadMe content anavailable.")
        }

    }
}

//#Preview {
//    ReadMeView()
//}

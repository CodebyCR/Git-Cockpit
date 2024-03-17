//
//  TagModel.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 17.03.24.
//

import SwiftData
import SwiftUI

struct ColorComponents: Codable {
    let red: Double
    let green: Double
    let blue: Double

    var color: Color {
        Color(red: red, green: green, blue: blue)
    }

    static func fromColor(_ color: Color) -> ColorComponents {
        let resolved = color.getRGB()
        return ColorComponents(
            red: resolved.0,
            green: resolved.1,
            blue: resolved.2
        )
    }
}

@Model
class TagModel: Identifiable {
    let id: UUID
    @Attribute(.unique)
    let name: String
    var color: ColorComponents

    init(name: String) {
        id = UUID()
        self.name = name
        color = ColorComponents.fromColor(.random())
    }

    init(name: String, color: Color) {
        id = UUID()
        self.name = name
        self.color = ColorComponents.fromColor(color)
    }
}

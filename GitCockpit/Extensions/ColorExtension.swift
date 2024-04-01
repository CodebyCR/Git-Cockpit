//
//  ColorExtension.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 17.03.24.
//
import SwiftUI

extension Color {
    // return a new generated Color
    static func random() -> Color {
        let red = Double.random(in: 0..<1)
        let green = Double.random(in: 0..<1)
        let blue = Double.random(in: 0..<1)
        return Color(red: red, green: green, blue: blue)
    }

    func getRGB() -> (Double, Double, Double) {
        guard let components = cgColor?.components else {
            return (0, 0, 0)
        }
        let red = Double(components[0])
        let green = Double(components[1])
        let blue = Double(components[2])
        return (red, green, blue)
    }

    func toHex() -> String {
        let components = self.cgColor?.components
        let red = Int(components![0] * 255)
        let green = Int(components![1] * 255)
        let blue = Int(components![2] * 255)
        return String(format: "#%02X%02X%02X", red, green, blue)
    }

    static func fromHex(_ hex: String) -> Color {
        var hex = hex
        if hex.hasPrefix("#") {
            hex.remove(at: hex.startIndex)
        }
        if hex.count != 6 {
            return Color.white
        }
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)
        return Color(
            red: Double((rgb & 0xFF0000) >> 16) / 255.0,
            green: Double((rgb & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgb & 0x0000FF) / 255.0
        )
    }
}

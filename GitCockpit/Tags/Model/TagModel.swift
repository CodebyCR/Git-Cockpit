//
//  TagModel.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 17.03.24.
//

import Foundation

class TagModel {
    let id: UUID
    let name: String
    var color: (Double, Double, Double) {
        get {
            // Berechnen Sie den Farbwert (z.B. basierend auf anderen Eigenschaften)
            (0.32, 0.32, 0.82)
        }
        set {
            // Aktualisieren Sie den Farbwert
            
        }
    }

    init(name: String) {
        self.id = UUID()
        self.name = name
    }

    init(name: String, color: (Double, Double, Double)) {
        self.id = UUID()
        self.name = name
        self.color = color
    }

    /// Setzt eine neue generierte Farbe für das Tag
    func getRandomColor() {
        let red = Double.random(in: 0...255) / 255.0
        let green = Double.random(in: 0...255) / 255.0
        let blue = Double.random(in: 0...255) / 255.0

        color = (red, green, blue)
    }
}

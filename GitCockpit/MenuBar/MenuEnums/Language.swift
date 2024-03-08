//
//  Languages.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 08.03.24.
//

import SwiftUI

struct Language: CaseIterable, Hashable, Equatable {
    let id: UUID
    let language: LocalizedStringKey
    let locale: Locale

    private init(_ language: LocalizedStringKey, locale: Locale) {
        self.id = UUID()
        self.language = language
        self.locale = locale
    }

    public static var allCases: [Language] {
        return [.english, .german]
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Language, rhs: Language) -> Bool {
        return lhs.id == rhs.id
    }

    public static let english = Language("English", locale: Locale(identifier: "en"))
    public static let german = Language("German", locale: Locale(identifier: "de"))
}

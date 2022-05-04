//
//  DataManager.swift
//  ChallengeOne
//
//  Created by Сергей Шевелев on 04.05.2022.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}


struct DataManager {
    static let savePath = FileManager.documentsDirectory.appendingPathComponent("Settings")
    
    static func loadSettings() -> Settings {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(Settings.self, from: data) {
                let cards = decoded
                return cards
            }
        }
        return Settings.example
    }
    
    static func saveSettings(_ settings: Settings) {
        if let data = try? JSONEncoder().encode(settings) {
            try? data.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
    
}

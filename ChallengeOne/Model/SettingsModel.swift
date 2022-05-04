//
//  SettingsModel.swift
//  ChallengeOne
//
//  Created by Сергей Шевелев on 04.05.2022.
//

import Foundation


struct Settings: Codable {
    var countCommands: Int
    var wordToWin: Int
    var timeToWin: Int
    var setOfWords: Int
    
    static let example = Settings(countCommands: 2, wordToWin: 20, timeToWin: 60, setOfWords: 0)
}

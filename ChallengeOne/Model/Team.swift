//
//  Team.swift
//  ChallengeOne
//
//  Created by Сергей Шевелев on 06.05.2022.
//

import Foundation

struct Team: Identifiable {
    let id = UUID()
    let name: String
    var setOfWord: Int //Набор слов
    var point: Int //Очков
    var count: Int //Кол-во вопросов
}

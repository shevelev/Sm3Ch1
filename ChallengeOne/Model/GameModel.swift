//
//  GameModel.swift
//  ChallengeOne
//
//  Created by Сергей Шевелев on 04.05.2022.
//

import Foundation

class GameModel {
    
    
    let questions = [
        ["q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m"],
        ["q1","w1","e1","r1","t1","y1","u1","i1","o1","p1","a1","s1","d1","f1","g1","h1","j1","k1","l1","z1","x1","c1","v1","b1","n1","m1"]
    ]
    
    var commands = 0

    
    var count = 0
    var point = 0
    var questNumber = 0
    
    func skip() {
        questNumber += 1
        count += 1
        point -= 1
    }
    func trueAn() {
        questNumber += 1
        count += 1
        point += 1
    }
    
    func reset() {
        questNumber = 0
        count = 0
        point = 0
    }
    
    func getWord() -> String {
        return questions[commands][questNumber]
    }
    
}

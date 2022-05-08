//
//  GameManager.swift
//  ChallengeOne
//
//  Created by Сергей Шевелев on 07.05.2022.
//

import Foundation
import AVFoundation

protocol GameManagerDelegate {
    func didUpdateGame(_ gameManager: GameManager, game: GameModel)
    func didFailWidthError(error: Error)
}

class GameManager {
    
    var delegate: GameManagerDelegate?
    var gameModel = GameModel()
    
    var player: AVAudioPlayer?
    var timer = Timer()
    
    func playSound(soundName: String) {
        guard let path = Bundle.main.path(forResource: soundName, ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func updateUI() {
        delegate?.didUpdateGame(self, game: gameModel)
    }
    
    func gameToggle() {
        gameModel.isPause.toggle()
        timerStopStart()
        getWord()
        updateUI()
    }
    
    func answerTrue() {
        gameModel.questNumber += 1
        if gameModel.isPowerWord {
            gameModel.team[gameModel.currentTeam].point += 3
        } else {
            gameModel.team[gameModel.currentTeam].point += 1
        }
        gameModel.team[gameModel.currentTeam].count += 1
        playSound(soundName: "Правильно")
        getWord()
        updateUI()
    }
    
    func answerSkip() {
        gameModel.questNumber += 1
        if !gameModel.isPowerWord {
            gameModel.team[gameModel.currentTeam].point -= 1
        } else {
            gameModel.team[gameModel.currentTeam].point -= 3
        }
        gameModel.team[gameModel.currentTeam].count += 1
        playSound(soundName: "Пропустить")
        getWord()
        updateUI()
    }
    
    func resetGame() {
        gameModel = GameModel.init()
        gameModel.isShowAlert = false
        updateUI()
    }
    
    func getWord() {
        let power = Int.random(in: 1...100)
        if power < 10 {
            gameModel.word = gameModel.questions[gameModel.settings!.setOfWords].shuffled().first!
            gameModel.isPowerWord = true
        } else {
            gameModel.word = gameModel.questions[gameModel.settings!.setOfWords].shuffled().first!
            gameModel.isPowerWord = false
        }
        
    }
    
    func showAlert() {
        if (gameModel.currentTeam + 1) < gameModel.team.count {
            gameModel.isShowAlert = true
            gameModel.alertType = 1
            gameModel.isPause = true
            updateUI()
        } else {
            if gameModel.round == 4 {
                gameModel.isShowAlert = true
                gameModel.alertType = 2
                gameModel.isPause = true
                getWinTeam()
                updateUI()
            } else {
                gameModel.isShowAlert = true
                gameModel.alertType = 3
                gameModel.isPause = true
                updateUI()
            }
        }
    }
    
    func nextTeam() {
        gameModel.isShowAlert = false
        if (gameModel.currentTeam + 1) < gameModel.team.count {
            gameModel.currentTeam += 1
        } else {
            gameModel.currentTeam = 0
        }
        
        gameModel.isPause = true
        gameModel.timeLeft = gameModel.settings?.timeToWin ?? 100
        updateUI()
    }
    
    func nextRound() {
        gameModel.isShowAlert = false
        gameModel.round += 1
        gameModel.currentTeam = 0
        gameModel.isPause = true
        gameModel.timeLeft = gameModel.settings?.timeToWin ?? 100
        updateUI()
    }
    
    func getWinTeam() {
        gameModel.winTeam = gameModel.team.sorted { t1, t2 in
            t1.point > t2.point
        }.first!.name
    }
    
    func timerStopStart() {
        
        if !gameModel.isPause {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] t in
                gameModel.timeLeft -= 1
                updateUI()
                if gameModel.timeLeft == 0 {
                    t.invalidate()
                    showAlert()
                }
            }
        } else {
            timer.invalidate()
        }
    }
}

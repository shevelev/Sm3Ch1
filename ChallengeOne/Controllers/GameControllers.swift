//
//  GameControllers.swift
//  ChallengeOne
//
//  Created by Сергей Шевелев on 02.05.2022.
//
import UIKit

class GameController: UIViewController {
    
    var gameManager = GameManager()
    var jokeManager = JokeManager()
    
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var round: UILabel!
    @IBOutlet weak var qustionCountLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var timerTextLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var jokeLabel: UILabel!
    
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Игра"
        jokeManager.delegate = self
        gameManager.delegate = self
        
        loadUI()
        gameManager.updateUI()
    }
    
    func loadUI() {
        trueButton.layer.cornerRadius = trueButton.frame.height / 2
        skipButton.layer.cornerRadius = skipButton.frame.height / 2
        resetButton.layer.cornerRadius = resetButton.frame.height / 2
        startStopButton.layer.cornerRadius = startStopButton.frame.height / 2
    }
    
    @IBAction func startStopButtonPressed(_ sender: UIButton) {
        gameManager.gameToggle()
    }
    
    @IBAction func trueButtonPressed(_ sender: UIButton) {
        gameManager.answerTrue()
        gameManager.playSound(soundName: sender.titleLabel!.text!)
    }
    
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        gameManager.answerSkip()
        gameManager.playSound(soundName: sender.titleLabel!.text!)
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        gameManager.resetGame()
    }
}

extension GameController: JokeDelegate {
    func didUpdateJoke(_ jokeModel: JokeManager, joke: JokeModel) {
        DispatchQueue.main.async {
            self.jokeLabel.text = """
Шутка
\(joke.setup)
\(joke.punchline)
"""
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension GameController: GameManagerDelegate {
    func didUpdateGame(_ gameManager: GameManager, game: GameModel) {

        teamLabel.text = game.getTeam.name
        round.text = "Раунд: \(game.round)"
        qustionCountLabel.text = "Вопрос: \(game.getTeam.count)"
        pointLabel.text = "Очки: \(game.getTeam.point)"
        wordLabel.text = game.word
        jokeLabel.text = ""
        timerTextLabel.text = "Таймер: \(game.timeLeft)"
        
        if !game.isPause {
            trueButton.isEnabled = true
            skipButton.isEnabled = true
            startStopButton.setTitle("Пауза", for: .normal)
        } else {
            trueButton.isEnabled = false
            skipButton.isEnabled = false
            startStopButton.setTitle("Старт", for: .normal)
        }
        
        if (game.isShowAlert && game.alertType == 1) {
            let dialogMessage = UIAlertController(title: "Раунд закончен", message: "Готовится следующая команда", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                self.gameManager.nextTeam()
            })
            
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        } else if (game.isShowAlert && game.alertType == 2) {
            let dialogMessage = UIAlertController(title: "Игра завершена", message: "Выиграла команда \(game.winTeam)", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                self.gameManager.resetGame()
            })
            
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        } else if (game.isShowAlert && game.alertType == 3) {
            jokeManager.performRequest()
            let dialogMessage = UIAlertController(title: "Начался следующий раунд", message: "Готовится первая команда", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                self.gameManager.nextRound()
            })
            
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
    
    func didFailWidthError(error: Error) {
        print(error)
    }
}

//
//  GameControllers.swift
//  ChallengeOne
//
//  Created by Сергей Шевелев on 02.05.2022.
//
import UIKit
import AVFoundation

class GameController: UIViewController {
    
    var gameModel = GameModel()
    var timer = Timer()
    var player: AVAudioPlayer?
    
    var timeLeft = 10
    var isPause = false

    
    @IBOutlet weak var teamLabel: UILabel!
    
    @IBOutlet weak var qustionCountLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var timerTextLabel: UILabel!
    
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Игра"
        
        //gameModel.settings = DataManager.loadSettings()
        
        loadUI()
    }
    
    func loadUI() {
        trueButton.layer.cornerRadius = trueButton.frame.height / 2
        skipButton.layer.cornerRadius = skipButton.frame.height / 2
        resetButton.layer.cornerRadius = resetButton.frame.height / 2
        startStopButton.layer.cornerRadius = startStopButton.frame.height / 2
        
        let team = gameModel.getTeam()
        
        timeLeft = gameModel.settings?.timeToWin ?? 100
        pointLabel.text = "Очки: \(team.point)"
        qustionCountLabel.text = "Вопрос: \(team.count)"
        timerTextLabel.text = "Таймер: \(self.timeLeft)"
        startStopButton.setTitle("Старт", for: .normal)
        wordLabel.text = "Отгадай слово!"
        teamLabel.text = "Команда -= 1 =-"
    }
    
    @IBAction func startStopButtonPressed(_ sender: UIButton) {
        wordLabel.text = gameModel.getWord()
        isPause.toggle()
        timerStopStart()
    }
    
    func timerStopStart() {
        if isPause {
            timerFunc()
            startStopButton.setTitle("Пауза", for: .normal)
        } else {
            startStopButton.setTitle("Старт", for: .normal)
            timer.invalidate()
        }
    }
    
    
    @IBAction func trueButtonPressed(_ sender: UIButton) {
        gameModel.trueAn()
        updateUI()
        playSound(soundName: sender.titleLabel!.text!)
        
    }
    
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        gameModel.skip()
        updateUI()
        playSound(soundName: sender.titleLabel!.text!)
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        gameModel.reset()
        startStopButton.setTitle("Старт", for: .normal)
        timer.invalidate()
        timeLeft = gameModel.settings?.timeToWin ?? 100
        timerTextLabel.text = "Таймер: \(self.timeLeft)"
        updateUI()
    }
    
    func updateUI() {
        let team = gameModel.getTeam()
        pointLabel.text = "Очки: \(team.point)"
        qustionCountLabel.text = "Вопрос: \(team.count)"
        teamLabel.text = team.name
        wordLabel.text = gameModel.getWord()
    }
    
    func timerFunc() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print("timer starts")
            
            self.timeLeft -= 1
            
            self.timerTextLabel.text = "Таймер: \(self.timeLeft)"
            
            if self.timeLeft == 0 {
                timer.invalidate()
                
                                
                self.showAlert()
            }
        }
    }
    
    
    func showAlert() {
        
        if gameModel.checkTeam() {
            let dialogMessage = UIAlertController(title: "Раунд закончен", message: "Готовится следующая команда", preferredStyle: .alert)
        
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                self.gameModel.nextTeam()
                self.startStopButton.setTitle("Старт", for: .normal)
                self.isPause = false
                self.timeLeft = self.gameModel.settings?.timeToWin ?? 100
                self.timerTextLabel.text = "Таймер: \(self.timeLeft)"
                self.updateUI()
              })
            
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        } else {
            
            let teamWin = gameModel.getWinTeam()
            
            let dialogMessage = UIAlertController(title: "Игра завершена", message: "Выиграла команда \(teamWin)", preferredStyle: .alert)
        
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                self.startStopButton.setTitle("Старт", for: .normal)
                self.isPause = false
                self.timeLeft = self.gameModel.settings?.timeToWin ?? 100
                self.timerTextLabel.text = "Таймер: \(self.timeLeft)"
                self.updateUI()
              })
            
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        }
        
        
    }
    
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
}

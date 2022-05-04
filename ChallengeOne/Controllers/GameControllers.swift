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
    var settings: Settings?
    
    var timer = Timer()

    var player: AVAudioPlayer?
    var timeLeft = 10

    
    
    @IBOutlet weak var qustionCountLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var timerTextLabel: UILabel!
    
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Игра"
        
        settings = DataManager.loadSettings()
        
        loadUI()
        

        
        trueButton.layer.cornerRadius = trueButton.frame.height / 2
        skipButton.layer.cornerRadius = skipButton.frame.height / 2
        resetButton.layer.cornerRadius = resetButton.frame.height / 2
        
        timerFunc()
        
    }
    
    func loadUI() {
        timeLeft = settings?.timeToWin ?? 100
        pointLabel.text = "Очки: \(gameModel.point)"
        qustionCountLabel.text = "Вопрос: \(gameModel.count)"
        timerTextLabel.text = "Таймер: \(self.timeLeft)"
    }
    
    @IBAction func trueButtonPressed(_ sender: UIButton) {
        gameModel.trueAn()
        updateUI()
        playSound(soundName: sender.titleLabel!.text!)
        print(sender.titleLabel!.text!)
        
    }
    
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        gameModel.skip()
        updateUI()
        playSound(soundName: sender.titleLabel!.text!)
        print(sender.titleLabel!.text!)
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        gameModel.reset()
        updateUI()

    }
    
    
    func updateUI() {
        pointLabel.text = "Очки: \(gameModel.point)"
        qustionCountLabel.text = "Вопрос: \(gameModel.count)"
        wordLabel.text = gameModel.getWord()
    }
    
    func timerFunc() {
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print("timer starts")
            
            self.timeLeft -= 1
            
            self.timerTextLabel.text = "Таймер: \(self.timeLeft)"
            
            if self.timeLeft == 0 {
                timer.invalidate()
            }
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

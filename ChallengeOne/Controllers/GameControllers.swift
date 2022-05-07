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
    @IBOutlet weak var commandLabel: UILabel!
    
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
        
        let url = "https://joke.deno.dev/"
        getData(from: url)
        
    }
    
    func loadUI() {
        timeLeft = settings?.timeToWin ?? 100
        pointLabel.text = "Очки: \(gameModel.point) / \(settings?.wordToWin ?? 100)"
        qustionCountLabel.text = "Вопрос: \(gameModel.count)"
        timerTextLabel.text = "Таймер: \(self.timeLeft)"
        commandLabel.text = "Команда: \(gameModel.commands)"
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
        pointLabel.text = "Очки: \(gameModel.point) / \(settings?.wordToWin ?? 100)"
        qustionCountLabel.text = "Вопрос: \(gameModel.count)"
        wordLabel.text = gameModel.getWord()
        commandLabel.text = "Команда: \(gameModel.commands)"
    }
    
    func getData(from url: String) {
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            //have data
            
            var results: Response?
            do {
                results = try JSONDecoder().decode(Response.self, from: data)
            }
            catch {
                print("Error occurs - \(error)")
            }
            
            guard let json = results else {
                return
            }
            
            print(json.setup)
            print(json.punchline)
        })
            
            task.resume()
        
    }
    
    func timerFunc() {
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print("timer starts")
            
            self.timeLeft -= 1
            
            self.timerTextLabel.text = "Таймер: \(self.timeLeft)"
            
            if self.timeLeft == 0 {
                timer.invalidate()
                self.performSegue(withIdentifier: "TimesUpSegue", sender: self)
                
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

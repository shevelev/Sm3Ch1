//
//  GameControllers.swift
//  ChallengeOne
//
//  Created by Сергей Шевелев on 02.05.2022.
//
import UIKit

class GameController: UIViewController {
    
    var gameModel = GameModel()
    
    var timer = Timer()
    var timeLeft = 60
    
    
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
        
        pointLabel.text = "Очки: \(gameModel.point)"
        qustionCountLabel.text = "Вопрос: \(gameModel.count)"
        
        trueButton.layer.cornerRadius = trueButton.frame.height / 2
        skipButton.layer.cornerRadius = skipButton.frame.height / 2
        resetButton.layer.cornerRadius = resetButton.frame.height / 2
        
        timerFunc()
        
        let url = "https://joke.deno.dev/"
        getData(from: url)
        
    }
    
    @IBAction func trueButtonPressed(_ sender: UIButton) {
        gameModel.trueAn()
        updateUI()
    }
    
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        gameModel.skip()
        updateUI()
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
            }
        }
    }
    
}

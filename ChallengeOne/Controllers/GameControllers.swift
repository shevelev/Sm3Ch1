//
//  GameControllers.swift
//  ChallengeOne
//
//  Created by Сергей Шевелев on 02.05.2022.
//
import UIKit

class GameController: UIViewController {
    
    var timer = Timer()
    
    var timeLeft = 10
    
    
    @IBOutlet weak var timerTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Игра"
        
        timerFunc()
        
    }
    
    func timerFunc() {
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print("timer starts")
            
            self.timeLeft -= 1
            
            self.timerTextLabel.text = String(self.timeLeft)
            print(self.timeLeft)
            
            if self.timeLeft == 0 {
                timer.invalidate()
            }
        }
    }
    
}

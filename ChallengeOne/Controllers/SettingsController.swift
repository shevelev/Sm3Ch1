//
//  SettingsController.swift
//  ChallengeOne
//
//  Created by Сергей Шевелев on 02.05.2022.
//

import UIKit

class SettingsController: UIViewController {

    @IBOutlet weak var comandCountLabel: UILabel!
    @IBOutlet weak var wordToWin: UILabel!
    @IBOutlet weak var roundTime: UILabel!
    
    @IBOutlet weak var wordSlider: UISlider!
    @IBOutlet weak var timeSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Настройки"
        wordToWin.text = String(format: "%.0f", wordSlider.value)
        roundTime.text = String(format: "%.0f", timeSlider.value)
    }
    
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        comandCountLabel.text = String(format: "%.0f", sender.value)
    }
    
    @IBAction func wordSliderPressed(_ sender: UISlider) {
        wordToWin.text = String(format: "%.0f", sender.value)
    }
    
    @IBAction func timeRoundSliderPressed(_ sender: UISlider) {
        roundTime.text = String(format: "%.0f", sender.value)
    }
    
}

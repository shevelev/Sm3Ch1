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
        
    var settings: Settings?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Настройки"
        self.settings = DataManager.loadSettings()
        
        updateUI()
    }
    
    func updateUI() {
        if let setting = settings {
            wordToWin.text = "\(setting.wordToWin)"
            roundTime.text = "\(setting.timeToWin)"
            comandCountLabel.text = "\(setting.countCommands)"
            
            wordSlider.value = Float(setting.wordToWin)
            timeSlider.value = Float(setting.timeToWin)    
        }
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        comandCountLabel.text = String(format: "%.0f", sender.value)
        settings?.countCommands = Int(sender.value)
    }
    
    @IBAction func wordSliderPressed(_ sender: UISlider) {
        wordToWin.text = String(format: "%.0f", sender.value)
        settings?.wordToWin = Int(sender.value)
    }
    
    @IBAction func timeRoundSliderPressed(_ sender: UISlider) {
        roundTime.text = String(format: "%.0f", sender.value)
        settings?.timeToWin = Int(sender.value)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        DataManager.saveSettings(settings!)
    }
}

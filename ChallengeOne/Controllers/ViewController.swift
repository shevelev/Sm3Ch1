//
//  ViewController.swift
//  ChallengeOne
//
//  Created by Сергей Шевелев on 01.05.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var gameButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var aboutGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        gameButton.layer.cornerRadius = gameButton.frame.height / 2
        settingsButton.layer.cornerRadius = settingsButton.frame.height / 2
        aboutGameButton.layer.cornerRadius = aboutGameButton.frame.height / 2
    }


}


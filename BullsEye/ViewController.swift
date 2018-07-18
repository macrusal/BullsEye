//
//  ViewController.swift
//  BullsEye
//
//  Created by Marcelo on 05/07/2018.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentValue = 0;
    var targetValue = 0;
    var score = 0;
    var round = 0;
    
    @IBOutlet weak var slider: UISlider!;
    @IBOutlet weak var targetLabel: UILabel!;
    @IBOutlet weak var scoreLabel: UILabel!;
    @IBOutlet weak var roundLabel: UILabel!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = lroundf(slider.value)
        startNewGame()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage?.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftImage, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")
        let trackRightResizable = trackRightImage?.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightImage, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
        print("O valor do slider é: \(slider.value)")
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func showAlert() {
        
        let difference = abs(currentValue - targetValue)
        let title: String
        var points = 100 - difference
        
        if (difference == 0) {
            title = "Perfeito"
            points += 100
        } else if (difference < 5) {
            title = "Muito bom"
            if(difference == 1){
                points += 50
            }
        } else if (difference < 10) {
            title = "Tente novamente"
        } else {
            title = "Nem chegou perto"
        }
        
        score += points
        
        let message = "Pontos \(points)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Fechar", style: .default, handler: {
            action in
            self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue);
        scoreLabel.text = String(score);
        roundLabel.text = String(round);
    }
    
}


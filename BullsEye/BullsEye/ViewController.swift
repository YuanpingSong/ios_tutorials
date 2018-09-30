//
//  ViewController.swift
//  BullsEye
//
//  Created by imac on 2017/6/22.
//  Copyright © 2017年 Individual. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    // MARK: Properties
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        updateLabels()
        
        // Configure the slider
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsetsMake(0, 14, 0, 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    func startNewRound() {
        // Generate new target value, center current value, and increment round count
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        round += 1
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func startNewGame(){
        score = 0
        round = 0
        startNewRound()
    }
    
    // MARK: Actions

    // Called after the button is hit
    @IBAction func showAlert(){
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        let title: String
        
        // Dynamically changing the title of the alert popup
        switch difference {
        case 0:
            title = "Perfect"
            points += 100
        case 1:
            points += 50
            fallthrough
        case 2..<5:
            title = "You almost had it!"
        case 5..<10:
            title = "Pretty good!"
        default:
            title = "Not even close"
        }
        
        score += points
        
        let message = "You scored \(points) points"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler:
        {action in
            self.startNewRound()
            self.updateLabels()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // Called whenever the slider moves to update the instance property
    @IBAction func sliderMoved(_ slider: UISlider){
        currentValue = lrintf(slider.value)
    }
    
    // Called when the restart button is pressed and applies an animation.
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
    }


}


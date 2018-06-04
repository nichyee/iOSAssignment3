//
//  SettingViewController.swift
//  360 NoScope
//
//  Created by Ronnie El-Alam on 14/5/18.
//  Copyright © 2018 Ronnie El-Alam. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
var audioPlayer:AVAudioPlayer?

class SettingViewController: UIViewController{
    
    @IBOutlet var difficultyLabel: UILabel!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var muteSwitch: UISwitch!
    @IBOutlet weak var onLabel: UILabel!
    @IBOutlet weak var offLabel: UILabel!
    
    var difficultyValue : Int = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDifficulty()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBackToMenu(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToMenu", sender: self)
    }
    
    @IBAction func increaseDifficulty(_ sender: Any) {
        if(difficultyValue < 2 )
        {
            difficultyValue += 1
            print(difficultyValue)
            updateDifficulty()
        }
    }
    
    @IBAction func decreaseDifficulty(_ sender: Any) {
        if(difficultyValue > 0)
        {
            difficultyValue -= 1
            print(difficultyValue)
            updateDifficulty()
        }
        
    }
    
    @IBAction func sliderValuePrint(_ sender: UISlider) {
        print(Int(sender.value))
    }
    func updateDifficulty() {
        switch difficultyValue {
        case 0:
            difficultyLabel.text = "Easy"
            downButton.isEnabled = false
        case 2:
            difficultyLabel.text = "Hard"
            upButton.isEnabled = false
        default:
            difficultyLabel.text = "Medium"
            upButton.isEnabled = true
            downButton.isEnabled = true
        }
    }
    
    @IBAction func activateMute(_ sender: UISwitch) {
        if (sender.isOn) {
            offLabel.isEnabled = false
            onLabel.isEnabled = true
            MusicHelper.sharedHelper.muteMusic(trueFalse: sender.isOn)
        } else if (sender.isOn == false) {
            offLabel.isEnabled = true
            onLabel.isEnabled = false
            MusicHelper.sharedHelper.muteMusic(trueFalse: sender.isOn)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sendDifficulty = difficultyValue
        if (segue.identifier == "unwindSegueToMenu") {
            if let viewController = segue.destination as? MenuViewController {
                viewController.diffucultyValue = sendDifficulty
            }
        }
    }
    
    
    
}



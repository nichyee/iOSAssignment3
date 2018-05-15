//
//  SettingViewController.swift
//  360 NoScope
//
//  Created by Ronnie El-Alam on 14/5/18.
//  Copyright © 2018 Ronnie El-Alam. All rights reserved.
//

import Foundation
import UIKit

class SettingViewController: UIViewController{
    
    @IBOutlet var difficultyLabel: UILabel!
    @IBOutlet var difficultySlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBackToMenu(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToMenu", sender: self)
    }
    
    
    @IBAction func difficultySliderChange(_ sender: UISlider) {
        let value = Int(sender.value)
        switch value {
        case 0:
            difficultyLabel.text = "Easy"
        case 2:
            difficultyLabel.text = "Hard"
        default:
            difficultyLabel.text = "Medium"
        }
        
    }
    
    
    //ToDo
    //Make label say what difficulty is.
}

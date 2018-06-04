//
//  MenuViewController.swift
//  360 NoScope
//
//  Created by Ronnie El-Alam on 14/5/18.
//  Copyright © 2018 Ronnie El-Alam. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController : UIViewController {
    
    var diffucultyValue = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToMenu(segue:UIStoryboardSegue){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sendDifficulty = diffucultyValue
        if (segue.identifier == "settings") {
            if let viewController = segue.destination as? SettingViewController {
                viewController.difficultyValue = sendDifficulty
            }
        }
        if (segue.identifier == "game") {
            if let viewController = segue.destination as? GameViewController {
                viewController.difficultyValue = sendDifficulty
            }
        }

    }
}

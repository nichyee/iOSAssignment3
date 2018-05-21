//
//  GameViewController.swift
//  360_NoScope
//
//  Created by Ronnie El-Alam on 21/5/18.
//  Copyright © 2018 Ronnie El-Alam. All rights reserved.
//

import Foundation
import ARKit

class GameViewController: UIViewController{
    
    var sceneView: ARSKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as? ARSKView? {
            sceneView = view
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
}

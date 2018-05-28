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
        
        if let view = self.view as? ARSKView {
            sceneView = view
            sceneView!.delegate = self
            let scene = GameScene(size: view.bounds.size)
            scene.scaleMode = .resizeFill
            scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            view.presentScene(scene)
            view.showsFPS = true
            view.showsNodeCount = true
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
extension GameViewController :ARSKViewDelegate {
    func session(_session: ARSession, didFailWithError error: Error){
        print("Session failed")
    }
    func sessionWasInterrupted(_ session: ARSession) {
        print("session Interrupted")
    }
    func sessionInterruptionEnded(_ session: ARSession) {
        print("Session Resumed")
        sceneView.session.run(session.configuration!, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func view(_ view: ARSKView,
              nodeFor anchor: ARAnchor) -> SKNode? {
        let enemy = SKSpriteNode(imageNamed: "enemy")
        enemy.name = "enemy"
        return enemy
    }
}

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
    var timer = Timer()
    var times = 30
    @IBOutlet weak var timeLabel: UILabel!
    var scene = GameScene()
    var numEnemies = Int()
    var difficultyValue = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets up the timer for the game
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats:true)
        timeLabel.text = String(times)
        
        //sets up the
        if let view = self.view as? ARSKView {
            sceneView = view
            sceneView!.delegate = self
            scene = GameScene(size: view.bounds.size)
            scene.scaleMode = .resizeFill
            scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            view.presentScene(scene)
            view.showsFPS = true
            view.showsNodeCount = true
        }
        scene.difficultValue = difficultyValue
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    //what happens every second
    @objc func tick() {
        if (times == 0) {
            timer.invalidate()
            let score = scene.hits * 5
            let alert = UIAlertController(title: "Game Over", message: "Congrats! Your score was \(score)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Home", style: .default, handler: {
                action in
                self.performSegue(withIdentifier: "home", sender: self)
            }))
            self.present(alert, animated: true)
        } else {
            times -= 1
            timeLabel.text = String(times)
            if (times > 3) {
                scene.generateEnemies()
            }
        }
    }
    
    //preparing for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sendDifficulty = difficultyValue
        if (segue.identifier == "home") {
            if let viewController = segue.destination as? MenuViewController {
                viewController.diffucultyValue = sendDifficulty
            }
        }
    }


    
}
//Required Extension
extension GameViewController :ARSKViewDelegate {
    //If game didn't launch
    func session(_session: ARSession, didFailWithError error: Error){
        print("Session failed")
    }
    //when the app is closed by user
    func sessionWasInterrupted(_ session: ARSession) {
        print("session Interrupted")
    }
    //when the app is resumed by user
    func sessionInterruptionEnded(_ session: ARSession) {
        print("Session Resumed")
        sceneView.session.run(session.configuration!, options: [.resetTracking, .removeExistingAnchors])
    }
    
    //send the image created from the spritenode
    func view(_ view: ARSKView,
              nodeFor anchor: ARAnchor) -> SKNode? {
        let enemy = SKSpriteNode(imageNamed: "enemy")
        enemy.name = "enemy"
        return enemy
    }
    
}

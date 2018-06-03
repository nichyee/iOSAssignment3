//
//  GameScene.swift
//  360_NoScope
//
//  Created by Ronnie El-Alam on 22/5/18.
//  Copyright © 2018 Ronnie El-Alam. All rights reserved.
//

import Foundation
import SpriteKit
import ARKit
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var sceneView: ARSKView {
        return view as! ARSKView
    }
    var isWorldSetup = false
    let gameSize = CGSize(width: 2, height: 2)
    var sight: SKSpriteNode!
    
    
    private func setUp() {
        guard let currentFrame = sceneView.session.currentFrame
            else {
                return
                
        }
        
        //creating a scene so we can place our objects
        let scene = SKScene(size: CGSize(width: 350, height: 350))

        //generating 10 of them at random positions
        let val = 10
        for _ in 0...val {
            
            //randomly find a position thats within screen bounds and place them onto the screen
            //(essentially they float in the air)
            var translation = matrix_identity_float4x4
            let positionX = randomFloat(Min: -350, Max: 350) / Float(scene.size.width)
            let positionY = randomFloat(Min: -350, Max: 350) / Float(scene.size.width)
            translation.columns.3.x = Float(positionX * Float(gameSize.width))
            translation.columns.3.z = -Float(positionY * Float(gameSize.height))
            let transform = currentFrame.camera.transform * translation
            let anchor = ARAnchor(transform: transform)
            sceneView.session.add(anchor: anchor)
            
        }
            //translation.columns.3.z = -0.3

        
        isWorldSetup = true
        //print(isWorldSetup)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if !isWorldSetup {
            setUp()
        }
        
        // 1
        guard let currentFrame = sceneView.session.currentFrame,
            let lightEstimate = currentFrame.lightEstimate else {
                return
        }
        
        // 2
        let neutralIntensity: CGFloat = 1000
        let ambientIntensity = min(lightEstimate.ambientIntensity,
                                   neutralIntensity)
        let blendFactor = 1 - ambientIntensity / neutralIntensity
        
        // 3
        for node in children {
            if let bug = node as? SKSpriteNode {
                bug.color = .black
                bug.colorBlendFactor = blendFactor
            }
        }
    }
    
    //return us a float between the two numbers we gave it
    func randomFloat(Min: Float, Max: Float) -> Float {
        return Min+(Max-Min)*(Float(arc4random())) / Float(UINT32_MAX)
    }
    
    
    override func didMove(to view: SKView) {
        sight = SKSpriteNode(imageNamed: "sight")
        addChild(sight)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        print("Touching Screen")
        let location = sight.position
        let hitNodes = nodes(at: location)
        var hitBug: SKNode?
        for node in hitNodes {
            if node.name == "enemy" {
                hitBug = node
                break
            }
        }
        
        if let hitBug = hitBug,
            let anchor = sceneView.anchor(for: hitBug) {
            let action = SKAction.run {
                self.sceneView.session.remove(anchor: anchor)
            }
            hitBug.run(action)
        }

    }
    
}


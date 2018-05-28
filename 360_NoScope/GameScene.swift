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
    
    
    
    private func setUp() {
        guard let currentFrame = sceneView.session.currentFrame
            else {
                return
                
        }
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -0.3
        let transform = currentFrame.camera.transform * translation
        let anchor = ARAnchor(transform: transform)
        sceneView.session.add(anchor: anchor)
        isWorldSetup = true
        print(isWorldSetup)
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
    
}


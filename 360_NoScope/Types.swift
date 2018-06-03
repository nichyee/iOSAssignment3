//
//  Types.swift
//  360_NoScope
//
//  Created by Ronnie El-Alam on 2/6/18.
//  Copyright © 2018 Ronnie El-Alam. All rights reserved.
//

import Foundation
import SpriteKit

enum Sounds {
    static let fire =      SKAction.playSoundFileNamed("sprayBug",
                                                       waitForCompletion: false)
    static let hit =       SKAction.playSoundFileNamed("hitBug",
                                                       waitForCompletion: false)
    static let bugspray =  SKAction.playSoundFileNamed("catchBugspray",
                                                       waitForCompletion: false)
    static let win =       SKAction.playSoundFileNamed("win.wav",
                                                       waitForCompletion: false)
    static let lose =      SKAction.playSoundFileNamed("lose.wav",
                                                       waitForCompletion: false)
}

//
//  MusicHelper.swift
//  360_NoScope
//
//  Created by Nicholas Yee on 19/5/18.
//  Copyright © 2018 Ronnie El-Alam. All rights reserved.
//

import Foundation
import AVFoundation

class MusicHelper{
    static let sharedHelper = MusicHelper()
    var audioPlayer: AVAudioPlayer?
    let aSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "bensound-buddy", ofType: "mp3")!)
    //Music: https://www.bensound.com Found at: https://www.bensound.com/royalty-free-music/track/buddy
    
    func playBackgroundMusic() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:aSound as URL)
            audioPlayer!.numberOfLoops = -1
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        } catch {
            print("Cannot play the file")
        }
    }
    
    func muteMusic(trueFalse: Bool){
        if (trueFalse) {
            audioPlayer!.volume = 1.0
        } else if (trueFalse == false) {
            audioPlayer!.volume = 0.0
        }
    }
    
}

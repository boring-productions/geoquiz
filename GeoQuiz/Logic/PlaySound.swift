//
//  PlaySound.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 22/9/22.
//

import Foundation
import AVFAudio
import UIKit

class Sound {
    private var player: AVAudioPlayer?
    
    func play(_ filename: String) {
        guard let soundFileURL = Bundle.main.url(forResource: filename, withExtension: "wav") else {
            fatalError("Sound file \(filename) couldn't be found")
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            fatalError("Couldn't activate session")
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: soundFileURL)
            player?.play()
        } catch {
            fatalError("Couldn't play sound effect")
        }
    }
}


//
//  PlaySound.swift
//  Slot-machine
//
//  Created by yeomim kim on 2023/03/21.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("ERROR: 음향파일을 찾을수 없습니다")
        }
    }
}


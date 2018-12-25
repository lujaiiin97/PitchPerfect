//
//  PlaySoundViewController.swift
//  try
//
//  Created by MAC on 29/10/2018.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import AVFoundation
class PlaySoundViewController: UIViewController {
    @IBOutlet weak var slowOutlet: UIButton!
    @IBOutlet weak var rabbitOutlet: UIButton!
    @IBOutlet weak var highPichOutlet: UIButton!
    @IBOutlet weak var lowPitchOutlet: UIButton!
    @IBOutlet weak var echoOutlet: UIButton!
    @IBOutlet weak var reverbOutlet: UIButton!
    @IBOutlet weak var stopOutlet: UIButton!
    
    
    
    var recordedAudio: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, HighPitch, lowPitch, Echo, Reverb
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton){
        
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .HighPitch:
            playSound(pitch: 1000)
        case .lowPitch:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: Any){
        
        stopAudio()
    }
    
    
}

//
//  RecoredSoundViewController.swift.swift
//  PitchPerfect
//
//  Created by MAC on 27/10/2018.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import AVFoundation

class RecoredSoundViewController: UIViewController , AVAudioRecorderDelegate  {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    
    @IBOutlet weak var TapLabel: UILabel!
    
    @IBOutlet weak var recoredoutlet: UIButton!
    @IBOutlet weak var stopReOutlet: UIButton!
    var audioRecorder: AVAudioRecorder!
    
    
    
    func setup(isRecording: Bool) {
        if isRecording {
            TapLabel.text = "Recording in Progress..."
            stopReOutlet.isEnabled = true
            recoredoutlet.isEnabled = false
        }
        else {
            TapLabel.text = "Tap to Record"
            recoredoutlet.isEnabled = true
            stopReOutlet.isEnabled = false
        }
    }
    
    @IBAction func RecoredFun(_ sender: Any) {
        setup(isRecording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: .mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error)
        }
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    
    @IBAction func stopAction(_ sender: Any) {
        
        setup(isRecording: false)
        audioRecorder.stop()
        let audiosession = AVAudioSession.sharedInstance()
        try! audiosession.setActive(false)
    }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "next" , sender: audioRecorder.url)
            
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "next"
        {
            let playSoundVC = segue.destination as! PlaySoundViewController
            let recordedAudioURL = sender as! URL
            
            playSoundVC.recordedAudio = recordedAudioURL
            
        }
    }
    
}


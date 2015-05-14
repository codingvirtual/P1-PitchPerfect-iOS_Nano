//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Greg Palen on 5/13/15.
//  Copyright (c) 2015 codingvirtual. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var soundPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        soundPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        soundPlayer.enableRate = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func PlaySlowAudio(sender: UIButton) {
        playSoundAtRate(0.5)
    }
    
    @IBAction func PlayFastAudio(sender: UIButton) {
        playSoundAtRate(1.5)
    }
    
    @IBAction func PlayChipmunk(sender: UIButton) {
        playSoundWithPitch(1000)
    }
    
    
    @IBAction func PlayDarth(sender: UIButton) {
        playSoundWithPitch(-1000)
    }
    
    
    @IBAction func StopAudio(sender: UIButton) {
        soundPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playSoundAtRate(rate:Float) {
        soundPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        soundPlayer.currentTime = 0.0
        soundPlayer.rate = rate
        soundPlayer.play()
    }
    
    func playSoundWithPitch(pitch:Float) {
        soundPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
}

//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Greg Palen on 5/13/15.
//  Copyright (c) 2015 codingvirtual. All rights reserved.
//
//  Project 1 in the Udacity iOS Nanodegree
//  An app that allows you to record your voice (or some other ambient sound)
//  and then play it back with one of four sound effects/alterations:
//  - Increase / decrease playback rate
//  - Increase / decrease playback pitch
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var soundPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!    // the recorded audio being passed in after a recording has finished.
                                        // Must be populated in order to play the recorded audio.
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    //  OS callback indicating view has loaded.
    override func viewDidLoad() {
        super.viewDidLoad()
        //  set up AVAudioEngine for playback of the file passed to the view via receivedAudio
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        //  set up sound player and enable rate modifications (required for Chipmunk and Darth Vader effects)
        soundPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        soundPlayer.enableRate = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //  Function called when user taps the snail icon (play slow)
    @IBAction func PlaySlowAudio(sender: UIButton) {
        // Play the sound at 50% speed
        playSoundAtRate(0.5)
    }
    
    //  Function called when user taps the rabbit icon (play fast)
    @IBAction func PlayFastAudio(sender: UIButton) {
        // Play the sound at 150% speed
        playSoundAtRate(1.5)
    }
    
    //  Function called when user taps the chipmunk icon (play at a high pitch)
    @IBAction func PlayChipmunk(sender: UIButton) {
        //  Play with sound at pitch elevated to 1000. NOTE: Playing at 0 would be
        //  playback at the "normal" rate
        playSoundWithPitch(1000)
    }
    
    //  Function called when user taps the darth icon (play at a low pitch)
    @IBAction func PlayDarth(sender: UIButton) {
        //  Play with sound at pitch reduced to -1000. NOTE: Playing at 0 would be
        //  playback at the "normal" rate
        playSoundWithPitch(-1000)
    }
    
    
    // Function called when user taps the Stop button at the bottom of the UI. All playback stops.
    @IBAction func StopAudio(sender: UIButton) {
        //  Stop playback of both the sound player and the audio engine (for modifications), then reset
        //  engine for next playback.
        soundPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    //  Utility function for playing a sound at a specific speed. The rate is passed in to the function
    //  at invocation. A rate of 1.0 constitutes playback at the "normal" speed. Lower than 1.0 will play
    //  back at a slower speed, >1.0 will play back faster.
    func playSoundAtRate(rate:Float) {
        //  Stop playback of both the sound player and the audio engine (for modifications), then reset
        //  engine for next playback.
        soundPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        //  Reset the current audio position to the start of the track.
        soundPlayer.currentTime = 0.0
        //  Set the player to play at the indicated rate
        soundPlayer.rate = rate
        //  Play the sound
        soundPlayer.play()
    }
    
    //  Utility function for playing a sound with a modified pitch. The pitch is passed in to the function
    //  at invocation. A pitch of 0.0 constitutes playback at the "normal" speed. Negative values will play
    //  back at a lower pitch ("deeper voice"), positive values play back at a higher pitch ("higher voice").
    func playSoundWithPitch(pitch:Float) {
        //  Stop playback of both the sound player and the audio engine (for modifications), then reset
        //  engine for next playback.
        soundPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        //  Set up audio engine to enable modifiying the pitch for playback
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        //  Connect the engine to the playback node
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)

        //  Prepare to play the file now.
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        //  Play the file
        audioPlayerNode.play()
    }
    
}

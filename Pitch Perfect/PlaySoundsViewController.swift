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
        // Do any additional setup after loading the view.
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
//        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
//            var filePathUrl = NSURL.fileURLWithPath(filePath)
//
//            
//        } else {
//            println("The filePath is empty")
//        }
        
        soundPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        soundPlayer.enableRate = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    }
    
    func playSoundAtRate(rate:Float) {
        soundPlayer.stop()
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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

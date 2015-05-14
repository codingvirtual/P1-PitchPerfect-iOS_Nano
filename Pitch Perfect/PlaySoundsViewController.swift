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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
            var filePathUrl = NSURL.fileURLWithPath(filePath)
            soundPlayer = AVAudioPlayer(contentsOfURL: filePathUrl, error: nil)
            soundPlayer.enableRate = true
            
        } else {
            println("The filePath is empty")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func PlaySlowAudio(sender: UIButton) {
        
        soundPlayer.stop()
        soundPlayer.currentTime = 0.0
        soundPlayer.rate = 0.5
        soundPlayer.play()
        
        
    }
    
    @IBAction func PlayFastAudio(sender: UIButton) {
        
        soundPlayer.stop()
        soundPlayer.currentTime = 0.0
        soundPlayer.rate = 1.5
        soundPlayer.play()
        
    }
    
    @IBAction func StopAudio(sender: UIButton) {
        soundPlayer.stop()
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

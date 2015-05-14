//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Greg Palen on 5/12/15.
//  Copyright (c) 2015 codingvirtual. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingInProgress: UILabel!
    
    @IBOutlet weak var stopRecording: UIButton!
    
    @IBOutlet weak var startRecording: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopRecording.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        recordingInProgress.hidden = false
        stopRecording.hidden = false
        startRecording.enabled = false
        //TODO: Record the user's voice
        println("in recordAudio")
    }

    @IBAction func stopAudio(sender: UIButton) {
        recordingInProgress.hidden = true
        stopRecording.hidden = true
        startRecording.enabled = true
        //TODO: stop recording audio
    }

}


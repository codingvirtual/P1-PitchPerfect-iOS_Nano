//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Greg Palen on 5/12/15.
//  Copyright (c) 2015 codingvirtual. All rights reserved.
//
//  Project 1 in the Udacity iOS Nanodegree
//  An app that allows you to record your voice (or some other ambient sound)
//  and then play it back with one of four sound effects/alterations:
//  - Increase / decrease playback rate
//  - Increase / decrease playback pitch
//
//  This is the Controller associated with the RecordAudio view. This controller supports
//  the recording of a new sound by the user and features a microphone in the middle of
//  the screen and a stop button that appears after recording begins. A label below the mic
//  indicates the current status ("Tap to Record" or "Recording in Progress"
//  When the user stops recording, the file is saved and control is passed to the playback
//  screen where the user can hear the audio.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!

    @IBOutlet weak var recordingInProgress: UILabel!    // label indicates progress/status
    
    @IBOutlet weak var stopRecording: UIButton!         // button to stop recording. Hidden initially
    
    @IBOutlet weak var startRecording: UIButton!        // Mic button. Enabled initially.
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        recordingInProgress.text = "Tap to Record"  // Set the progress text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // This function is called when the mic button is tapped. It supports recording the user's audio
    @IBAction func recordAudio(sender: UIButton) {
        // Manipulate UI to show recording state. Update label, reveal stop button, disable mic button
        recordingInProgress.text = "Recording in progress..."
        stopRecording.hidden = false
        startRecording.enabled = false
        
        // Get the path to the app directory for storing the file
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        // Use the date to create a unique filename
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        // Prepare AVAudioRecorder and start recording
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self;
        audioRecorder.meteringEnabled = true
        audioRecorder.record()
    }

    //  This function is called when the user taps the stop button.
    @IBAction func stopAudio(sender: UIButton) {
        // Manipulate UI. Hide stop button
        stopRecording.hidden = true
        
        // Stop recording and reset recorder resources
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    //  This function is called as a result of being an AVAudioRecorderDelegate. When audio stops
    //  recording, this callback is dispatched.
    //  Stop the audio, update the UI accordingly.
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag) {
            // Update the UI to reflect that recording has stopped and state is reset.
            recordingInProgress.text = "Tap to Record"
            startRecording.enabled = true
            
            //  Extract recording info and instantiate object to pass to playback screen, then segue to
            //  playback.
            recordedAudio = RecordedAudio(url: recorder.url, title: recorder.url.lastPathComponent!)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            //  Failure of some form. Log the fact and reset the UI to try again.
            println("recording failed")
            recordingInProgress.text = "Tap to Record"
            startRecording.enabled = true
        }
    }
    
    //  Callback function that is called prior to a seque to another
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            // If the segue is the "stopRecording" segue, set up to transition to the playback screen
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            //  set up the audio object and attach to the playback screen's property
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }

}


//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Greg Palen on 5/14/15.
//  Copyright (c) 2015 codingvirtual. All rights reserved.
//
//  Project 1 in the Udacity iOS Nanodegree
//  An app that allows you to record your voice (or some other ambient sound)
//  and then play it back with one of four sound effects/alterations:
//  - Increase / decrease playback rate
//  - Increase / decrease playback pitch
//
//  This class represents a file of audio that the user just recorded.
//  The file would be stored on the device after recording. This class is
//  instantiated and populated with the title (name) of the file and the
//  full path to it's location. It is used primarly to pass a reference
//  from the screen where audio is recorded to the screen where audio is
//  played back.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!             // the full path to the file on the device
    var title: String!                  // the filename of the file (last component of full path)
    
    init(url:NSURL, title:String) {
        self.filePathUrl = url;
        self.title = title;
    }
}
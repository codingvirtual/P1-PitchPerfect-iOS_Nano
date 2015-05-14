//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Greg Palen on 5/14/15.
//  Copyright (c) 2015 codingvirtual. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(url:NSURL, title:String) {
        self.filePathUrl = url;
        self.title = title;
    }
}
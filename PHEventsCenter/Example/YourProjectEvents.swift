//
//  YourProjectEvents.swift
//  PHEventsCenter
//
//  Created by Andrew Zhdanov on 30.11.15.
//  Copyright © 2015 Andrew Zhdanov. All rights reserved.
//

import Foundation

class BobEvent : PHBasicEvent {
    var info: String
    
    init(infoForBob: String) {
        self.info = infoForBob
        super.init()
    }
}

class KevinEvent : PHBasicEvent {
    var info: String
    
    init(infoForKevin: String) {
        self.info = infoForKevin
        super.init()
    }
}

class CommonEvent : PHBasicEvent {
    var info: String
    
    init(info: String) {
        self.info = info
        super.init()
    }
}